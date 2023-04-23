//
//  ChallengeCardSmall.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 22/04/23.
//

import SwiftUI

struct ChallengeCardSmall: View {
    var body: some View {
        VStack(alignment: .center) {            Text("Your Challenge")
                .frame(width: 290, alignment: .leading)
                .font(.custom("Poppins", size: 12))
                .foregroundColor(.primaryWhite)
//            BINGUNG NGATUR INI GIMANA
                .opacity(0.5)
//            Spacer()
            Text("Watch a horror film released before the year 2000 with your partner")
                .font(.custom("Poppins-SemiBold", size: 16))
                .foregroundColor(.primaryWhite)
                .padding(.horizontal, 16)
//            Spacer()
        }
        .frame(width: 342, height: 99)
        .background(Color.primaryPurple)
        .cornerRadius(16)
    }
}

struct ChallengeCardSmall_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeCardSmall()
    }
}
