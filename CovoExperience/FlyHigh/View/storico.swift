import SwiftUI
import SwiftData

struct storico: View {
    @StateObject private var viewModel = ContiViewModel()
    @State private var showingAddSheet = false
    @State private var showAlert = false
    @State private var sessionToDelete: Session?

    @Query private var sessions: [Session]
    @Environment(\.modelContext) private var modelContext

    init() {
        // Configurazione del titolo della NavigationBar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("Storico")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(2)
                
                List {
                    ForEach(sessions.sorted(by: { $0.date > $1.date })) { session in
                        VStack(alignment: .leading) {
                            Text("Data: \(dateString(from: session.date))")
                            Text("Durata: \(durationString(from: session.duration))")
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                sessionToDelete = session
                                showAlert = true
                            } label: {
                                Label("Elimina", systemImage: "trash")
                            }
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Conferma eliminazione"),
                        message: Text("Sei sicuro di voler eliminare questa sessione?"),
                        primaryButton: .destructive(Text("Elimina")) {
                            if let session = sessionToDelete {
                                deleteSession(session)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .scrollContentBackground(.hidden)
            .foregroundColor(.white)
            .background(
                Image("Sfondo")
                    .opacity(0.45)
                    .contrast(1.4)
                    .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .accentColor(.black)
            )
        }
    }

    private func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    private func durationString(from duration: TimeInterval) -> String {
        let time = Int(duration)
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func deleteSession(_ session: Session) {
        modelContext.delete(session)
        do {
            try modelContext.save()
        } catch {
            // Gestione dell'errore di salvataggio
        }
    }
}

#Preview {
    storico()
}
