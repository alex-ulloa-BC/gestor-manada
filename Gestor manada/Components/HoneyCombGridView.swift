//
//  HoneyCombGridView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 30/5/23.
//

import SwiftUI

struct HoneyCombGridView: View {
    var body: some View {
        VStack(spacing: -40) {
            HStack {
                Image("Cazador")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Diamond())
                Image("Cazador")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Diamond())
                Image("Cazador")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Diamond())
            }
            HStack {
                Image("Cazador")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Diamond())
                Image("Cazador")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Diamond())
            }
            
            HStack {
                Image("Cazador")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Diamond())
                Image("Cazador")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Diamond())
                Image("Cazador")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Diamond())
                    .grayscale(0.8)
            }
            
        }
            
            
    }
}

struct HoneyCombGridView_Previews: PreviewProvider {
    static var previews: some View {
        HoneyCombGridView()
    }
}
