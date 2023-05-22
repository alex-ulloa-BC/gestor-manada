//
//  IntegrentesView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct IntegrentesView: View {
    @ObservedObject var integrantesViewModel = IntegrantesViewModel()
    @State var promesa: Bool? = nil
    @State private var isShowingSheet = false
    
    func agregarIntegrante() {
        isShowingSheet = true
    }
    
    func handleCloseSheet() {
        isShowingSheet = false
    }
    
    var body: some View {
        NavigationStack {
            Text("Manada Colmillo Blanco")
                .bold()
                .font(.title2)
                .foregroundColor(.mint)
            List(integrantesViewModel.integrantes) { integrante in
                NavigationLink(integrante.nombre, value: integrante)
                
            }
            .navigationDestination(for: Integrante.self) {integrante in
                VStack {
                    IntegranteInfo(integrante: integrante)
                }
            }
            
            Button(action: agregarIntegrante) {
                Text("Agregar integrante")
            }.buttonStyle(.bordered)
        }
        .onAppear {
            let query = integrantesViewModel.query(nombre: nil, promesa: promesa, etapa: nil, sortOption: nil)
            integrantesViewModel.subscribe(to: query)
        }
        .onDisappear {
            integrantesViewModel.unsubscribe()
        }
        .sheet(isPresented: $isShowingSheet, onDismiss: handleCloseSheet) {
            IntegranteNuevo(handleClose: handleCloseSheet)
        }
    }
}

struct IntegrentesView_Previews: PreviewProvider {
    static var previews: some View {
        IntegrentesView()
    }
}
