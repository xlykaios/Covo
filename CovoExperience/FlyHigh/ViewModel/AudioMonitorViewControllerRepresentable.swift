import SwiftUI
import UIKit

struct AudioMonitorViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AudioMonitorViewController {
        return AudioMonitorViewController()
    }
    
    func updateUIViewController(_ uiViewController: AudioMonitorViewController, context: Context) {}
}
