import SwiftUI

struct homepage: View {
    @State private var isOn = false
    @State private var noiseLevel: Float = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
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
                                .padding()
                            Text("Tira su la canna verso l'alto")
                                .foregroundColor(.white)
                            Text("Accendila per bene tirando come un dannato")
                                .foregroundColor(.white)
                        }
                        .padding()
                        
                        Spacer().frame(height: 10)
                        
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
                        
                        Spacer().frame(height: 10)
                        
                        SwitchToggleAudio(noiseLevel: $noiseLevel)
                            .position(x:geometry.size.width/2, y:geometry.size.height/2)
                        
                        Text("Noise Level: \(noiseLevel, specifier: "%.1f")")
                            .foregroundColor(.white)
                            .padding()
                        
                        Spacer().frame(height: 0)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    homepage()
}
