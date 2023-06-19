//
//  CicloViewModel.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 19/6/23.
//

import Combine
import FirebaseFirestoreSwift
import FirebaseFirestore

class CicloViewModel: ObservableObject {
    static public let ciclosCollection = "ciclos"
    @Published var ciclos = [CicloDePrograma]()
    @Published var cicloNuevo = CicloDePrograma(nombre: "", fechaInicio: Date(), fechaFin: Date())
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let baseQuery: Query = Firestore.firestore().collection(ciclosCollection).limit(to: 50)
    
    deinit {
        unsubscribe()
    }
    
    func unsubscribe() {
        if listener != nil {
            listener?.remove()
            listener = nil
        }
    }
    
    func subscribe(to query: Query) {
        if listener == nil {
            listener = query.addSnapshotListener(includeMetadataChanges: true) { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                guard let self = self else { return }
                self.ciclos = documents.compactMap { document in
                    do {
                        let ciclo = try document.data(as: CicloDePrograma.self)
                        return ciclo
                    } catch {
                        print(error)
                        return nil
                    }
                }
            }
        }
    }
    
    func filter(query: Query) {
        unsubscribe()
        subscribe(to: query)
    }
    
    func query(nombre: String?, sortOption: String?) -> Query {
        var filteredQuery = baseQuery
        
        if let nombre = nombre {
            filteredQuery = filteredQuery.whereField("nombre", isEqualTo: nombre)
        }
        
        if let sortOption = sortOption {
            filteredQuery = filteredQuery.order(by: sortOption)
        }
        
        return filteredQuery.order(by: "fechaInicio")
    }
    
    
    func addCiclo() {
        do {
            if let id = cicloNuevo.id {
                if let cicloDuplicado = ciclos.first(where: {$0.nombre.uppercased() == cicloNuevo.nombre.uppercased()}) {
                    if cicloDuplicado.id != id {
                        return
                    }
                }
                try db.collection(CicloViewModel.ciclosCollection).document(id).setData(from: cicloNuevo)
            } else {
                if ciclos.first(where: {$0.nombre.uppercased() == cicloNuevo.nombre.uppercased()}) != nil {
                    return
                }
                try db.collection(CicloViewModel.ciclosCollection).addDocument(from: cicloNuevo)
            }
            
        } catch {
            print(error)
        }
    }
}
