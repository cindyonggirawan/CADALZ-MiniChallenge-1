//
//  ChallengeViewPage1.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 03/05/23.
//

import SwiftUI

struct ChallengeViewPage1: View {
    // Navigation
    @State var navChallengeModal = 1
    @State var isLikeChallenge = true
    // Challenge Card View
    @StateObject var challengeViewModel = ChallengeViewModel()
    @StateObject var memoryViewModel = MemoryViewModel()

    
    var body: some View {
        
        let currentMemories = memoryViewModel.memories[memoryViewModel.memories.count-1]
        
        NavigationView {
            VStack {
                if (navChallengeModal == 1){
                    // Diganti jadi Statis
                    ChallengeCardView(challenge: currentMemories.challenge!, vm: challengeViewModel, shiftIndex: 4)
                        .padding(.top, 180)
                    
                    Text("Do you like the challenge?")
                        .font(.custom("Poppins-semibold", size: 20))
                        .foregroundColor(.black)

                        .padding(.top, 50)

                    
                    HStack {
                        ZStack {
                            Button(action: {
                                navChallengeModal = 2
                                isLikeChallenge = false
                                print("Button pressed \(isLikeChallenge)")
                            }) {
                                // Add LIKE Illustration here
                                Text("No")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                            }
                            .frame(width: 167, height: 53)
                            .foregroundColor(Color.primaryDarkBlue)
                            .background(Color.primaryWhite)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.primaryDarkBlue, lineWidth: 1)
                            )
                        }
                        ZStack {
                            Button(action: {
                                navChallengeModal = 2
                                isLikeChallenge = true
                                print("Button pressed \(isLikeChallenge)")
                            }) {
                                // Add LIKE Illustration here
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: 167, height: 53)
                                        .foregroundColor(Color.primaryDarkBlue)
                                    Text("Yes")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .foregroundColor(Color.white)
                                }
                            }
                            .frame(width: 167, height: 53)
//                            Text("Yes")
//                                .font(.custom("Poppins-SemiBold", size: 14))
//                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.bottom, 279)
                } else {
                    // to page 2
//                    ChallengeSubmitModal(isLikeChallenge: $isLikeChallenge)
                    ChallengeSumbitPage2(isLikeChallenge: $isLikeChallenge)
                }
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if ( navChallengeModal == 1 ){
                            Button("Cancel") {
//                              // Navigate to Ongoing challenge
                                
                            }
                        } else {
                            Button("Prev") {
                                navChallengeModal = 1
                            }
                        }
                    }
                }
        }
    }
}

//struct ChallengeViewPage1_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeViewPage1()
//    }
//}
