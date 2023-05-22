//
//  ActividadesViewModel.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 22/5/23.
//


import Combine
import FirebaseFirestoreSwift
import FirebaseFirestore
import SwiftUI

class ActividadesViewModel: ObservableObject {
    static private let actividadesCollection = "actividades"
    @Published var actividades = [Actividad]()
    @Published var actividadNueva: Actividad = Actividad(nombre: "", fecha: Date(), tipo: .aventura)
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let baseQuery: Query = Firestore.firestore().collection(actividadesCollection)
    
    deinit {
        unsubscribe()
    }
    
    func unsubscribe() {
        if listener != nil {
            listener?.remove()
            listener = nil
        }
    }
    
    func subscribe() {
        if listener == nil {
            listener = baseQuery.addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                guard let self = self else { return }
                self.actividades = documents.compactMap { document in
                    do {
                        let actividad = try document.data(as: Actividad.self)
                        return actividad
                    } catch {
                        print(error)
                        return nil
                    }
                }
            }
        }
    }
    
    func filter() {
        unsubscribe()
        subscribe()
    }
    
    
    func addActividad() {
        do {
            if let id = actividadNueva.id {
                if let actividadDuplicada = actividades.first(where: {$0.nombre == actividadNueva.nombre}) {
                    if actividadDuplicada.id != id {
                        return
                    }
                }
                try db.collection(ActividadesViewModel.actividadesCollection).document(id).setData(from: actividadNueva)
            } else {
                if actividades.first(where: {$0.nombre.uppercased() == actividadNueva.nombre.uppercased()}) != nil {
                    return
                }
                try db.collection(ActividadesViewModel.actividadesCollection).addDocument(from: actividadNueva)
            }

        } catch {
            print(error)
        }
    }
}
