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
                .cornerRadius(10)
            configuration.label
                .foregroundColor(Color.primaryWhite)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
}

struct FixedSizeRoundedButtonDisabledStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Color.primaryDarkGray
                .cornerRadius(10)
            configuration.label
                .foregroundColor(Color.primaryWhite)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
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
