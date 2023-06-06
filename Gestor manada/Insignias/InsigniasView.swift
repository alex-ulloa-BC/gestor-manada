//
//  InsigniasView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 29/5/23.
//

import SwiftUI

struct InsigniasView: View {
    let possibleValues = [0,1,2]
    @State private var showEspecialidadForm = false
    @State private var showAlert = false
    @State private var integrante: Integrante = Integrante(nombre: "", fechaNacimiento: Date(), etapa: .pataTierna)
    @State private var especialidad: EspecialidadNombre = .arte
    @State private var valor = 0
    @EnvironmentObject var integrantesViewModel: IntegrantesViewModel
    
    func handleInsigniaMerito() {
        showAlert = true
    }
    
    func handleInsigniaEspecialidad() {
        withAnimation(.easeIn) {
            showEspecialidadForm = true
        }
    }
    
    func handleSaveEspecialidad() {
        var especialidades = integrante.especialidades ?? Especialidades()
        
        especialidades[especialidad] = valor + 1
        
        guard let id = integrante.id else {
            return
        }
        
        integrantesViewModel.agregarEspecialidad(id: id, especialidades: especialidades)
        
        withAnimation(.easeOut) {
            showEspecialidadForm = false
        }
    }
    
    var body: some View {
        VStack {
            
            if showEspecialidadForm {
                Form {
                    Picker("Integrante", selection: $integrante) {
                        ForEach(0..<integrantesViewModel.integrantes.count, id:\.self) {index in
                            Text(integrantesViewModel.integrantes[index].nombre).tag(integrantesViewModel.integrantes[index])
                        }
                    }
                    
                    Picker("Especialidad", selection: $especialidad) {
                        ForEach(TodasLasEspecialidades.indices, id: \.self) {i in
                            Text(TodasLasEspecialidades[i].rawValue).tag(TodasLasEspecialidades[i])
                        }
                    }
                    
                    Picker("Valor", selection: $valor) {
                        ForEach(possibleValues.indices, id: \.self) {i in
                            Text((i+1).description).tag(i)
                        }
                    }.pickerStyle(.segmented)
                    
                    Button(action: handleSaveEspecialidad) {
                        Text("Guardar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
            }
            
            Group {
                Button(action: handleInsigniaEspecialidad) {
                    HStack {
                        Text("Agregar insignia de Especialidad")
                        Spacer()
                        Image(systemName: "circle.hexagongrid.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }.frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
                
                Button(action: handleInsigniaMerito) {
                    HStack {
                        Text("Agregar insignia de Mérito")
                        Spacer()
                        Image(systemName: "trophy.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }.frame(maxWidth: .infinity)
                    
                }
                .buttonStyle(.borderedProminent)
                
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Bajo construcción"), message: Text("Pronto estará disponible esta funcionalidad"))
        }
        .padding(.horizontal)
    }
}

struct InsigniasView_Previews: PreviewProvider {
    static let EnvObject = IntegrantesViewModel()
    static var previews: some View {
        InsigniasView().environmentObject(EnvObject)
    }
}
