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
        GeometryReader(content: { geometry in
            ZStack(content: {
                Image("Sfondo")
                    .opacity(0.45)
                    .contrast(1.4)
                    .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    .position(x: geometry.size.width/2, y: geometry.size.width*0.7)
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
                            .foregroundColor(.white)
                        }
                        
                    }
                    
                    
                    Button("Salva Serata") {
                        viewModel.aggiungiSerata(data: data, persone: persone)
                        presentationMode.wrappedValue.dismiss() // Torna alla home
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Aggiungi Serata")
                .navigationBarItems(trailing: EditButton())
                .tint(.white)
                
            }
                   
            )
        })
    }
}
#Preview {
    conti()
}
