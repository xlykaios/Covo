import AVFoundation

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
