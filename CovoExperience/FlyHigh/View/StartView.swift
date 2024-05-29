//
//  Homepage.swift
//  CovoExperience
//
//  Created by Edoardo Bertilaccio on 28/05/24.
//

import SwiftUI

struct StartView: View {
    @State var isOn = false
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                Image("Sfondo")
                    .brightness(-0.08)
                    .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    .position(x: geometry.size.width/2, y: geometry.size.width*1)
                VStack(content:{
                    Text("Fly High bro")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Text("Slida verso l'alto per sborrare")
                        .foregroundColor(.white)
                })
                .position(x: geometry.size.width/2, y:geometry.size.width/2.5)
                HStack(spacing: geometry.size.width/30, content: {
                    AppButton(text: "Conti", icon: "list.bullet.clipboard", destinationPage: "conti")
                    AppButton(text: "Storico", icon: "tray.full", destinationPage: "storico")
                    AppButton(text: "Settings", icon: "gearshape", destinationPage: "impostazioni")
                })
                .position(x: geometry.size.width/2, y: geometry.size.width*0.78)
            }
            Toggle("", isOn: $isOn)
                .toggleStyle(CustomToggleStyle())
                .position(x: geometry.size.width/2, y: geometry.size.width*1.7)
        })
    }
    
}

#Preview {
    StartView()
}
