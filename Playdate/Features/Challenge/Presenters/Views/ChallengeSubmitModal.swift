//
//  ChallengeSubmitModal.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 23/04/23.
//

import SwiftUI

struct ChallengeSubmitModal: View {
    @State var momentDescription = ""
//    @State var navChallengeModal = 1
//    
    var body: some View {
        VStack {
            Text("Add photos")
                .frame(width: 342, height: 24, alignment: .leading)
                .font(.custom("Poppins", size: 16))
                .foregroundColor(.black)
                .padding(.horizontal, 16)
            Rectangle()
                .frame(width: 80, height: 80)
                .foregroundColor(.primaryDarkGray)
                .padding(.bottom, 32)
            Text("Write about this moment")
                .frame(width: 342, height: 24, alignment: .leading)
                .font(.custom("Poppins", size: 16))
                .foregroundColor(.black)
                .padding(.bottom, 8)
            // ADD PHOTO VIEW
            
            TextField("How do you feel doing this challenge?", text: $momentDescription, axis: .vertical)
                .lineLimit(6, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 24)
                .font(.custom("Poppins", size:14))
                .foregroundColor(.primaryLightGray)
            //                    .clipShape(Rectangle())
            Spacer()
            Button(action: {
                //TODO: send isLike data to firebase
//                FBaddLikeToChallenge()
            }, label: {
                Text("Submit")
                    .font(.custom("Poppins-Bold", size: 14))
            })
            .buttonStyle(FixedSizeRoundedButtonStyle())
            .padding(.bottom, 46)
        }
    }
}

struct ChallengeSubmitModal_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeSubmitModal()
    }
}
