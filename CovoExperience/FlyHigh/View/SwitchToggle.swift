//
//  SwitchToggle.swift
//  FlyHigh
//
//  Created by Antonio Giordano on 28/05/24.
//

import SwiftUI

struct SwitchToggle: View {
    @State var isOn = true
    var body: some View {
        Toggle("", isOn: $isOn)
            .toggleStyle(CustomToggleStyle())
            .offset(y: 200)
    }
}

struct CustomToggleStyle:ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        let isOn = configuration.isOn
        return ZStack{
                Image("Sfdondo")
                    .resizable()
                    .frame(width: 60, height: 250)
                    .offset(y: isOn ? -300:0)
                    .overlay(alignment: .leading) {
                                       ZStack {
                                           Image(systemName: "leaf.fill")
                                               .foregroundColor(.green)
                                               .opacity(isOn ? 1 : 0)
                                               .transition(.opacity)
                                               .animation(.easeInOut(duration: 0.2), value: isOn)
                                               .scaleEffect(CGSize(width: isOn ? 1.5:0, height:isOn ? 1.5:0))
                                           
                                           Image(systemName: "flame.fill")
                                               .foregroundColor(.red)
                                               .opacity(isOn ? 0 : 1)
                                               .transition(.opacity)
                                               .animation(.easeInOut(duration: 0.2), value: isOn)
                                               .scaleEffect(CGSize(width: isOn ? 0:3, height:isOn ? 0:3))
                                       }
                                       .frame(width: 60, height: 50)
                                       .offset(y: isOn ? 95 : -95)
                                   }
                                   .opacity(1)
            
//TODO: Placeholder
            
        }
        .mask({
            RoundedRectangle(cornerRadius: 25, style: .circular)
                .frame(width: 60,height: 240)
        })
        
        .onTapGesture {
            withAnimation(.spring(response: 0.2,dampingFraction: 0.9)){
                configuration.isOn.toggle()
            }
        }
    }
}

#Preview {
    SwitchToggle()
}

//.overlay(alignment: .leading){
 //   Image(systemName: isOn ? "leaf.fill":"flame.fill" )
  //      .frame(width: 60, height: 50)
    //  .offset(y: isOn ? 30:-30 )
    //    .offset(y: isOn ? 95:-95 )
      //  .foregroundColor(.green)
      //  .imageScale(.large)
//}.opacity(isOn ? 1:1)


// Image(systemName: "flame.fill")
//     .foregroundColor(.red)
 //.scaleEffect(CGSize(width: 2.5, height: 2.5))
  //   .frame(width: 60, height: 50)
   //  .offset(y:-100)
   //  .opacity(isOn ? 0:1)
 //  .offset(y: isOn ? 30:-30 )
 //  .offset(y: isOn ? 32:-35 )
 //.scaleEffect(CGSize(width: 3.0, height: 3.0))
