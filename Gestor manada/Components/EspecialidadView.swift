//
//  EspecialidadView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 30/5/23.
//

import SwiftUI

struct EspecialidadView: View {
    var especialidad: Especialidad
    let valores = [1,2,3]
    
    var onClick: (_ i: Int) -> Void
    
    var body: some View {
        VStack {
            Text(especialidad.especialidad.rawValue)
            HStack(spacing: 20) {
                ForEach(valores.indices, id: \.self) { i in
                    Image(especialidad.especialidad.rawValue+i.description)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Diamond())
                        .grayscale(i > especialidad.valor ? 0.75 : 0)
                        .shadow(color: Color.black.opacity(0.8), radius: 5, x: 0, y: 10)
                        .onTapGesture {
                            onClick(i)
                        }
                }
            }
        }
    }
}

struct EspecialidadView_Previews: PreviewProvider {
    static var previews: some View {
        EspecialidadView(especialidad: Especialidad(especialidad: .arte, valor: 1)) { i in
            print(i)
        }
    }
}
