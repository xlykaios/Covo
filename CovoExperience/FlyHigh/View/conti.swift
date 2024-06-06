//
//  impostazioni.swift
//  CovoExperience
//
//  Created by Edoardo Bertilaccio on 26/05/24.
//
import SwiftUI
import SwiftData

struct conti: View {
    @StateObject private var viewModel = ContiViewModel()
    @State private var showingAddSheet = false
    
    init() {
        // Configurazione del titolo della NavigationBar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("Conti")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(2)
                
                List {
                    ForEach(viewModel.serate) { serata in
                        VStack(alignment: .leading) {
                            Text("Data: \(serata.data, formatter: dateFormatter)")
                            ForEach(serata.persone) { persona in
                                Text("\(persona.nome): \(persona.soldi, specifier: "%.2f") €")
                            }
                        }
                    }
                    .onDelete(perform: viewModel.rimuoviSerata)
                }
                .scrollContentBackground(.hidden)
                .foregroundColor(.white)
                
                Button(action: {
                    showingAddSheet.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .sheet(isPresented: $showingAddSheet) {
                    AggiungiSerataView(viewModel: viewModel)
                }
                
            }
            .background(
                Image("Sfondo")
                    .opacity(0.45)
                    .contrast(1.4)
                    .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    .position(x: geometry.size.width/2, y: geometry.size.height/2)
                    .accentColor(.black)
            )
        }
        .accentColor(.white)
        .tint(.white)
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

#Preview {
    conti()
}
