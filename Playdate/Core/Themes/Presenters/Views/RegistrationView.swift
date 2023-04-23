//
//  RegistrationView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 23/04/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Your Name")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 25)
                
                Spacer()
            }
            
            TextField("Enter your name", text: $name)
                .textFieldStyle(BorderedTextFieldStyle(cornerRadius: 10))
                .padding(.bottom)
            
            Button(action: {
            
            }, label: {
                Text("Submit")
            })
            .buttonStyle(FixedSizeRoundedButtonStyle())
            
            Spacer()
        }
        .padding(.top, 35)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
