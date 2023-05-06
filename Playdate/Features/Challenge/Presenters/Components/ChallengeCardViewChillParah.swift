//
//  ChallengeCardViewChillParah.swift
//  Playdate
//
//  Created by Daniel Bernard Sahala Simamora on 06/05/23.
//

import SwiftUI

struct ChallengeCardViewChillParah: View {
    let challenge: Challenge
    @ObservedObject var vm: ChallengeViewModel
    var shiftIndex: Int
    
    var statusStr: String {
        return generateStatus(
            id: challenge.id!,
            like: challenge.like,
            user: challenge.numberOfUser
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Text(statusStr)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.primaryWhite.opacity(0.7))
                Spacer()
            }
            .padding(.vertical, 15)
            .background(Color.primaryWhite.opacity(0.3))
            Spacer()
            if let name = challenge.name {
                Text(name)
                    .font(.custom("Poppins-SemiBold", size: 28))
                    .foregroundColor(.primaryWhite)
                    .padding(.horizontal, 20)
            }
            Spacer()
            
            HStack{
                Spacer()
                Text("PLAYDATE")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.primaryWhite)
                    .opacity(0.5)
                    .padding(.vertical, 10)
                Spacer()
            }
        }
        .frame(width: 342, height: 368)
        .background(
            Image(vm.getDoodle(category: challenge.category!))
//            Image("doodle-food") // biar ga ada warning image not found. terminal nya rame bgt
                .resizable()
                .scaledToFill()
//                .frame(width: 500, height: 500)
                .opacity(0.12)
                .background(checkChallengeCategoryColor(challengeCategory: challenge.category!))
                .frame(width: 600, height: 600)
        )
        .clipped()
        .contentShape(Rectangle())
        .cornerRadius(16)
        .scaleEffect(1)
        .zIndex(2)
    }
    
    func checkChallengeCategoryColor(challengeCategory: String) -> Color {
        if challengeCategory.lowercased() == "travel" {
            return Color.primaryOrange
        } else if challengeCategory.lowercased() == "entertainment" {
            return Color.primaryPurple
        } else if challengeCategory.lowercased() == "food" {
            return Color.primaryRed
        } else if (challengeCategory.lowercased() == "well-being") {
            return Color.primaryGreen
        } else {
            return Color.gray
        }
    }
    
    func generateStatus(id: String, like: Int64, user: Int64) -> String {
        /* Function to generate tab bar string of message of every card
         if the numberOfUser are lower than userMinimum, output string of text without calculation
         */
        let userMinimum = 3
        var statusStr = ""
        
        if (user < userMinimum){
            statusStr = "Be the first to play this challenge"
        } else {
            let percentage = Float(like)/Float(user)*100
            statusStr = "\(String(format: "%.0f", percentage))% Couple liked this challenge"
        }
        
        // debugging line
//        print("id: \(id) | like: \(like) | user: \(user) | percentage: \(String(format: "%.0f", percentage))")
        return statusStr
    }
}
