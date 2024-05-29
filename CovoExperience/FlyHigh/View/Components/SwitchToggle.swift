import SwiftUI

struct SwitchToggle: View {
    @State private var sliderValue: CGFloat = 0.0
    private let maxHeight: CGFloat // Altezza massima a cui l'immagine può arrivare
    private let maxOffsetX: CGFloat // Posizione massima sull'asse X a cui l'immagine può arrivare
    private let sensitivity: CGFloat = 0.5 // Modifica la sensibilità qui, più è basso più il movimento è lento
    
    init(maxHeight: CGFloat = 300.0, maxOffsetX: CGFloat = 0.0) { // Modifica questi valori per cambiare la posizione finale
        self.maxHeight = maxHeight
        self.maxOffsetX = maxOffsetX
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("cannetta")
                    .resizable()
                    .frame(width: 60, height: 250)
                    .offset(x: maxOffsetX * (sliderValue / maxHeight), y: maxHeight - sliderValue)
                    .scaleEffect(1 + sliderValue / maxHeight) // Scala l'immagine in base al valore dello slider
                    .animation(.interpolatingSpring(stiffness: 100, damping: 10), value: sliderValue)
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let dragAmount = value.translation.height * sensitivity
                        let newValue = max(0, min(maxHeight, sliderValue - dragAmount))
                        sliderValue = newValue
                    }
            )
        }
        .frame(height: 400)
        .background(Color.clear) // Rimuove lo sfondo grigio
        .offset(y: 100)
    }
}

#Preview {
    SwitchToggle(maxHeight: 300.0, maxOffsetX: 50.0)
}
