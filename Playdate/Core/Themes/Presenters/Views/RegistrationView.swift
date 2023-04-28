//
//  RegistrationView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 23/04/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name: String = ""
    @State private var show = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Welcome Couples")
                    .font(.custom("Poppins", size: 24))
                    .fontWeight(.bold)
                    .padding(.top, 32)
                    .padding(.bottom, 4)
                
                Text("Tell us about you to get to know you better.")
                    .font(.custom("Poppins", size: 16))
                    .padding(.bottom, 32)
                
                Text("Your Name")
                    .font(.custom("Poppins", size: 16))
                    .fontWeight(.bold)
                
                TextField("Enter your name", text: $name)
                    .limitInputLength(value: $name, length: 10)
                    .font(.custom("Poppins", size: 16))
                    .autocorrectionDisabled()
                    .textFieldStyle(UnborderedTextFieldStyle())
                
                
                Spacer()
                
                if !name.isEmpty {
                    Button(action: {
                        show = true
                    }, label: {
                        Text("Submit")
                            .font(.custom("Poppins", size: 16))
                    })
                    .buttonStyle(FixedSizeRoundedButtonStyle())
                    .padding(.bottom, 32)
                } else {
                    Button(action: {
                        show = false
                    }, label: {
                        Text("Submit")
                            .font(.custom("Poppins", size: 16))
                    })
                    .disabled(true)
                    .buttonStyle(FixedSizeRoundedButtonDisabledStyle())
                    .padding(.bottom, 32)
                }
            }
            .padding(24)
            .fullScreenCover(isPresented: $show) {
                TabBarView()
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
