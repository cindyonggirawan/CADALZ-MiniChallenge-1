//
//  FixedSizeNoFillRoundedButtonStyle.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 03/05/23.
//

import SwiftUI

struct FixedSizeNoFillRoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Color.primaryWhite
                .cornerRadius(10)
            configuration.label
                .foregroundColor(Color.primaryDarkBlue)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.primaryDarkBlue, lineWidth: 1)
        )
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
}

struct FixedSizeNoFillRoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
        
        }, label: {
            Text("Next")
        })
        .buttonStyle(FixedSizeNoFillRoundedButtonStyle())
    }
}
