//
//  UnborderedTextFieldStyle.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 24/04/23.
//

import SwiftUI

struct UnborderedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .lineLimit(6, reservesSpace: true)
            .padding(20)
            .foregroundColor(Color.black)
            .background(Color.primaryLightGray)
            .cornerRadius(10)
    }
}

struct UnborderedTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Enter your name", text: .constant(""))
            .textFieldStyle(UnborderedTextFieldStyle())
    }
}
