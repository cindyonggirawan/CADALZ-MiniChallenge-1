//
//  GenerateChallengeView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct GenerateChallengeView: View {
    var body: some View {
        //TODO: BELUM RESPONSIVE
        VStack {
            //Title
            VStack(alignment: .leading) {
                //TODO: Nama user ambil dari coredata
                HStack{
                    Text("Hi Alfine,")
                        //TODO: Font Family Poppins
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(.primaryDarkGray)
                        .padding(.bottom, -1)
                    Spacer()
                }
                
                Text("What challenge do you want for your next date?")
                    //TODO: Font Family Poppins
                    .font(.system(size: 22))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .padding(.vertical, 25)
            .frame(maxWidth: 342)
            
            //Category Capsule
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    //TODO: Set Category Value
                    CategoryCapsuleView()
                    CategoryCapsuleView()
                    CategoryCapsuleView()
                    CategoryCapsuleView()
                }
            }
            .frame(maxWidth: 342)
            .padding(.bottom, 20)
            
            
            //Challenge Card
            //TODO: Card ZStack View & Logic
            ChallengeCardView()
            
            //Accept Button
            Button(action: {
                //TODO: Accept Action
                
            }, label: {
                Text("Accept Challenge!")
                    //TODO: Set Font Family "Poppins"
                    .font(.system(size: 14))
                    .fontWeight(.bold)
            })
            .buttonStyle(FixedSizeRoundedButtonStyle())
            .padding(.top, 20)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct GenerateChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateChallengeView()
    }
}
