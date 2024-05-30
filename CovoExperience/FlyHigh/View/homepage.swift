import SwiftUI

struct homepage: View {
    @State var isOn = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Image("Sfondo")
                        .opacity(0.8)
                        .contrast(1.5)
                        .scaleEffect(CGSize(width: 1.2, height: 1.2))
                        .position(x: geometry.size.width / 2, y: geometry.size.width)
                    
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
                        .position(x: geometry.size.width / 2, y: geometry.size.width / 1.2)
                        
                        
                        
                        
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
                        .position(x: geometry.size.width / 2, y: geometry.size.width / 3)
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.width / 2)
                    SwitchToggle()
                        .position(x:geometry.size.width/1.9, y:geometry.size.height/1.8)
                    
                    Spacer().frame(height: 0)
                }
            }
        }
    }
}

#Preview {
    homepage()
}
