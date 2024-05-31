import AVFAudio
import AVFoundation

struct Manager{
   static var recordingSession: AVAudioSession!
   static var micAuthorised = Bool()
}

func CheckForPermission()
   {
       Manager.recordingSession = AVAudioSession.sharedInstance()
       do
       {
           try Manager.recordingSession.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
//            try Manager.recordingSession.setPreferredSampleRate(16000)
//            try Manager.recordingSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
//            try Manager.recordingSession.setActive(true)
           Manager.recordingSession.requestRecordPermission({ (allowed) in
               if allowed
               {
                   Manager.micAuthorised = true
                   print("Mic Authorised")
               }
               else
               {
                   Manager.micAuthorised = false
                   print("Mic not Authorised")
               }
           })
       }
       catch
       {
           print("Failed to set Category", error.localizedDescription)
       }
   }
