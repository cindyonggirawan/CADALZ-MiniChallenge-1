//
//  ChallengeSubmitModal.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 23/04/23.
//

import SwiftUI

struct ChallengeSubmitModal: View {
    @State var momentDescription = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ChallengeCardSmall()
                Spacer()
                Text("Add photos")
                    .frame(width: 342, height: 24, alignment: .leading)
                    .font(.custom("Poppins", size: 16))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                Spacer()
                Text("Write about this moment")
                    .frame(width: 342, height: 24, alignment: .leading)
                    .font(.custom("Poppins", size: 16))
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
                // ADD PHOTO VIEW
                
                TextField("How do you feel doing this challenge?", text: $momentDescription, axis: .vertical)
                    .lineLimit(5, reservesSpace: true)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 24)
                    .font(.custom("Poppins", size:14))
                    .foregroundColor(.primaryLightGray)
//                    .clipShape(Rectangle())
                
                Spacer()
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Prev") {
//                            INSERT PREV FUNCTION
                            
                        }
                    }
                }
        }
    }
}

struct ChallengeSubmitModal_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeSubmitModal()
    }
}
