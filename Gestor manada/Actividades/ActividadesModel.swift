//
//  ActividadesModel.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 22/5/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

enum TipoActividad: String, Codable {
    case aventura = "Aventura"
    case hermandad = "Hermandad Scout"
    case emprendimiento = "Emprendimiento"
    case salud = "Seguridad y Salud"
    case cultural = "Cultural"
    case servicio = "Servicios y Espiritualidad"
}
struct ActividadFirestore: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var nombre: String
    var fecha: Date
    var tipo: TipoActividad
    var participantes = [DocumentReference]()
}


struct Actividad: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var nombre: String
    var fecha: Date
    var tipo: TipoActividad
    var participantes = [Integrante]()
}
