//
//  IntegranteNuevo.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct IntegranteNuevo: View {
    @EnvironmentObject var integrantesViewModel: IntegrantesViewModel
    @State var nombreCaza: String = ""
    
    var handleClose: () -> Void
    
    func handleSave() {
        integrantesViewModel.addIntegrante()
        handleClose()
    }
    
    var body: some View {
        VStack{
            Form {
                Section("Datos del lobato") {
                    TextField("Nombre", text: $integrantesViewModel.integranteNuevo.nombre)
                    TextField("Nombre de Caza", text: $nombreCaza)
                    DatePicker("Fecha de Nacimiento", selection: $integrantesViewModel.integranteNuevo.fechaNacimiento, in: ...Date(), displayedComponents: .date)
                    Toggle("Promesa", isOn: $integrantesViewModel.integranteNuevo.promesa)
                    Toggle("Carnetizado", isOn: $integrantesViewModel.integranteNuevo.carnetizado)
                    
                    Picker("Etapa", selection: $integrantesViewModel.integranteNuevo.etapa) {
                        Text(Etapa.pataTierna.rawValue).tag(Etapa.pataTierna)
                        Text(Etapa.saltador.rawValue).tag(Etapa.saltador)
                        Text(Etapa.rastreador.rawValue).tag(Etapa.rastreador)
                        Text(Etapa.cazador.rawValue).tag(Etapa.cazador)
                    }
                    
                    Picker("Seisena", selection: $integrantesViewModel.integranteNuevo.seisena) {
                        InfoSeisena(seisena: .blanca).tag(Seisena.blanca)
                        InfoSeisena(seisena: .negra).tag(Seisena.negra)
                        InfoSeisena(seisena: .gris).tag(Seisena.gris)
                        InfoSeisena(seisena: .parda).tag(Seisena.parda)
                    }
                }
                
                Section("Contacto de emergencia") {
                    TextField("Nombre", text: $integrantesViewModel.integranteNuevo.contactoEmergencia.nombre)
                    TextField("Teléfono", text: $integrantesViewModel.integranteNuevo.contactoEmergencia.numero)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
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

struct IntegranteNuevo_Previews: PreviewProvider {
    static let EnvObject = IntegrantesViewModel()

    @State var integranteNuevo = Integrante(nombre: "", fechaNacimiento: Date(), etapa: .pataTierna)
    static var previews: some View {
        IntegranteNuevo {
            print("aaa")
        }.environmentObject(EnvObject)
    }
}
