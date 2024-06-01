//
//  impostazioni.swift
//  CovoExperience
//
//  Created by Edoardo Bertilaccio on 27/05/24.
//
import SwiftUI

struct homepage: View {
    @State private var isOn = false
    @State private var noiseLevel: Float = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Image("Sfondo")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.8)
                        .contrast(1.5)
                        .ignoresSafeArea()
                
                    VStack {
                        VStack {
                            Text("Fly High bro")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .padding(geometry.size.height / 20)
                            Text("Tira su la canna verso l'alto")
                                .foregroundColor(.white)
                                .frame(alignment: .center)
                            Text("Accendila per bene tirando come un dannato")
                                .foregroundColor(.white)
                                .frame(alignment: .center)
                        }
                        .padding(geometry.size.height / 30)
                        
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
                        .padding()
                        
                        SwitchToggle(noiseLevel: $noiseLevel)

                            .rotationEffect(.degrees(-5), anchor: .center)
                        /* Debug audio */                        Text("Noise Level: \(noiseLevel, specifier: "%.1f")")
                            .foregroundColor(.white)
                            .padding(30)
                        
                        Spacer().frame(height: 0)
                    }
                    .padding()
                }
            }
            .tint(.white)
            .accentColor(.white)
        }
    }
}

#Preview {
    homepage()
}
