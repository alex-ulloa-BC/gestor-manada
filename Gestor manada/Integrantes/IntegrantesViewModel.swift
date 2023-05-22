//
//  IntegrantesViewModel.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//
//

import Combine
import FirebaseFirestoreSwift
import FirebaseFirestore
import SwiftUI

class IntegrantesViewModel: ObservableObject {
    static private let integrantesCollection = "integrantes"
    @Published var integrantes = [Integrante]()
    @Published var integranteNuevo: Integrante = Integrante(nombre: "", fechaNacimiento: Date(), etapa: .pataTierna, seisena: .blanca)
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let baseQuery: Query = Firestore.firestore().collection(integrantesCollection).limit(to: 50)
    
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
            listener = query.addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                guard let self = self else { return }
                self.integrantes = documents.compactMap { document in
                    do {
                        let integrante = try document.data(as: Integrante.self)
                        return integrante
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
    
    func query(nombre: String?, promesa: Bool?, etapa: Etapa?, sortOption: String?) -> Query {
        var filteredQuery = baseQuery
        
        if let nombre = nombre {
            filteredQuery = filteredQuery.whereField("nombre", isEqualTo: nombre)
        }
        
        if let promesa = promesa {
            filteredQuery = filteredQuery.whereField("promesa", isEqualTo: promesa)
        }
        
        if let etapa = etapa {
            filteredQuery = filteredQuery.whereField("etapa", isEqualTo: etapa)
        }
        
        if let sortOption = sortOption {
            filteredQuery = filteredQuery.order(by: sortOption)
        }
        
        return filteredQuery
    }
    
    
    func addIntegrante() {
        do {
            if let id = integranteNuevo.id {
                if let integranteDuplicado = integrantes.first(where: {$0.nombre == integranteNuevo.nombre}) {
                    if integranteDuplicado.id != id {
                        return
                    }
                }
                try db.collection(IntegrantesViewModel.integrantesCollection).document(id).setData(from: integranteNuevo)
            } else {
                if integrantes.first(where: {$0.nombre.uppercased() == integranteNuevo.nombre.uppercased()}) != nil {
                    return
                }
                try db.collection(IntegrantesViewModel.integrantesCollection).addDocument(from: integranteNuevo)
            }
            
        } catch {
            print(error)
        }
    }
}
