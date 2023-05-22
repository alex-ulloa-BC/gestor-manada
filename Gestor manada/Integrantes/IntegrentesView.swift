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
        integrantesViewModel.integranteNuevo = Integrante(
            nombre: "",
            nombreCaza: "",
            fechaNacimiento: Date(),
            promesa: false,
            etapa: .pataTierna,
            carnetizado: false,
            seisena: .blanca,
            especialidades: nil,
            contactoEmergencia: ContactoEmergencia(nombre: "", numero: "")
        )
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
            List(integrantesViewModel.integrantes.sorted {$0.nombre < $1.nombre}) { integrante in
                NavigationLink(integrante.nombre, value: integrante)
                
            }
            .navigationDestination(for: Integrante.self) {integrante in
                VStack {
                    IntegranteInfo(integrante: integrante)
                }
            }
            
            Button(action: agregarIntegrante) {
                Text("Agregar integrante")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
                .padding()
            Spacer()
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
        .environmentObject(integrantesViewModel)
    }
}

struct IntegrentesView_Previews: PreviewProvider {
    static let EnvObject = IntegrantesViewModel()
    static var previews: some View {
        IntegrentesView().environmentObject(EnvObject)
    }
}
