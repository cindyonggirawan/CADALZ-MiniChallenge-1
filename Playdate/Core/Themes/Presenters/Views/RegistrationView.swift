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
    
    @StateObject var memoryViewModel = MemoryViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottomLeading) {
                    Image("registration")
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading) {
                        Text("Welcome Couples!")
                            .font(.custom("Poppins-SemiBold", size: 28))
                            .foregroundColor(Color.primaryWhite)
                            .padding(.bottom, 4)
                        
                        Text("Tell us a little bit about you.")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.primaryLightGray)
                    }
                    .offset(x: 24, y: -80)
                }
                
                VStack(alignment: .leading) {
                    Group {
                        HStack {
                            Text("Your Name")
                                .font(.custom("Poppins-Medium", size: 16))
                                .foregroundColor(.primaryDarkBlue)
                            
                            Spacer()
                            
                            if name.count == 0 {
                                Text("\(name.count)/20")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.primaryDarkGray)
                            } else {
                                Text("\(name.count)/20")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.primaryDarkBlue)
                            }
                        }
                        
                        TextField("What do you like us to call you?", text: $name)
                            .limitInputLength(value: $name, length: 20)
                            .font(.system(size: 14))
                            .autocorrectionDisabled()
                            .foregroundColor(.primaryDarkGray)
                            .textFieldStyle(UnborderedTextFieldStyle())
                    }
                    .offset(y: -60)
                    
                    Spacer()
                    
                    if !name.isEmpty {
                        Button(action: {
                            userViewModel.addUser(name: name)
                            show = true
                        }, label: {
                            Text("Submit")
                                .font(.custom("Poppins-Bold", size: 14))
                        })
                        .buttonStyle(FixedSizeRoundedButtonStyle())
//                        .padding(.bottom, 32)
                    } else {
                        Button(action: {
                            show = false
                        }, label: {
                            Text("Submit")
                                .font(.custom("Poppins-Bold", size: 14))
                        })
                        .disabled(true)
                        .buttonStyle(FixedSizeRoundedButtonDisabledStyle())
//                        .padding(.bottom, 32)
                    }
                }
                .padding(24)
                .background(.white)
                .fullScreenCover(isPresented: $show) {
                    TabBarView()
                }
            }
        }
    }
}

//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationView()
//    }
//}

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
