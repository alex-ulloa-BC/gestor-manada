//
//  IntegranteViewModel.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 31/5/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


class IntegranteViewModel: ObservableObject {
    @Published var integrante: Integrante = Integrante(nombre: "", fechaNacimiento: Date(), etapa: .pataTierna, seisena: .blanca)
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let baseQuery: Query = Firestore.firestore().collection(IntegrantesViewModel.integrantesCollection).limit(to: 50)
    
    deinit {
        unsubscribe()
    }
    
    func unsubscribe() {
        if listener != nil {
            listener?.remove()
            listener = nil
        }
    }
    
    func subscribe(id: String) {
        if listener == nil {
            listener = db.document("integrantes/\(id)").addSnapshotListener { [weak self] querySnapshot, error in
                
                if let error = error {
                    print("error : \(error)")
                    return
                }
                
                guard let querySnapshot = querySnapshot, querySnapshot.exists else {
                    return
                }
                do {
                    let integranteDB = try querySnapshot.data(as: Integrante.self)
                    
                    guard let self = self else { return }
                    self.integrante = integranteDB
                } catch {
                    print(error)
                }
            }
        }
    }
    
//    func agregarEspecialidad(_ especialidad: Especialidad) {
//        var nuevo = integrante
//        guard let id = integrante.id else {
//            return
//        }
//        
//        if let especialidades = integrante.especialidades {
//            if let mismaEspecialidad = especialidades.first(where: {$0.especialidad == especialidad.especialidad}) {
//                
//                if mismaEspecialidad.valor == especialidad.valor {
//                    // le esta quitando
//                    nuevo.especialidades = especialidades.filter({$0 != especialidad})
//                    
//                } else {
//                    // le esta cambiando el valor
//                    guard let index = especialidades.firstIndex(where: {$0.especialidad == especialidad.especialidad} ) else {
//                        return
//                    }
//                    nuevo.especialidades?[index] = especialidad
//                }
//                
//            } else {
//                // no tiene esta especialidades
//                nuevo.especialidades?.append(especialidad)
//            }
//        } else {
//            // no tiene, se agrega el array con esta
//            nuevo.especialidades = [especialidad]
//        }
//        
//        do {
//            try db.collection(IntegrantesViewModel.integrantesCollection).document(id).setData(from: nuevo)
//            
//            integrante.especialidades = nuevo.especialidades
//        } catch {
//            print(error)
//        }
//    }
    
}
