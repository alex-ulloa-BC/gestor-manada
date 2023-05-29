//
//  ActividadInfo.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 22/5/23.
//

import SwiftUI

struct ActividadInfo: View {
    @EnvironmentObject var actividadesViewModel: ActividadesViewModel
    var actividad: Actividad
    @State var isShowingSheet = false
    
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
    
    func handleEdit() {
        isShowingSheet = true
        actividadesViewModel.actividadNueva = actividad
    }
    
    func handleCloseSheet() {
        isShowingSheet = false
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
                Section("Participantes") {
                    ForEach(Array(actividad.participantes.enumerated()), id: \.offset) { (index,p) in
                        Text(p.nombre)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.black)
                    }
                    DividerAdjusted()
                }
                .padding(.horizontal)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
                
                Spacer()
                
                Button(action: handleEdit) {
                    Text("Editar")
                }.buttonStyle(.bordered)
            }
        }
        .sheet(isPresented: $isShowingSheet, onDismiss: handleCloseSheet) {
            ActividadNuevo(participantes: actividad.participantes, handleClose: handleCloseSheet)
        }
    }
}

struct ActividadInfo_Previews: PreviewProvider {
    static var previews: some View {
        ActividadInfo(actividad: Actividad(nombre: "Aventuras en el Seeonee", fecha: Date(), tipo: .aventura, participantes: [Integrante(nombre: "Alex", fechaNacimiento: Date(), etapa: .pataTierna), Integrante(nombre: "Alex mas grande", fechaNacimiento: Date(), etapa: .pataTierna)]))
    }
}
