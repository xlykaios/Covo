import UIKit
import AVFoundation

class ViewController: UIViewController {
    private var imageView: UIImageView!
    private var audioMonitor: AudioMonitor?
    private let threshold: Float = -30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
    }
    
    private func setupImageView() {
        imageView = UIImageView(image: UIImage(named: "your_image_name"))
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

class AudioMonitor: NSObject, AVAudioRecorderDelegate {
    private var audioRecorder: AVAudioRecorder?
    private var levelTimer: Timer?
    private var threshold: Float
    private(set) var isAboveThreshold = false
    
    init(threshold: Float) {
        self.threshold = threshold
        super.init()
        setupRecorder()
    }
    
    private func setupRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let settings: [String: Any] = [
                AVFormatIDKey: kAudioFormatAppleLossless,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
            ]
            
            let url = URL(fileURLWithPath: "/dev/null")
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            
            levelTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkAudioLevel), userInfo: nil, repeats: true)
        } catch {
            print("Error setting up audio recorder: \(error)")
        }
    }
    
    @objc private func checkAudioLevel() {
        audioRecorder?.updateMeters()
        
        if let averagePower = audioRecorder?.averagePower(forChannel: 0) {
            if averagePower > threshold {
                isAboveThreshold = true
            } else {
                isAboveThreshold = false
            }
        }
    }
    
    deinit {
        audioRecorder?.stop()
        levelTimer?.invalidate()
    }
}
