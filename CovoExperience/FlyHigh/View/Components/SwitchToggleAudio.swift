import SwiftUI
import AVFoundation

struct SwitchToggleAudio: UIViewControllerRepresentable {
    @Binding var noiseLevel: Float
    
    class Coordinator: NSObject, AVAudioRecorderDelegate {
        var parent: SwitchToggleAudio
        var audioMonitor: AudioMonitor?
        
        init(_ parent: SwitchToggleAudio) {
            self.parent = parent
        }

        @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
            guard let imageView = gesture.view else { return }
            let translation = gesture.translation(in: imageView.superview)
            let maxTranslation: CGFloat = -200 // Limit the maximum upward movement
            let limitedTranslation = max(translation.y, maxTranslation)
            let scaleFactor = 1 + (abs(limitedTranslation) / 200) // Scale factor increases with upward movement

            if gesture.state == .changed {
                if translation.y < 0 {
                    imageView.transform = CGAffineTransform(translationX: 0, y: limitedTranslation).scaledBy(x: scaleFactor, y: scaleFactor)
                }
            } else if gesture.state == .ended {
                if limitedTranslation == maxTranslation {
                    imageView.transform = .identity
                    startMonitoring()
                } else {
                    UIView.animate(withDuration: 0.3) {
                        imageView.transform = .identity
                    }
                    stopMonitoring()
                }
            }
        }

        private func startMonitoring() {
            print("Start monitoring")
            audioMonitor?.stopMonitoring()
            audioMonitor = AudioMonitor(threshold: -30.0)
            parent.noiseLevel = 0
            audioMonitor?.noiseLevel = 0
            audioMonitor?.levelTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.parent.noiseLevel = self.audioMonitor?.noiseLevel ?? 0
                print("Noise level: \(self.parent.noiseLevel)")
                if self.parent.noiseLevel >= 100 {
                    self.stopMonitoring()
                }
            }
        }

        private func stopMonitoring() {
            print("Stop monitoring")
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
            imageView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -20)  // Posizionato in basso
        ])
        
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePanGesture(_:)))
        imageView.addGestureRecognizer(panGesture)
        
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
