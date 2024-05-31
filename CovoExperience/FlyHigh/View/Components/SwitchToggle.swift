import SwiftUI
import AVFoundation

struct SwitchToggle: UIViewControllerRepresentable {
    @Binding var noiseLevel: Float
    @State private var fillVariable: Float = 0 // Variabile che si riempie in base al rumore captato
    
    class Coordinator: NSObject, AVAudioRecorderDelegate {
        var parent: SwitchToggle
        var audioMonitor: AudioMonitor?
        
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
        
        // Inizia a monitorare l'audio
        private func startMonitoring() {
            audioMonitor = AudioMonitor(threshold: -10)
            parent.noiseLevel = -80
            audioMonitor?.noiseLevel = -80
            audioMonitor?.levelTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.parent.noiseLevel = self.audioMonitor?.noiseLevel ?? 0
                
                if self.parent.noiseLevel >= -10 {
                    // Incrementa la variabile se il rumore captato è maggiore o uguale a -10 decibel
                    self.parent.fillVariable = min(self.parent.fillVariable + 0.5, 100)
                } else {
                    // Decrementa la variabile se il rumore captato è minore di -10 decibel
                    self.parent.fillVariable = max(self.parent.fillVariable - 0.25, 0)
                }
                
                if self.parent.fillVariable >= 100 {
                    self.stopMonitoring()
                }
            }
        }
        
        // Ferma il monitoraggio dell'audio
        private func stopMonitoring() {
            audioMonitor?.stopMonitoring()
            audioMonitor = nil
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let imageView = UIImageView(image: UIImage(named: "cannetta")) // Assumendo che "cannetta" sia l'immagine
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 70),  // Più stretto
            imageView.heightAnchor.constraint(equalToConstant: 240),  // Più lungo
            imageView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 170)  // Posizionato in basso
        ])
        
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePanGesture(_:)))
        imageView.addGestureRecognizer(panGesture)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    homepage()
}
