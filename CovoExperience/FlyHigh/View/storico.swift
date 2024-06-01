//
//  impostazioni.swift
//  CovoExperience
//
//  Created by Edoardo Bertilaccio on 26/05/24.
//
import SwiftUI
import SwiftData

struct storico: View {
    @StateObject private var viewModel = ContiViewModel()
    @State private var showingAddSheet = false
    
    init() {
        // Configurazione del titolo della NavigationBar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("Storico")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(2)
                
                List {
                    //Lista delle sessioni
                    
                    
                    
                    
                    
                }
            }
            
            .scrollContentBackground(.hidden)
            .foregroundColor(.white)
            .background(
                Image("Sfondo")
                    .opacity(0.45)
                    .contrast(1.4)
                    .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    .position(x: geometry.size.width/2, y: geometry.size.width*0.7)
                    .accentColor(.black)
            )
        }
    }
}

#Preview {
    storico()
}
