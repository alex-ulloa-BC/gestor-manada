//
//  IntegranteActivoView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 24/5/23.
//

import SwiftUI

struct IntegranteActivoView: View {
    var integrante: Integrante
    var cambiarValor: (Bool) -> Void
    @State var isActivo = false
    var body: some View {
        Toggle(integrante.nombre, isOn: $isActivo)
            .onChange(of: isActivo) {
                nuevaValor in
                    cambiarValor(nuevaValor)
            }
    }
}

struct IntegranteActivoView_Previews: PreviewProvider {
    static var previews: some View {
        IntegranteActivoView(integrante: Integrante(nombre: "ALeeex", fechaNacimiento: Date(), etapa: .pataTierna)) {a in print(a)
            
        }
    }
}
