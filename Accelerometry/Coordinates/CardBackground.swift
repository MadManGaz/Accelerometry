//
//  CardBackground.swift
//  Accelerometry
//
//  Created by Gary Moore on 28/02/2021.
//

import SwiftUI

/// Simple red card background with a shadow. Useful for creating CardView style views.
struct CardBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(Color(UIColor.systemRed))
            .shadow(color: Color.red.opacity(0.6), radius: 5, x: 0.0, y: 0.0)
    }
}

struct CardBackground_Previews: PreviewProvider {
    static var previews: some View {
        CardBackground()
    }
}
