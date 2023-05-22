//
//  InfoSeisena.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 22/5/23.
//

import SwiftUI

struct InfoSeisena: View {
    var seisena: Seisena
    
    var body: some View {
        switch seisena {
        case .blanca:
            HStack {
                Text(seisena.rawValue)
                Image(systemName: "moon.stars.fill")
            }
            .padding(9)
            .background(.white)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(.black, lineWidth: 1)
            )
            
        case .negra:
            HStack {
                Text(seisena.rawValue)
                Image(systemName: "moon.stars.fill")
            }
            .padding(9)
            .background(.black)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(.white, lineWidth: 1)
            )
            
            
        case .parda:
            HStack {
                Text(seisena.rawValue)
                Image(systemName: "moon.stars.fill")
            }
            .padding(9)
            .background(.brown)
            .foregroundColor(.black)
            .clipShape(Capsule())
        case .gris:
            HStack {
                Text(seisena.rawValue)
                Image(systemName: "moon.stars.fill")
            }
            .padding(9)
            .background(.gray)
            .foregroundColor(.black)
            .clipShape(Capsule())
        }
        
        
        
    }
}

struct InfoSeisena_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InfoSeisena(seisena: .blanca)
            InfoSeisena(seisena: .negra)
            InfoSeisena(seisena: .parda)
            InfoSeisena(seisena: .gris)
        }
        
    }
}
