//
//  IntegranteInfo.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct IntegranteInfo: View {
    var integrante: Integrante
    
    var body: some View {
        VStack {
            Text("Integrante")
            Text(integrante.nombre)
            Text(integrante.fechaNacimiento.formatted())
        }
    }
}

struct IntegranteInfo_Previews: PreviewProvider {
    static var previews: some View {
        IntegranteInfo(integrante: Integrante(nombre: "Alex Ulloa", fechaNacimiento: Date(value: "2022/02/02")!, promesa: true, etapa: .cazador))
    }
}
