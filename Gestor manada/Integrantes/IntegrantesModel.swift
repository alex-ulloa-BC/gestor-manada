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

enum Etapa: String, Codable {
    case pataTierna = "Pata Tierna"
    case rastreador = "Rastreador"
    case saltador = "Saltador"
    case cazador = "Cazador"
}

struct Integrante: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var nombre: String;
    var fechaNacimiento: Date;
    var promesa: Bool;
    var etapa: Etapa;
}
