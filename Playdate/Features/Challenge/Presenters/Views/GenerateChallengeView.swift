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
    //    @State var displayedChallenges = [0, 1, 2]
    //    @State var lastDisplayIndex = 2
    
            @State var displayedChallenges = [0, 1, 2, 3, 4]
            @State var lastDisplayIndex = 4

//            @State var displayedChallenges = [4, 5, 6, 7, 8]
//            @State var lastDisplayIndex = 8
    
    
    @State var decr: Int = -1
    @State var shiftIdx: Int = 0
    
    init(){
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
            Rectangle()
                .fill(.black)
                .frame(width: UIScreen.main.bounds.width, height: 1)
                .zIndex(999)
            Rectangle()
                .fill(.black)
                .frame(width: 1, height: UIScreen.main.bounds.height)
                .zIndex(999)
            
            
            
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

                    ForEach(self.displayedChallenges.reversed(), id: \.self) { i in // 4 3 2 1 0
                        CardView(challenge: self.challengeViewModel.filteredChallenges[i], currentIndex: $lastDisplayIndex, shiftIndex: lastDisplayIndex - i)
                    }
                    
                    
                    
//                    ForEach(self.displayedChallenges, id: \.self) { i in // 4 3 2 1 0
                    
//                        CardView(challenge: self.challengeViewModel.filteredChallenges[lastDisplayIndex], currentIndex: $lastDisplayIndex, shiftIndex: lastDisplayIndex)
//                        CardView(challenge: self.challengeViewModel.filteredChallenges[lastDisplayIndex - 1], currentIndex: $lastDisplayIndex, shiftIndex: lastDisplayIndex - 1)
//                        CardView(challenge: self.challengeViewModel.filteredChallenges[lastDisplayIndex - 2], currentIndex: $lastDisplayIndex, shiftIndex: lastDisplayIndex - 2)
//                        CardView(challenge: self.challengeViewModel.filteredChallenges[lastDisplayIndex - 3], currentIndex: $lastDisplayIndex, shiftIndex: lastDisplayIndex - 3)
//                        CardView(challenge: self.challengeViewModel.filteredChallenges[ lastDisplayIndex - 4], currentIndex: $lastDisplayIndex, shiftIndex: lastDisplayIndex - 4)
                        
//                    }
                    
//                    if displayedIdx == 3 {
//                        Group {
//                            Text("3").zIndex(999)
//                            CardView(challenge: self.challengeViewModel.filteredChallenges[self.displayedChallenges[displayedIdx]], currentIndex: $lastDisplayIndex, shiftIndex: displayedIdx)
//                            CardView(challenge: self.challengeViewModel.filteredChallenges[self.displayedChallenges[displayedIdx - 1]], currentIndex: $lastDisplayIndex, shiftIndex: displayedIdx - 1)
//                            CardView(challenge: self.challengeViewModel.filteredChallenges[self.displayedChallenges[displayedIdx - 2]], currentIndex: $lastDisplayIndex, shiftIndex: displayedIdx - 2)
//                            CardView(challenge: self.challengeViewModel.filteredChallenges[self.displayedChallenges[displayedIdx - 3]], currentIndex: $lastDisplayIndex, shiftIndex: displayedIdx - 3)
//                        }
//                    } else if displayedIdx == 4 {
//                        Group {
//                            Text("4").zIndex(999)
//                            CardView(challenge: self.challengeViewModel.filteredChallenges[self.displayedChallenges[displayedIdx]], currentIndex: $lastDisplayIndex, shiftIndex: displayedIdx)
//                            CardView(challenge: self.challengeViewModel.filteredChallenges[self.displayedChallenges[displayedIdx - 1]], currentIndex: $lastDisplayIndex, shiftIndex: displayedIdx - 1)
//                            CardView(challenge: self.challengeViewModel.filteredChallenges[self.displayedChallenges[displayedIdx - 2]], currentIndex: $lastDisplayIndex, shiftIndex: displayedIdx - 2)
//                            CardView(challenge: self.challengeViewModel.filteredChallenges[self.displayedChallenges[displayedIdx - 3]], currentIndex: $lastDisplayIndex, shiftIndex: displayedIdx - 3)
//                            CardView(challenge: self.challengeViewModel.filteredChallenges[self.displayedChallenges[displayedIdx - 4]], currentIndex: $lastDisplayIndex, shiftIndex: displayedIdx - 4)
//                        }
//                    }
                }
                .onChange(of: lastDisplayIndex) { newValue in
                    addNewDisplay()
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
                .zIndex(-99)
                .padding(.horizontal, 24)
                .padding(.top, 100)
                
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
        if displayedChallenges.count > 5 {
//            return withAnimation(.easeInOut(duration: 1)) {
            return withAnimation(.easeOut(duration: 8)) {
                displayedChallenges.removeFirst()
                print("displayed challenge: \(displayedChallenges)")
            }
        }
    }
    
    func getCards() -> AnyView {
        let content = ForEach(self.displayedChallenges.reversed(), id: \.self) { i in
//            CardView(challenge: self.challengeViewModel.filteredChallenges[i], currentIndex: $lastDisplayIndex)
            Text("")
        }
        return AnyView(content)
    }
}

struct GenerateChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateChallengeView()
    }
}
