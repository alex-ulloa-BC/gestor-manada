//
//  ContentView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var integrantesViewModel = IntegrantesViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        TabView {
            IntegrentesView()
                .environmentObject(integrantesViewModel)
                .tabItem{
                    Image(systemName: "person.3.fill")
                    Text("Integrantes")
                }
            
            ActividadesView()
                .tabItem{
                    Image(systemName: "tent.fill")
                    Text("Actividades")
                }
            
            InsigniasView()
                .tabItem{
                    Image(systemName: "flag.checkered.2.crossed")
                    Text("Insignias")
                }
        }
        .onAppear {
            let color: Color = colorScheme == .dark ? .black : .white
            
            let appearanceStandard = UITabBarAppearance()
            appearanceStandard.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearanceStandard.backgroundColor = UIColor(color.opacity(0.2))
            
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearanceStandard
            
           // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearanceStandard
            
            
            
        }
        .environmentObject(integrantesViewModel)
        .onAppear {
            let query = integrantesViewModel.query(nombre: nil, promesa: nil, etapa: nil, sortOption: nil)
            integrantesViewModel.subscribe(to: query)
        }
        .onDisappear {
            integrantesViewModel.unsubscribe()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
