//
//  ChallengeCardView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct ChallengeCardView: View {
    var body: some View {
        //TODO: SET UP view data based on coredata
        VStack(alignment: .center) {
            Text("90% Couple liked this challenge")
                .frame(maxWidth: .infinity)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(.primaryWhite.opacity(0.7))
                .padding(.vertical, 15)
                .background(Color.primaryWhite.opacity(0.3))
            Spacer()
            Text("Watch a horror film released before the year 2000 with your partner")
                .font(.system(size: 28))
                .fontWeight(.semibold)
                .lineSpacing(4)
                .foregroundColor(.primaryWhite)
                .padding(.horizontal, 20)
            Spacer()
            Text("PLAYDATE")
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(.primaryWhite)
                .opacity(0.5)
                .padding(.vertical, 10)
        }
        .frame(width: 342, height: 368)
        .background(Color.primaryPurple)
        .cornerRadius(16)
    }
}

struct ChallengeCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeCardView()
    }
}