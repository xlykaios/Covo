import SwiftUI
import SwiftData

class SessionManager: ObservableObject {
    @Published var activeSession: Session?

    @Environment(\.modelContext) private var modelContext

    func loadActiveSession() {
        if UserDefaults.standard.bool(forKey: "sessionActive") {
            let fetchDescriptor = FetchDescriptor<Session>(
                predicate: #Predicate { $0.isActive == true },
                sortBy: []
            )
            do {
                let sessions = try modelContext.fetch(fetchDescriptor)
                if let session = sessions.first {
                    activeSession = session
                }
            } catch {
                print("Error fetching active session: \(error)")
            }
        }
    }

    func saveActiveSession() {
        if let session = activeSession {
            session.duration = Date().timeIntervalSince(session.date)
            try? modelContext.save()
        }
    }

    func startNewSession() {
        let newSession = Session(date: Date(), duration: 0)
        activeSession = newSession
        modelContext.insert(newSession)
        try? modelContext.save()
    }

    func endSession() {
        activeSession?.isActive = false
        activeSession = nil
        try? modelContext.save()
    }
}
