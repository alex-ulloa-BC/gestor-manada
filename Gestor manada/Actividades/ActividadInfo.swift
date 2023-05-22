//
//  ActividadInfo.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 22/5/23.
//

import SwiftUI

struct ActividadInfo: View {
    var actividad: Actividad
    
    func getActividadIcon(tipoActividad: TipoActividad) -> String {
        switch tipoActividad {
        case .aventura:
            return "tent.2.circle.fill"
        case .hermandad:
            return "hand.thumbsup.circle.fill"
        case .emprendimiento:
            return "creditcard.circle.fill"
        case .salud:
            return "stethoscope.circle.fill"
        case .cultural:
            return "theatermasks.circle.fill"
        case .servicio:
            return "pawprint.circle.fill"
        }
        
    }
    
    var body: some View {
        VStack{
            HStack {
                Text(actividad.nombre)
                    .font(.title)
                Spacer()
                Image(systemName: getActividadIcon(tipoActividad: actividad.tipo))
                    .resizable()
                    .frame(width: 30, height: 30)
            }.padding()
                .background(.gray)
            
            ScrollView {
                Group {
                    InfoRow(label: "Nombre", value: actividad.nombre)
                    InfoRow(label: "Fecha", value: actividad.fecha.formatted(date: .abbreviated, time: .omitted))
                }
            }
            
            
        }
    }
}

struct ActividadInfo_Previews: PreviewProvider {
    static var previews: some View {
        ActividadInfo(actividad: Actividad(nombre: "Aventuras en el Seeonee", fecha: Date(), tipo: .aventura))
    }
}
