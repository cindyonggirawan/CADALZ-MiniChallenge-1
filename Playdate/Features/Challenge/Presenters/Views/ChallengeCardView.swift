//
//  ChallengeCardView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct ChallengeCardView: View {
    let challenge: Challenge
    @ObservedObject var vm: ChallengeViewModel
    var shiftIndex: Int
    @State var x: Bool = false
    
    @State var offSet: CGSize = .zero
    
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
//                Text("90% Couple liked this challenge")
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
            Text(challenge.name!)
                .font(.custom("Poppins-SemiBold", size: 28))
                .foregroundColor(.primaryWhite)
                .padding(.horizontal, 20)
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
        .background(checkChallengeCategoryColor(challengeCategory: challenge.category!))
        .cornerRadius(16)
        
        .rotationEffect(Angle(degrees: 4.5 * getCardRotation()))
        .offset(self.getOffSet(index: shiftIndex))
        .scaleEffect(getScaleEffect(index: shiftIndex))
        .gesture( shiftIndex % self.vm.filteredChallenges.count == 4 ?
            DragGesture()
                .onChanged({ value in
                    self.offSet = value.translation
                    self.x = false
                })
                .onEnded({ value in
                    if self.xOffsetPortion() >= 0.2 || self.yOffsetPortion() >= 0.2 {
                        
                        withAnimation(.easeOut(duration: 7)) {
                            let newWidth: Double = self.offSet.width + 60*value.translation.width
                            let newHeight: Double = self.offSet.height + 60*value.translation.height

                            self.offSet = CGSize(width: newWidth, height: newHeight)
                        }
                        self.x = true
                        
                    } else {
                        withAnimation(.easeIn(duration: 0.2)) {
                            self.offSet = .zero
                        }
                    }
                })
                .onEnded({ _ in
                    if x {
                        withAnimation(.easeIn(duration: 0.2).delay(0.1)) {
                            self.addDisplayChallenge()
                        }
                    }
                })
                  : nil
        )
        .zIndex(2)
    }
    
    func getOffSet(index: Int) -> CGSize {
        let index = index % self.vm.filteredChallenges.count
        if (index == 4 || index == 3) {
            return CGSize(
                width: self.offSet.width + 0,
                height: self.offSet.height - (Double(index - 4) * 40.0))
        } else {
            return CGSize(
                width: self.offSet.width + 0,
                height: self.offSet.height + 2 * 40.0)
        }
    }
    
    func getScaleEffect(index: Int) -> Double {
        let index = index % self.vm.filteredChallenges.count

        if index == 4 {
            return 1.0
        } else if index == 3 {
            return 0.9
        } else {
            return 0.8
        }
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
    
    func getCardRotation() -> Double {
        let maxScreen = UIScreen.main.bounds.width / 2
        let angle = 10 * (self.offSet.width / maxScreen)
        return angle
    }
    
    func xOffsetPortion() -> Double {
        let screenWidth = UIScreen.main.bounds.width / 2
        return abs(self.offSet.width) / screenWidth
    }
    
    func yOffsetPortion() -> Double {
        let screenHeight = UIScreen.main.bounds.height / 2
        return abs(self.offSet.height) / screenHeight
    }
    
    func addDisplayChallenge() {
        self.vm.lastDisplayIndex += 1
        
        let a = self.vm.lastDisplayIndex
        let b = vm.filteredChallenges.count
        
        self.vm.displayedChallenges.append(a % b)
        
        if self.vm.displayedChallenges.count > 5 {
                self.vm.displayedChallenges.removeFirst()
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
            var percentage = Float(like)/Float(user)*100
            statusStr = "\(String(format: "%.0f", percentage))% Couple liked this challenge"
        }
        
        // debugging line
//        print("id: \(id) | like: \(like) | user: \(user) | percentage: \(String(format: "%.0f", percentage))")
        return statusStr
    }
    
}
