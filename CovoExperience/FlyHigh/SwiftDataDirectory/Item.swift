//
//  Item.swift
//  CovoExperience
//
//  Created by Antonio Giordano on 27/05/24.
//

import Foundation
import SwiftData

struct Persona: Identifiable, Codable {
    var id = UUID()
    var nome: String
    var soldi: Double
}

struct Serata: Identifiable, Codable {
    var id = UUID()
    var data: Date
    var persone: [Persona]
}

