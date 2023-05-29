//
//  DividerAdjusted.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 29/5/23.
//

import SwiftUI

struct DividerAdjusted: View {
    var body: some View {
        Divider()
            .frame(height: 1)
            .padding(.horizontal)
            .background(.gray)
    }
}

struct DividerAdjusted_Previews: PreviewProvider {
    static var previews: some View {
        DividerAdjusted()
    }
}
