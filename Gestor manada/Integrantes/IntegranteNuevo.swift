//
//  IntegranteNuevo.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct IntegranteNuevo: View {
    @State var nombre: String = ""
    @State var fechaNacimiento: Date = Date()
    @State var promesa: Bool = false
    @State var etapa: Etapa = .pataTierna
    private let integrantesViewModel = IntegrantesViewModel()
    var handleClose: () -> Void
    
    func handleSave() {
        let nuevoIntegrante = Integrante(nombre: nombre, fechaNacimiento: fechaNacimiento, promesa: promesa, etapa: etapa)
        
        integrantesViewModel.addIntegrante(integrante: nuevoIntegrante)
        
        handleClose()
    }
    
    var body: some View {
        VStack{
            Form {
                Section("Datos del lobato") {
                    TextField("Nombre", text: $nombre)
                    DatePicker("Fecha de Nacimiento", selection: $fechaNacimiento, in: ...Date(), displayedComponents: .date)
                    Toggle("Promesa", isOn: $promesa)
                    
                    Picker("Etapa", selection: $etapa) {
                        Text(Etapa.pataTierna.rawValue).tag(Etapa.pataTierna)
                        Text(Etapa.saltador.rawValue).tag(Etapa.saltador)
                        Text(Etapa.rastreador.rawValue).tag(Etapa.rastreador)
                        Text(Etapa.cazador.rawValue).tag(Etapa.cazador)
                    }
                }
                
            }
            
            HStack {
                Button(action: handleSave) {
                    Text("Guardar")
                }.frame(width: .infinity)
                    .background(.black)
                    .buttonStyle(.borderedProminent)
                
                Button(action: handleClose) {
                    Text("Cancelar")
                }.buttonStyle(.bordered).foregroundColor(.red)
            }
        }
        
    }
}

struct IntegranteNuevo_Previews: PreviewProvider {
    static var previews: some View {
        IntegranteNuevo() {
            print("aaa")
        }
    }
}
