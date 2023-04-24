//
//  GenerateChallengeView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct GenerateChallengeView: View {
    @StateObject var challengeViewModel = ChallengeViewModel()
    
    var body: some View {
        //TODO: BELUM RESPONSIVE
        ZStack {
            VStack {
                //Title
                VStack(alignment: .leading) {
                    //TODO: Nama user ambil dari coredata
                    HStack{
                        Text("Hi Alfine,")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.primaryDarkGray)
                            .padding(.bottom, -8)
                        Spacer()
                    }
                    
                    Text("What challenge do you want for your next date?")
                        .font(.custom("Poppins-Medium", size: 22))
                        .foregroundColor(.black)
                }
                .padding(.vertical, 25)
                .frame(maxWidth: 342)
                
                //Category Capsule
                HStack(spacing: 4) {
                    //TODO: Set Category Value
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Food")
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Entertainment")
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Travel")
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Wellbeing") // belum "Well-being"
                }
                .frame(maxWidth: 347)
                
                //Accept Button
                Button(action: {
                    //TODO: Accept Action
                    
                }, label: {
                    Text("Accept Challenge!")
                        .font(.custom("Poppins-Bold", size: 14))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
                .padding(.top, 436)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            
            //Challenge Card
            //TODO: Card ZStack View & Logic
            ZStack {
                ForEach(challengeViewModel.filteredChallenges) { challenge in
                    ChallengeCardView(challenge: challenge)
                }
                
                //                ForEach(challengeViewModel.filteredChallenges) { challenge in
                //                    ChallengeCardView(challenge: challenge)
                //                }
                
                //                ForEach(challengeViewModel.challenges.indices, id: \.self) { index in
                //                    if index < 1 {
                //                        sendIndexToChallengeCardView(challenge: challengeViewModel.challenges[index], cardOne: index, cardTwo: index + 1, cardThree: index + 2)
                //                         ChallengeCardView(challenge: challengeViewModel.challenges[index], index: index)
                //
                //                    }
                //                }
            }
            .padding(.top, 20)
        }
    }
    
//    func printChallengeCardView(challenge: Challenge, index: Int) -> some View {
//        print(challenge.id!)
//        return ChallengeCardView(challenge: challenge)
//    }
    
//    func sendIndexToChallengeCardView(challenge: Challenge, cardOne: Int, cardTwo: Int, cardThree: Int) -> some View {
//        print("mantap", index)
//        return ChallengeCardView(challenge: challenge, cardOne: cardOne, cardTwo: cardTwo, cardThree: cardThree)
//    }
    
}

struct GenerateChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateChallengeView()
    }
}
