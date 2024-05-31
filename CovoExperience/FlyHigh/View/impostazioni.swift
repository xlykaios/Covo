//
//  impostazioni.swift
//  CovoExperience
//
//  Created by Edoardo Bertilaccio on 29/05/24.
//
import SwiftUI

struct impostazioni: View {
    @State private var qualcosa1 = false
    @State private var qualcosa2 = false
    @State private var qualcosa3 = false
    @State private var qualcosa4 = false
    @State private var volumeLevel: Double = 50
    
    var body: some View {
        NavigationView {
            List {
                // Prima Sezione
                Section(header: Text("Qualcosa")) {
                    Toggle(isOn: $qualcosa1) {
                        HStack {
                            Image(systemName: "")
                                .foregroundColor(.orange)
                            Text("Diopanettone")
                        }
                    }
                    
                    NavigationLink(destination: impostazioni()) {
                        HStack {
                            Image(systemName: "")
                                .foregroundColor(.blue)
                            Text("Inception")
                            Spacer()
                            if qualcosa2 {
                                Text("On").foregroundColor(.gray)
                            } else {
                                Text("Off").foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Toggle(isOn: $qualcosa3) {
                        HStack {
                            Image(systemName: "")
                                .foregroundColor(.blue)
                            Text("Gesù 3")
                        }
                    }
                }
                
                // Seconda Sezione
                Section(header: Text("Notifiche")) {
                    Toggle(isOn: $qualcosa4) {
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(.purple)
                            Text("Non le voglio, NO")
                        }
                    }
                }
                
                
                // Terza Sezione
                Section(header: Text("Suoni")) {
                    HStack {
                        Image(systemName: "speaker.3.fill")
                            .foregroundColor(.red)
                        Text("Volume")
                        Slider(value: $volumeLevel, in: 0...100) {
                            Text("Volume")
                        }
                        .accessibilityValue(Text("\(Int(volumeLevel))"))
                    }
                    
                }
    
            }
            .listStyle(.insetGrouped)
            .environment(\.horizontalSizeClass, .regular)
            .navigationTitle("Impostazioni")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        impostazioni()
    }
}
