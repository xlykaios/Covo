import SwiftUI
import AVFoundation

struct SwitchToggle: UIViewControllerRepresentable {
    @Binding var noiseLevel: Float
    
    class Coordinator: NSObject, AVAudioRecorderDelegate {
        var parent: SwitchToggle
        var audioMonitor: AudioMonitor?
        
        init(_ parent: SwitchToggle) {
            self.parent = parent
        }
        
        @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
            guard let imageView = gesture.view else { return }
            let translation = gesture.translation(in: imageView.superview)
            let maxTranslation: CGFloat = -200 // Limit the maximum upward movement
            let limitedTranslation = max(translation.y, maxTranslation)
            let scaleFactor = 1 + (abs(limitedTranslation) / 180) // Scale factor increases with upward movement
            
            
            if gesture.state == .changed {
                if translation.y < 0 {
                    imageView.transform = CGAffineTransform(translationX: 0, y: limitedTranslation).scaledBy(x: scaleFactor, y: scaleFactor)
                }
                
            } else if gesture.state == .ended {
                if limitedTranslation == maxTranslation {
                    // imageView.transform = .identity
                    startMonitoring()
                    /* dioporco blocca l'interazione se true */                    if limitedTranslation == maxTranslation {
                        imageView.isUserInteractionEnabled = true
                    }
                } else {
                    UIView.animate(withDuration: 0.3) {
                        imageView.transform = .identity
                    }
                    stopMonitoring()
                }
                // Questo ci servira' in caso volessimo riportarlo allo stato iniziale dopo la zucata            if self.parent.noiseLevel >= -10 {
                //                 imageView.transform = .identity
                //             }
            }
        }
        
        //MARK: PORCODIO
        private func startMonitoring() {
            audioMonitor = AudioMonitor(threshold: -80)
            parent.noiseLevel = -80
            audioMonitor?.noiseLevel = -80
            audioMonitor?.levelTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                self.parent.noiseLevel = self.audioMonitor?.noiseLevel ?? 0
                if self.parent.noiseLevel >= -10 {
                    self.stopMonitoring()
                    
                }
            }
        }
        
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
            imageView.widthAnchor.constraint(equalToConstant: 50),  // Più stretto
            imageView.heightAnchor.constraint(equalToConstant: 200),  // Più lungo
            imageView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -10)  // Posizionato in basso
        ])
        
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePanGesture(_:)))
        imageView.addGestureRecognizer(panGesture)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
#Preview{
    homepage()
}

