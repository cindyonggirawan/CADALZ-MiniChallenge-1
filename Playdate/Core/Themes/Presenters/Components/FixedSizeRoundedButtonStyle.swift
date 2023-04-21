//
//  FixedSizeRoundedButtonStyle.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 21/04/23.
//

import SwiftUI

struct FixedSizeRoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Color.primaryDarkBlue
                .frame(width: 330, height: 50)
                .cornerRadius(10)
            configuration.label
                .foregroundColor(Color.primaryWhite)
        }
    }
}

struct FixedSizeRoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
        
        }, label: {
            Text("Next")
        })
        .buttonStyle(FixedSizeRoundedButtonStyle())
    }
}
