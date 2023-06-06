//
//  EspecialidadView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 30/5/23.
//

import SwiftUI

struct EspecialidadView: View {
    @Environment(\.colorScheme) var colorScheme
    var integrante: Integrante
    var especialidad: EspecialidadNombre
    let valores = [1,2,3]
    
    func getGrayScale(valor: Int) -> Double {
        guard let valorEspecialidad = integrante.especialidades?[especialidad] else {
            return 0.85
        }
        
        if valorEspecialidad > valor {
            return 0
        }
        
        return 0.85
    }
    
    func getShadowColor() -> Color {
        return colorScheme == .dark ? .gray : .black
    }
    
    var body: some View {
        VStack {
            Text(especialidad.rawValue)
            HStack(spacing: 20) {
                ForEach(valores.indices, id: \.self) { i in
                    Image(especialidad.rawValue+i.description)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Diamond())
                        .grayscale(getGrayScale(valor: i))
                        .shadow(color: getShadowColor().opacity(0.4), radius: 10, x: -5, y: 5)
                }
            }
        }
    }
}

struct EspecialidadView_Previews: PreviewProvider {
    static let especialidades = Especialidades(arte: 1, ciencia: 2, deporte: 0, fe: 0, naturaleza: 0, servicio: 0)
    
    static var previews: some View {
        EspecialidadView(integrante: Integrante(nombre: "", fechaNacimiento: Date(), etapa: .pataTierna, especialidades: especialidades), especialidad: .arte)
    }
}
