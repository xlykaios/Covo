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
    @State var fillVariable: Float = 0.0
    @State private var navigateToSession: Bool = false
    @State private var statoSessione: Bool = UserDefaults.standard.bool(forKey: "statoSessione") {
            didSet {
                UserDefaults.standard.set(statoSessione, forKey: "statoSessione")
            }
        }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
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
                    
                    ZStack {
                        if statoSessione == false {
                            
                            SwitchToggle(noiseLevel: $noiseLevel, fillVariable: $fillVariable, navigateToSession: $navigateToSession)
                                .rotationEffect(.degrees(-5), anchor: .center)
                                .onChange(of: fillVariable) { newValue in
                                    if newValue == 100 {
                                        navigateToSession = true
                                        fillVariable = 0
                                    }
                                }
                            
                        } else if statoSessione == true{
                            ZStack {
                                Button(action: {
                                    navigateToSession = true
                                }) {
                                    Text("Torna alla serata")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(10)
                                }
                                .position(x: geometry.size.width / 2.5, y: geometry.size.height / 10)
                                .padding()
                                
                                NavigationLink(destination: FumataSession(), isActive: $navigateToSession) {
                                    EmptyView()
                                }
                            }
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }
                    }
                    Spacer().frame(height: 0)
                }
                .background(
                    Image("Sfondo")
                        .opacity(0.8)
                        .contrast(1.5)
                        .scaleEffect(CGSize(width: 1.2, height: 1.2))
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .accentColor(.black))
                .padding()
                .navigationDestination(isPresented: $navigateToSession) {
                    FumataSession()
                        .navigationBarBackButtonHidden()
                }
                .onAppear{
                statoSessione=UserDefaults.standard.bool(forKey: "statoSessione")
                    }
                }
            }
            .accentColor(.white)
        }
    }

#Preview {
    homepage()
}
