//
//  GenerateChallengeView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct GenerateChallengeView: View {
    @StateObject var challengeViewModel = ChallengeViewModel()
//    var challenges: [Challenge] = []
    @State var displayedChallenges = [0, 1, 2]
    
    @State var lastDisplayIndex = 2
    
    init(){
        //TEMP LOGIC
//        for i in 0...6 {
//            displayedChallenges.append(challengeViewModel.challenges[i])
//        }
        //TODO: Batesin challenges yang diambil
//        generateDisplayChallenge()
//        addDisplayChallenge(currentIndex: totalNumberOfChallengeloaded)
        print("total challenge: \(challengeViewModel.challenges.count)")
    }
    
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
                
                //Challenge Card
                //TODO: Card ZStack View & Logic
                ZStack() {
                    ForEach(displayedChallenges.reversed(), id: \.self){ i in
                        ChallengeCardView(challenge: challengeViewModel.challenges[i], currentIndex: $lastDisplayIndex)
                    }
                    .onChange(of: lastDisplayIndex) { newValue in
                        addNewDisplay()
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
                .padding(.vertical, 20)
                
                //Accept Button
                Button(action: {
                    //TODO: Accept Action
                    
                }, label: {
                    Text("Accept Challenge!")
                        .font(.custom("Poppins-Bold", size: 16))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
                .padding(.horizontal, 24)
                
                //Atur kembali ya paddingnya, karena ini sengaja diubah buat ga tentuin maxwidthnya, supaya bisa responsif
                //Sejauh ini yang gue pake itu kiri kanan atas bawah 24, tapi di taruh di container paling luar, dalam struktur file ini itu ZStack
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            

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

    func addNewDisplay(){
        let a = lastDisplayIndex
        let b = challengeViewModel.challenges.count
        displayedChallenges.append(a % b)
        if displayedChallenges.count > 5 {
            displayedChallenges.removeFirst()
        }
        print("displayed challenge: \(displayedChallenges)")
    }
}

struct GenerateChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateChallengeView()
    }
}
