//
//  ChallengeCardSmall.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 22/04/23.
//

import SwiftUI

struct ChallengeCardSmall: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Challenge")
                .font(.custom("Poppins", size: 16))
                .foregroundColor(Color.primaryWhite)
                .opacity(0.5)
                .padding(.bottom, 4)

            Text("Watch a horror film released before the year 2000 with your partner")
                .font(.custom("Poppins-SemiBold", size: 22))
                .foregroundColor(Color.primaryWhite)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.primaryPurple)
        .cornerRadius(8)
    }
}

struct ChallengeCardSmall_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeCardSmall()
    }
}
