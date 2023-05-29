//
//  ActividadesView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct ActividadesView: View {
    @ObservedObject var actividadesViewModel = ActividadesViewModel()
    @State private var isShowingSheet = false
    
    func agregarActividad() {
        actividadesViewModel.actividadNueva = Actividad(nombre: "", fecha: Date(), tipo: .aventura)
        isShowingSheet = true
    }
    
    func handleCloseSheet() {
        isShowingSheet = false
    }
    
    var body: some View {
        VStack {
            NavigationStack{
                
                
                Text("Actividades Destacables")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.mint)
                List(actividadesViewModel.actividades.sorted {$0.fecha > $1.fecha}) { actividad in
                    NavigationLink(actividad.nombre, value: actividad)
                    
                }
                .navigationDestination(for: Actividad.self) {actividad in
                    VStack {
                        ActividadInfo(actividad: actividad)
                    }
                }
                
                Button(action: agregarActividad) {
                    Text("Agregar Actividad")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
                    .padding()
                Spacer()
            }
        }
        .onAppear {
            actividadesViewModel.subscribe()
        }
        .onDisappear {
            actividadesViewModel.unsubscribe()
        }
        .sheet(isPresented: $isShowingSheet, onDismiss: handleCloseSheet) {
            ActividadNuevo(handleClose: handleCloseSheet)
        }
        .environmentObject(actividadesViewModel)
    }
}

struct ActividadesView_Previews: PreviewProvider {
    static let EnvObject = ActividadesViewModel()
    
    static var previews: some View {
        ActividadesView().environmentObject(EnvObject)
    }
}
