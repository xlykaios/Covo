//
//  ContiViewModel.swift
//  CovoExperience
//
//  Created by Edoardo Bertilaccio on 27/05/24.
//

import Foundation
import Combine

class ContiViewModel: ObservableObject {
    @Published var serate: [Serata] = []
    
    init() {
        loadSerate()
    }
    
    func aggiungiSerata(data: Date, persone: [Persona]) {
        let nuovaSerata = Serata(data: data, persone: persone)
        serate.append(nuovaSerata)
        saveSerate()
    }
    
    func rimuoviSerata(at offsets: IndexSet) {
        serate.remove(atOffsets: offsets)
        saveSerate()
    }
    
    private func loadSerate() {
        if let data = UserDefaults.standard.data(forKey: "serate") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Serata].self, from: data) {
                serate = decoded
            }
        }
    }
    
    private func saveSerate() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(serate) {
            UserDefaults.standard.set(encoded, forKey: "serate")
        }
    }
}
