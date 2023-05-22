//
//  ActividadNuevo.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 22/5/23.
//

import SwiftUI

struct ActividadNuevo: View {
    @EnvironmentObject var actividadesViewModel: ActividadesViewModel
    var handleClose: () -> Void
    
    func handleSave() {
        actividadesViewModel.addActividad()
        handleClose()
    }
    
    var body: some View {
        VStack{
            Form {
                Section("Datos de la activdad") {
                    TextField("Nombre", text: $actividadesViewModel.actividadNueva.nombre)
                    DatePicker("Fecha", selection: $actividadesViewModel.actividadNueva.fecha, in: ...Date(), displayedComponents: .date)
                    
                    Picker("Tipo actividad", selection: $actividadesViewModel.actividadNueva.tipo) {
                        Text(TipoActividad.aventura.rawValue).tag(TipoActividad.aventura)
                        Text(TipoActividad.hermandad.rawValue).tag(TipoActividad.hermandad)
                        Text(TipoActividad.emprendimiento.rawValue).tag(TipoActividad.emprendimiento)
                        Text(TipoActividad.salud.rawValue).tag(TipoActividad.salud)
                        Text(TipoActividad.cultural.rawValue).tag(TipoActividad.cultural)
                        Text(TipoActividad.servicio.rawValue).tag(TipoActividad.servicio)
                        
                    }
                }
                
                Section("Participantes") {
                    
                }
                
                Section {
                    Button(action: handleSave) {
                        Text("Guardar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: handleClose) {
                        Text("Cancelar")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(.bordered)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct ActividadNuevo_Previews: PreviewProvider {
    static let EnvObject = ActividadesViewModel()
    
    static var previews: some View {
        ActividadNuevo {
            print("aaa")
        }.environmentObject(EnvObject)
    }
}
