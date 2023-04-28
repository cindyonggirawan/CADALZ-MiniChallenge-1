//
//  ChallengeCardView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

//struct ChallengeCardView: View {
//    var challenge: Challenge
//    @Binding var currentIndex: Int
////    @State var cardOne: Int
////    @State var cardTwo: Int
////    @State var cardThree: Int
//
//    @State var offSet: CGSize = CGSize(width: 0, height: 0) // .zero
//
//    var body: some View {
//        //TODO: SET UP view data based on coredata
//
//        if let _ = challenge.category {
//            CardView(challenge: challenge, offSet: offSet, currentIndex: $currentIndex)
//        }
//
//    }
//}

struct CardView: View {
    let challenge: Challenge
    @Binding var currentIndex: Int
    var shiftIndex: Int
    
    @StateObject var vm = ChallengeViewModel()
    @State var offSet: CGSize = .zero
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Text("90% Couple liked this challenge")
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
//                Text("PLAYDATE")
                Text(challenge.category ?? "NO CATEGORY")
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
        
        .gesture(
            DragGesture()
                .onChanged({ value in
                    self.offSet = value.translation
                    
                })
                .onEnded({ value in
                    
                    //TODO: INI BENER GA ?
                    //Add new cardview in the back
                    
                    if self.xOffsetPortion() >= 0.2 || self.yOffsetPortion() >= 0.2 {
                        withAnimation(.easeOut(duration: 8)) {
                            let newWidth: Double = self.offSet.width + 10*value.translation.width
                            let newHeight: Double = self.offSet.height + 10*value.translation.height
                            
                            self.offSet = CGSize(width: newWidth, height: newHeight)
                        }
                        withAnimation(.easeIn(duration: 0.25)) {
                            addDisplayChallenge()
                        }
                    } else {
                        withAnimation(.easeIn(duration: 0.2)) {
                            self.offSet = .zero
                        }
                    }
                })
        )
        .zIndex(1)
    }
    
    func getRandomRotation(index: Int) -> Double {
        if index < 4 {
            return Double.random(in: -3...3)
        } else {
            return 0.0
        }
    }
    
    func getOffSet(index: Int) -> CGSize {
        let index = index % self.vm.filteredChallenges.count
        
        if (index == 4 || index == 3) {
            print(">>", index)
            return CGSize(
                width: self.offSet.width + 0,
                height: self.offSet.height - (Double(index - 4) * 40.0))
        } else {
            print("^^", index)
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
            return Color.primaryPurple
        } else if challengeCategory.lowercased() == "entertainment" {
            return Color.primaryGreen
        } else if challengeCategory.lowercased() == "sport" {
            return Color.primaryRed
        } else if (challengeCategory.lowercased() == "wellbeing" || challengeCategory.lowercased() == "well-being") { // di core data belum "well-being" !
            return Color.primaryOrange
        } else {
            return Color.pink
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
    
    func addDisplayChallenge(){
        currentIndex += 1
//        print(currentIndex)
    }
    
    
    
}

//
//struct ChallengeCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeCardView()
//    }
//}
