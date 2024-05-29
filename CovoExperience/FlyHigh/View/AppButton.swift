//
//  AppButton.swift
//  FlyHigh
//
//  Created by Antonio Giordano on 28/05/24.
//

import SwiftUI

struct AppButton: View {
    var text: String
    var icon: String
    var destinationPage: String
    
    var body: some View {
        Button(action: {
            // Azione del bottone
            
        }) {
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
                }
                Text(text)
                    .font(Font.custom("SF Pro Display", size: 15))
                    .foregroundColor(.white)
            }
            .frame(width: 87, height: 104)
        } .buttonStyle(PlainButtonStyle())
    }
    }


#Preview {
    AppButton(text: "Info",icon: "gear", destinationPage: "pisello")
}
