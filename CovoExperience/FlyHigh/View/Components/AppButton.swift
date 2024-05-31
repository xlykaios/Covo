import SwiftUI

struct AppButton<Destination>: View where Destination: View {
    var text: String
    var icon: String
    let destination: Destination
    
    init(text: String, icon: String, @ViewBuilder destination: @escaping () -> Destination) {
        self.text = text
        self.icon = icon
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 3) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 70, height: 70)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 0.25, green: 0.25, blue: 0.25), Color(red: 0.25, green: 0.25, blue: 0.25)]), startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(25)
                        .opacity(0.6)
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.55), radius: 4.70, x: 5, y: 8
                        )
                    Image(systemName: icon)
                        .scaleEffect(CGSize(width: 2.3, height: 2.3))
                        .frame(width: 20, height: 20)
                        .tint(.white)
                }
                Text(text)
                    .font(Font.custom("SF Pro Display", size: 15))
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 120, height: 104)
        }
    }
}
#Preview {
    AppButton(text: "TESTTTTTTTTTTTT", icon: "gear") {
        Text("Destination View")
    }
}
