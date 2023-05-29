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
    @ObservedObject var integrantesViewModel = IntegrantesViewModel()
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let baseQuery: Query = Firestore.firestore().collection(actividadesCollection)
    
    init() {
        let q = integrantesViewModel.query(nombre: nil, promesa: nil, etapa: nil, sortOption: nil)
        integrantesViewModel.subscribe(to: q)
    }
    
    deinit {
        unsubscribe()
        integrantesViewModel.unsubscribe()
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
                let actividadesFS = documents.compactMap { document in
                    do {
                        let actividad = try document.data(as: ActividadFirestore.self)
                        return actividad
                    } catch {
                        print(error)
                        return nil
                    }
                }
                
                self.actividades = actividadesFS.map{ afs in
                    let participantes = afs.participantes.compactMap { ref in
                        let participante = self.integrantesViewModel.integrantes.first(where: {$0.id == ref.documentID})
                        return participante
                        
                    }
                    
                    print("*****", participantes)
                    
                    let actividad = Actividad(
                        id: afs.id,
                        nombre: afs.nombre,
                        fecha: afs.fecha,
                        tipo: afs.tipo,
                        participantes: participantes
                    )
                    return actividad
                }
            }
        }
    }
    
    func filter() {
        unsubscribe()
        subscribe()
    }
    
    
    func addActividad() {
        
        let participantes = actividadNueva.participantes.compactMap { p -> DocumentReference? in
            guard let id = p.id else {
                return nil
            }
            
            let docRef = db.document(IntegrantesViewModel.integrantesCollection+"/"+id)
            return docRef
        }
        
        do {
            if let id = actividadNueva.id {
                if let actividadDuplicada = actividades.first(where: {$0.nombre == actividadNueva.nombre}) {
                    if actividadDuplicada.id != id {
                        return
                    }
                }
                
                let actividadDB = ActividadFirestore(
                    id: id,
                    nombre: actividadNueva.nombre,
                    fecha: actividadNueva.fecha,
                    tipo: actividadNueva.tipo,
                    participantes: participantes
                )
                
                try db.collection(ActividadesViewModel.actividadesCollection).document(id).setData(from: actividadDB)
            } else {
                if actividades.first(where: {$0.nombre.uppercased() == actividadNueva.nombre.uppercased()}) != nil {
                    return
                }
                
                
                let actividadDB = ActividadFirestore(
                    nombre: actividadNueva.nombre,
                    fecha: actividadNueva.fecha,
                    tipo: actividadNueva.tipo,
                    participantes: participantes
                )
                
                try db.collection(ActividadesViewModel.actividadesCollection).addDocument(from: actividadDB)
            }
            
        } catch {
            print(error)
        }
    }
}
