//
//  InsigniasModel.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 29/5/23.
//

import Foundation
import FirebaseFirestoreSwift

enum TipoInsignia: String, Codable {
    case especialidad = "especialidad"
    case merito = "merito"
}

struct Insignia: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var tipo: TipoInsignia
    var integrante: Integrante
    var valor: String
    
    var nombre: String;
    var nombreCaza: String?
    var fechaNacimiento: Date
    var promesa: Bool = false
    var etapa: Etapa
    var carnetizado: Bool = false
    var seisena: Seisena = .negra
    var especialidades: [Especialidad]?
    var contactoEmergencia: ContactoEmergencia = ContactoEmergencia(nombre: "", numero: "")
}
