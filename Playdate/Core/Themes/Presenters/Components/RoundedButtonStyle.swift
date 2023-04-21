//
//  RoundedButtonStyle.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 21/04/23.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(Color.primaryWhite)
            .background(Color.primaryDarkBlue)
            .cornerRadius(10)
    }
}

struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
        
        }, label: {
            Text("Next")
        })
        .buttonStyle(RoundedButtonStyle())
    }
}
