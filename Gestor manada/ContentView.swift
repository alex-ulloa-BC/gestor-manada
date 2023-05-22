//
//  ContentView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            IntegrentesView()
                .tabItem{
                    Image(systemName: "person.3.fill")
                    Text("Integrantes")
                }
            
            ActividadesView()
                .tabItem{
                    Image(systemName: "tent.fill")
                    Text("Actividades")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
