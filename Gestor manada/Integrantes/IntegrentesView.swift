//
//  IntegrentesView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct IntegrentesView: View {
    @EnvironmentObject var integrantesViewModel: IntegrantesViewModel
    @State private var isShowingSheet = false
    @State private var filtro = ""
    
    func agregarIntegrante() {
        integrantesViewModel.integranteNuevo = Integrante(
            nombre: "",
            nombreCaza: "",
            fechaNacimiento: Date(),
            promesa: false,
            etapa: .pataTierna,
            carnetizado: false,
            seisena: .blanca,
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
            
            TextField("Filtrar...", text: $filtro)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            List(integrantesViewModel.integrantes.filter{$0.nombre.uppercased().contains(filtro.isEmpty ? " " :  filtro.uppercased())}) { integrante in
                NavigationLink(integrante.nombre, value: integrante)
                
            }
            .navigationDestination(for: Integrante.self) {integrante in
                VStack {                    IntegranteInfo(integrante: integrante) 
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
            let query = integrantesViewModel.query(nombre: nil, promesa: nil, etapa: nil, sortOption: nil)
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
    static let EnvObject = IntegrantesViewModel()
    static var previews: some View {
        IntegrentesView().environmentObject(EnvObject)
    }
}
