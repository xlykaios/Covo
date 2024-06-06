import SwiftUI
import SwiftData

struct FumataSession: View {
    @StateObject private var viewModel = ContiViewModel()
    @State private var showingAddSheet = false
    @State private var startDate: Date = UserDefaults.standard.object(forKey: "startDate") as? Date ?? Date() {
        didSet {
            UserDefaults.standard.set(startDate, forKey: "startDate")
        }
    }
    @State private var elapsedTime: TimeInterval = UserDefaults.standard.double(forKey: "elapsedTime") {
        didSet {
            UserDefaults.standard.set(elapsedTime, forKey: "elapsedTime")
        }
    }
    @State private var timer: Timer?
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    @State private var statoSessione: Bool = UserDefaults.standard.bool(forKey: "statoSessione") {
        didSet {
            UserDefaults.standard.set(statoSessione, forKey: "statoSessione")
        }
    }

    init() {
        // Configurazione del titolo della NavigationBar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("Sessione Iniziata")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(2)
                
                Text("Tempo trascorso: \(elapsedTimeString)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()

            }
            .position(x: geometry.size.width / 2, y: geometry.size.height - 1000)
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
            .onAppear {
                if statoSessione == false {
                    startTimer()
                } else {
                    resumeTimer()
                }
            }
            VStack {
                HStack(spacing: geometry.size.width / 30) {
                    NavigationLink(destination: conti()) {
                        AppButton(text: "Func1", icon: "figure.roll") {
                            
                        }
                    }
                    
                    NavigationLink(destination: storico()) {
                        AppButton(text: "Func2", icon: "figure.roll") {
                            
                        }
                    }
                    
                    NavigationLink(destination: impostazioni()) {
                        AppButton(text: "Func3", icon: "figure.roll") {
                            
                        }
                    }
                }
                HStack(spacing: geometry.size.width / 30) {
                    NavigationLink(destination: conti()) {
                        AppButton(text: "Conti", icon: "list.bullet.clipboard") {
                            conti()
                        }
                    }
                    
                    NavigationLink(destination: storico()) {
                        AppButton(text: "Storico Fattanze", icon: "tray.full") {
                            storico()
                        }
                    }
                    
                    NavigationLink(destination: impostazioni()) {
                        AppButton(text: "Impostazioni", icon: "gearshape") {
                            impostazioni()
                        }
                    }
                }
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            Button(action: stopAndSaveSession) {
                Text("Termina Sessione")
                    .font(.headline)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.1)
        }
    }

    private var elapsedTimeString: String {
        let time = Int(elapsedTime)
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func startTimer() {
        statoSessione = true
        if timer == nil {
            startDate = Date() // Aggiorna startDate all'inizio della sessione
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                let currentTime = Date()
                elapsedTime = currentTime.timeIntervalSince(startDate)
            }
        }
    }

    private func resumeTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                let currentTime = Date()
                elapsedTime = currentTime.timeIntervalSince(startDate)
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func stopAndSaveSession() {
        stopTimer()
        statoSessione = false
        let newSession = Session(date: Date(), duration: elapsedTime)
        modelContext.insert(newSession)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss() // Torna alla pagina precedente
        } catch {
            // Gestione dell'errore di salvataggio
        }
    }
}

#Preview {
    FumataSession()
}
