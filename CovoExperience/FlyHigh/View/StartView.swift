//
//  StartView.swift
//  FlyHigh
//
//  Created by Antonio Giordano on 28/05/24.
//

import SwiftUI

struct StartView: View {
    @State var isOn = false
    var body: some View {
        ZStack {
            Image("Sfondo")
                .brightness(-0.15)
            VStack(alignment: .center) {
                Text("Fly High")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .offset(y:-320)
            }
            HStack{
                AppButton(text: "Conti", icon: "list.bullet.clipboard", destinationPage: "popi")
                AppButton(text: "Storico", icon: "tray.full", destinationPage: "popi")
                AppButton(text: "Settings", icon: "gearshape", destinationPage: "settingsPageView")
            }.offset(CGSize(width: 0.0, height: -170.0))
            
            
            Toggle("", isOn: $isOn)
                .toggleStyle(CustomToggleStyle())
                .offset(y: 200)
            
        }
    }
}


#Preview {
    StartView()
}
