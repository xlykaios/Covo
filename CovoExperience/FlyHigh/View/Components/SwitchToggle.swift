import SwiftUI
import AVFoundation

struct SwitchToggle: UIViewControllerRepresentable {
    @Binding var noiseLevel: Float
    @Binding var fillVariable: Float
    @Binding var navigateToSession: Bool

    class Coordinator: NSObject, AVAudioRecorderDelegate {
        var parent: SwitchToggle
        var audioMonitor: AudioMonitor?
        var imageView: UIImageView?
        
        init(_ parent: SwitchToggle) {
            self.parent = parent
        }
        
        @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
            guard let imageView = gesture.view else { return }
            let translation = gesture.translation(in: imageView.superview)
            let maxTranslationY: CGFloat = -200 // Limita il movimento massimo verso l'alto
            let limitedTranslationY = max(translation.y, maxTranslationY)
            let scaleFactor = 1 + (abs(limitedTranslationY) / 180) // Il fattore di scala aumenta con il movimento verso l'alto

            // Costante di spostamento sull'asse X
            let maxTranslationX: CGFloat = 35
            let progress = abs(limitedTranslationY / maxTranslationY) // Progresso del movimento sull'asse Y
            let translationX = maxTranslationX * progress
            
            if gesture.state == .changed {
                if translation.y < 0 {
                    imageView.transform = CGAffineTransform(translationX: translationX, y: limitedTranslationY).scaledBy(x: scaleFactor, y: scaleFactor)
                }
            } else if gesture.state == .ended {
                if limitedTranslationY == maxTranslationY {
                    startMonitoring()
                    imageView.isUserInteractionEnabled = true
                } else {
                    UIView.animate(withDuration: 0.3) {
                        imageView.transform = .identity
                    }
                    stopMonitoring()
                }
            }
        }
        
        private func startMonitoring() {
            audioMonitor = AudioMonitor(threshold: -10)
            parent.noiseLevel = -80
            audioMonitor?.noiseLevel = -80
            audioMonitor?.levelTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.parent.noiseLevel = self.audioMonitor?.noiseLevel ?? 0
                
                if self.parent.noiseLevel >= -20 {
                    self.parent.fillVariable = min(self.parent.fillVariable + 0.5, 100)
                } else {
                    self.parent.fillVariable = max(self.parent.fillVariable - 0.25, 0)
                }
                
                if self.parent.fillVariable >= 100 {
                    self.stopMonitoring()
                    DispatchQueue.main.async {
                        self.parent.navigateToSession = true
                        self.parent.fillVariable = 0 // Reset fillVariable
                    }
                }
            }
        }
        
        private func stopMonitoring() {
            audioMonitor?.stopMonitoring()
            audioMonitor = nil
            if let imageView = imageView {
                UIView.animate(withDuration: 0.3) {
                    imageView.transform = .identity
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let imageView = UIImageView(image: UIImage(named: "cannetta")) // Assumendo che "cannetta" sia l'immagine
        context.coordinator.imageView = imageView
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 240),
            imageView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 170)
        ])
        
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePanGesture(_:)))
        imageView.addGestureRecognizer(panGesture)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ContentView: View {
    @State private var noiseLevel: Float = 0
    @State private var fillVariable: Float = 0
    @State private var navigateToSession = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Livello di rumore: \(noiseLevel, specifier: "%.2f") dB")
                    .font(.headline)
                    .padding()
                
                ProgressView(value: fillVariable, total: 100)
                    .padding()
                
                SwitchToggle(noiseLevel: $noiseLevel, fillVariable: $fillVariable, navigateToSession: $navigateToSession)
                    .navigationDestination(isPresented: $navigateToSession) {
                        FumataSession()
                    }
            }
            .navigationTitle("Monitoraggio")
        }
    }
}


#Preview {
    ContentView()
}
