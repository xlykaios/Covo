//
//  impostazioni.swift
//  CovoExperience
//
//  Created by Edoardo Bertilaccio on 29/05/24.
//
import SwiftUI
import SwiftData

struct storico: View {
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            NavigationView {
                
                VStack {
                    List {
                        
                        
                        
                        
                        
                    }

                    
                }
                .navigationTitle("Storico").foregroundColor(.white)
                .background(
                    Image("Sfondo")
                        .opacity(0.45)
                        .contrast(1.4)
                      .scaleEffect(CGSize(width: 1.2, height: 1.2))
                      .position(x: geometry.size.width/2, y: geometry.size.width/1.5)
                )
                .tint(.white)
            }
        })
    }
}
#Preview {
    storico()
}

