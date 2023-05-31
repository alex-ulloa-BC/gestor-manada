//
//  Integrantes.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import Foundation
import FirebaseFirestoreSwift

extension Date {
    init? (value: String) {
        let dtFormatter = DateFormatter()
        
        dtFormatter.dateFormat = "yyyy/MM/dd";
        if let date = dtFormatter.date(from: value) {
            self = date
        } else {
            return nil
        }
    }
}

public enum Etapa: String, Codable {
    case pataTierna = "Pata Tierna"
    case rastreador = "Rastreador"
    case saltador = "Saltador"
    case cazador = "Cazador"
}

enum Seisena: String, Codable {
    case negra = "Seisena Negra"
    case blanca = "Seisena Blanca"
    case parda = "Seisena Parda"
    case gris = "Seisena Gris"
}

public enum EspecialidadNombre: String, Codable {
    case arte = "Arte"
    case ciencia = "Ciencia y tecnología"
    case deporte = "Deportes"
    case fe = "Fe"
    case naturaleza = "Vida en la Naturaleza"
    case servicio = "Servicio"
    
}


struct Especialidad: Codable, Hashable {
    var especialidad: EspecialidadNombre
    var valor: Int
}

struct ContactoEmergencia: Codable, Hashable {
    var nombre: String
    var numero: String
}

struct Integrante: Codable, Identifiable, Hashable {
    static func == (lhs: Integrante, rhs: Integrante) -> Bool {
        return lhs.nombre == rhs.nombre
    }
    
    @DocumentID var id: String?
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

public let etapaEdad: [Int: Etapa] = [
    0: .pataTierna,
    1: .pataTierna,
    2: .pataTierna,
    3: .pataTierna,
    4: .pataTierna,
    5: .pataTierna,
    6: .pataTierna,
    7: .pataTierna,
    8: .saltador,
    9: .saltador,
    10: .rastreador,
    11: .cazador,
    12: .cazador,
]

public let TodasLasEspecialidades: [EspecialidadNombre] = [
    .arte,
    .ciencia,
    .deporte,
    .fe,
    .naturaleza,
    .servicio
]

