//
//  CicloView.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 19/6/23.
//

import SwiftUI

struct CicloView: View {
    @ObservedObject var cicloViewModel: CicloViewModel = CicloViewModel()
    @State private var isShowingSheet = false
    
    func agregarCiclo() {
        isShowingSheet = true
    }
    
    func handleCloseSheet() {
        isShowingSheet = false
    }
    
    var body: some View {
        VStack {
            Text("Ciclos de programa")
                .bold()
                .font(.title2)
                .foregroundColor(.mint)
            
            List(cicloViewModel.ciclos) { ciclo in
                Text(ciclo.nombre)
            }
            
            Spacer()
            
            Button(action: agregarCiclo) {
                HStack{
                    Image(systemName: "calendar.badge.plus")
                    Text("Agregar Ciclo")
                }
                .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
                .padding()
        }
        .onAppear {
            let query = cicloViewModel.query(nombre: nil, sortOption: nil)
            cicloViewModel.subscribe(to: query)
        }
        .onDisappear {
            cicloViewModel.unsubscribe()
        }
        .sheet(isPresented: $isShowingSheet, onDismiss: handleCloseSheet) {
            CicloNuevoView(cicloViewModel: cicloViewModel, handleClose: handleCloseSheet)
        }
    }
}

struct CicloView_Previews: PreviewProvider {
    static var previews: some View {
        CicloView()
    }
}
