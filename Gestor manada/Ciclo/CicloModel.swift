//
//  CicloModel.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 19/6/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Actividades: Codable, Hashable {
    var fecha: Date;
    var nombre: String;
    var notas: String;
}

struct CicloDePrograma: Codable, Identifiable, Hashable {
    static func == (lhs: CicloDePrograma, rhs: CicloDePrograma) -> Bool {
        return lhs.nombre.uppercased() == rhs.nombre.uppercased()
    }
    
    @DocumentID var id: String?
    var nombre: String;
    var fechaInicio: Date;
    var fechaFin: Date;
    var actividades: [Actividades] = []
}
