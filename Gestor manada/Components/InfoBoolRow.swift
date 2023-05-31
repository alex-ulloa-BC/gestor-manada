//
//  InfoBoolRow.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 30/5/23.
//

import SwiftUI

struct InfoBoolRow: View {
    var label: String
    var value: Bool
    
    var body: some View {
        
        HStack {
            Text(label)
                .foregroundColor(.gray)
            Spacer()
            Toggle("", isOn: .constant(value))
        }
        .padding(.horizontal)
        .padding(.top)
        DividerAdjusted()
    }
}

struct InfoBoolRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InfoBoolRow(label: "Carnetizado", value: true)
            InfoBoolRow(label: "Promesa", value: false)
        }
        
    }
}
