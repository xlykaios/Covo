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
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            NavigationView {
                VStack {
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
                    
                    .navigationTitle("Conti").foregroundColor(.white)
                    .navigationBarItems(
                        
                        trailing: NavigationLink("Aggiungi Serata", destination: AggiungiSerataView(viewModel: viewModel))
                    )
                    
                    .tint(.white)
                    .foregroundColor(.white)
                }
                .background(
                    Image("Sfondo")
                        .opacity(0.45)
                        .contrast(1.4)
                        .scaleEffect(CGSize(width: 1.2, height: 1.2))
                        .position(x: geometry.size.width/2, y: geometry.size.width*0.7)
                )
            }
            .accentColor(.white)
            .tint(.white)
        })
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
