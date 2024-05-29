//
//  AggiungiSerataView.swift
//  CovoExperience
//
//  Created by Edoardo Bertilaccio on 27/05/24.
//

import SwiftUI

struct AggiungiSerataView: View {
    @ObservedObject var viewModel: ContiViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var data = Date()
    @State private var persone: [Persona] = []
    @State private var nomePersona = ""
    @State private var soldiPersona = ""
    
    var body: some View {
        Form {
            DatePicker("Data", selection: $data, displayedComponents: .date)
            
            Section(header: Text("Persone")) {
                ForEach(persone) { persona in
                    HStack {
                        Text(persona.nome)
                        Spacer()
                        Text("\(persona.soldi, specifier: "%.2f") €")
                    }
                }
                .onDelete { indices in
                    persone.remove(atOffsets: indices)
                }
                .onMove { indices, newOffset in
                    persone.move(fromOffsets: indices, toOffset: newOffset)
                }
                HStack {
                    TextField("Nome", text: $nomePersona)
                    TextField("Soldi", text: $soldiPersona)
                        .keyboardType(.decimalPad)
                    Button("Aggiungi") {
                        if let soldi = Double(soldiPersona) {
                            let nuovaPersona = Persona(nome: nomePersona, soldi: soldi)
                            persone.append(nuovaPersona)
                            nomePersona = ""
                            soldiPersona = ""
                        }
                    }
                }
            }
            
            Button("Salva Serata") {
                viewModel.aggiungiSerata(data: data, persone: persone)
                presentationMode.wrappedValue.dismiss() // Torna alla home
            }
        }
        .navigationTitle("Aggiungi Serata")
        .navigationBarItems(trailing: EditButton())
    }
}


