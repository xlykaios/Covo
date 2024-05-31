import AVFoundation

class AudioMonitor: NSObject, AVAudioRecorderDelegate {
    private var audioRecorder: AVAudioRecorder?
    var levelTimer: Timer?
    var noiseLevel: Float = 0
    private var threshold: Float
    
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
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.audioRecorder?.updateMeters()
            
            if let averagePower = self.audioRecorder?.averagePower(forChannel: 0) {
                DispatchQueue.main.async {
                    self.noiseLevel = averagePower
                    if averagePower > self.threshold {
                        self.noiseLevel = min(self.noiseLevel + 1, 100)
                    }
                }
            }
        }
    }

    func stopMonitoring() {
        audioRecorder?.stop()
        levelTimer?.invalidate()
        levelTimer = nil
    }

    deinit {
        stopMonitoring()
    }
}
