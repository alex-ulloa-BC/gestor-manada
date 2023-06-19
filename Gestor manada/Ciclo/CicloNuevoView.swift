//
//  CicloNuevoView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 19/6/23.
//

import SwiftUI

struct CicloNuevoView: View {
    @StateObject var cicloViewModel: CicloViewModel
    @State var nuevaActividad = Actividades(fecha: Date(), nombre: "", notas: "")
    @State var showAlert = false
    @State var errorText = ""
    
    
    var handleClose: () -> Void
    
    func validateCiclo() {
        guard !cicloViewModel.cicloNuevo.nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert = true
            errorText = "Falta el nombre del ciclo"
            return
        }
        
        guard !cicloViewModel.cicloNuevo.actividades.isEmpty else {
            showAlert = true
            errorText = "Faltan actividades"
            return
        }
    }
    
    func handleSave() {
        validateCiclo()
        cicloViewModel.addCiclo()
        handleClose()
    }
    
    func handleDelete(offset: IndexSet) {
        withAnimation(.easeOut) {
            cicloViewModel.cicloNuevo.actividades.remove(atOffsets: offset)
        }
    }
    
    func handleAddActividad() {
        guard !nuevaActividad.nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert = true
            errorText = "Falta el nombre de la actividad"
            return
        }
        
        withAnimation(.easeIn) {
            cicloViewModel.cicloNuevo.actividades.append(nuevaActividad)
            nuevaActividad = Actividades(fecha: Date(), nombre: "", notas: "")
        }
    }
    
    var body: some View {
        VStack{
            Form {
                Section("Datos del Ciclo de programa") {
                    TextField("Nombre", text: $cicloViewModel.cicloNuevo.nombre)
                    DatePicker("Fecha de Inicio", selection: $cicloViewModel.cicloNuevo.fechaInicio, displayedComponents: .date)
                    DatePicker("Fecha de Fin", selection: $cicloViewModel.cicloNuevo.fechaFin, displayedComponents: .date)
                    
                }
                
                
                Section("Nueva actividad") {
                    TextField("Nombre", text: $nuevaActividad.nombre)
                    DatePicker("Fecha", selection: $nuevaActividad.fecha, in: cicloViewModel.cicloNuevo.fechaInicio...cicloViewModel.cicloNuevo.fechaFin, displayedComponents: .date)
                    TextField("Notas", text: $nuevaActividad.notas, axis: .vertical).lineLimit(3)
                    
                    Button("Agregar actividad") {
                        handleAddActividad()
                    }
                }
                
                Section("Actividades") {
                    
                    ForEach($cicloViewModel.cicloNuevo.actividades, id: \.self) {
                        $actividad in
                        HStack {
                            Text(actividad.nombre)
                            Spacer()
                            Text(actividad.fecha.formatted(date: .abbreviated, time: .omitted))
                                .foregroundColor(.gray)
                        }
                        
                    }.onDelete(perform: handleDelete)
                }
            }
            
            Button(action: handleSave) {
                Text("Guardar").frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorText))
        }
    }
}

struct CicloNuevoView_Previews: PreviewProvider {
    static var cvm = CicloViewModel()
    
    static var previews: some View {
        CicloNuevoView(cicloViewModel: cvm) {
            print("hola")
        }
    }
}
