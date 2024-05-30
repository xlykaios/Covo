import UIKit

class AudioMonitorViewController: UIViewController {
    private var imageView: UIImageView!
    private var audioMonitor: AudioMonitor?
    private let threshold: Float = -30.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
    }
    
    private func setupImageView() {
        imageView = UIImageView(image: UIImage(named: "example_image"))
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        imageView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        if gesture.state == .changed {
            if translation.y < 0 {
                imageView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        } else if gesture.state == .ended {
            if translation.y < -200 { // Controlla se l'immagine è stata slidata abbastanza verso l'alto
                imageView.transform = .identity
                startMonitoring()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.imageView.transform = .identity
                }
                stopMonitoring()
            }
        }
    }
    
    private func startMonitoring() {
        audioMonitor = AudioMonitor(threshold: threshold)
    }
    
    private func stopMonitoring() {
        audioMonitor = nil
    }
}
