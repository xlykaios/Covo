//
//  SwitchToggle.swift
//  FlyHigh
//
//  Created by Antonio Giordano on 28/05/24.
//

import SwiftUI

//MARK: Creazione del componente switch, per facilitare l'implementazione nella view principale e per futuri utilizzi, in sostanza ho creato uno stile Custom di Toggle (ToggleStyle) letteralmente "creando" i componenti all'interno pezzo per pezzo e animandoli


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
            
            //MARK: Nota la possibilità di utilizzare un IF CASE all'interno del costrutto con il formato (valore: *boolean* ifTrue ? ifFalse) , questo ci permette di effettuare cambiamenti nella view in base a range di valori, o in questo caso, alla pressione di un bottone, in questo caso al cambiamento del boolean l'immagine si muoverà da posizione -300 a 0 tramite animazione (vedi sotto)
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
            
//MARK: Utilizzo un .mask per creare un rettangolo simile a quello presente di base, in modo da poter in futuro muovere un'immagine all'esterno croppandola (un semplice maschera come quello di figma)
            
        }
        .mask({
            RoundedRectangle(cornerRadius: 25, style: .circular)
                .frame(width: 60,height: 240)
        })
//MARK: utilizzo la funzione .onTapGesture dalla libreria di possibili gesture per decidere il comportamento, in questo caso effettua il toggle di is.On, e tutto quello che ne consegue è racchiuso e gestito da withAnimation, quindi significa che tutto quello che accade al cambiamento di isOn avrà questo tipo di animazione
        
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
