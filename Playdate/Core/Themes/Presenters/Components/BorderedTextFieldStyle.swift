//
//  BorderedTextFieldStyle.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 23/04/23.
//

import SwiftUI

struct BorderedTextFieldStyle: TextFieldStyle {
    var cornerRadius: CGFloat
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.primaryWhite)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.primaryLightGray, lineWidth: 2)
            )
            .foregroundColor(Color.primaryDarkBlue)
            .padding(.horizontal, 25)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Enter your name", text: .constant(""))
            .textFieldStyle(BorderedTextFieldStyle(cornerRadius: 10))
    }
}
