//
//  ContentView.swift
//  CovoExperience
//
//  Created by Antonio Giordano on 27/05/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = ContiViewModel()
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("Conti")
            .navigationBarItems(
                leading: EditButton(),
                trailing: NavigationLink("Aggiungi Serata", destination: AggiungiSerataView(viewModel: viewModel))
            )
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

