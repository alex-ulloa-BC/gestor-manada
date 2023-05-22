//
//  InfoRow.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 22/5/23.
//

import SwiftUI

struct InfoRow: View {
    var label: String
    var value: String
    
    var body: some View {
        
        HStack {
            Text(label)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
        }
        .padding(.horizontal)
        .padding(.top)
        
        Divider()
            .frame(height: 1)
            .padding(.horizontal)
            .background(.gray)
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(label: "Nombre", value: "Alex Ulloa")
    }
}
