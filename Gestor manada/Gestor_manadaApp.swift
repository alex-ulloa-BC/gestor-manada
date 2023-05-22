//
//  Gestor_manadaApp.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI
import FirebaseCore

@main
struct Gestor_manadaApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
