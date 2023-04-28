//
//  GenerateChallengeView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct GenerateChallengeView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @StateObject var challengeViewModel = ChallengeViewModel()
//    var challenges: [Challenge] = []
    
    @State var displayedChallenges = [0, 1, 2, 3, 4]
    @State var lastDisplayIndex = 4
    
    init() {
        //TEMP LOGIC
//        for i in 0...6 {
//            displayedChallenges.append(challengeViewModel.challenges[i])
//        }
        //TODO: Batesin challenges yang diambil
//        generateDisplayChallenge()
//        addDisplayChallenge(currentIndex: totalNumberOfChallengeloaded)
//        print("total challenge: \(challengeViewModel.challenges.count)")
//        syncWithFirebase()
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
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Well-being")
                }
                .frame(maxWidth: 347)
                
                //Challenge Card
                //TODO: Card ZStack View & Logic
                ZStack() {

                    ForEach(self.displayedChallenges.reversed(), id: \.self) { i in
                        ChallengeCardView(challenge: self.challengeViewModel.filteredChallenges[i], currentIndex: $lastDisplayIndex, shiftIndex: lastDisplayIndex - i)
//                            .onAppear {
//                                print("i:", i)
//                                print("(filtered) count:", self.challengeViewModel.filteredChallenges.count)
//                                print("(displayed) count:", self.displayedChallenges.count)
//                                print("shiftIndex:", lastDisplayIndex - i)
//                                print("================")
//                            }
                    }
                }
                .onChange(of: lastDisplayIndex) { newValue in
                    addNewDisplay()
//                    if (self.challengeViewModel.filteredChallenges.count - self.displayedChallenges.max()! == 1) {
//                        self.challengeViewModel.filteredChallenges = self.challengeViewModel.challenges.shuffled()
//                    }
                }
                .padding(.vertical, 10)
                
                //Accept Button
                Button(action: {
                    //TODO: Accept Action
                    
                }, label: {
                    Text("Accept Challenge!")
                        .font(.custom("Poppins-Bold", size: 16))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
                .zIndex(-99)
                .padding(.horizontal, 24)
                .padding(.top, 50)
                
                //Atur kembali ya paddingnya, karena ini sengaja diubah buat ga tentuin maxwidthnya, supaya bisa responsif
                //Sejauh ini yang gue pake itu kiri kanan atas bawah 24, tapi di taruh di container paling luar, dalam struktur file ini itu ZStack
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            

        }
    }

    func addNewDisplay(){
        let a = lastDisplayIndex
        let b = challengeViewModel.challenges.count
        displayedChallenges.append(a % b)
        if displayedChallenges.count > 6 {
//            return withAnimation(.easeOut(duration: 8)) {
            return withAnimation(.easeOut(duration: 0)) {
                displayedChallenges.removeFirst()
//                print("displayed challenge: \(displayedChallenges)")
            }
        }
    }
}

struct GenerateChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateChallengeView()
    }
}
