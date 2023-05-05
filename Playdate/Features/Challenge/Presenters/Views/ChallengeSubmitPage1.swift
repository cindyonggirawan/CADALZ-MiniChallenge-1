//
//  ChallengeViewPage1.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 03/05/23.
//

import SwiftUI

struct ChallengeViewPage1: View {
    // Navigation
    @State var navChallengeModal = 1 // ohhh 1: like challenge?, 2: upload photo
    @State var isLikeChallenge = true
    
    // Challenge Card View
    @StateObject var challengeViewModel = ChallengeViewModel()
    @StateObject var memoryViewModel = MemoryViewModel()
    
    // ANIMASI KARTU YU GI OH
    @State var challengeCardDegree = 0.0
    @State var uploadPhotoDegree = -90.0
    @State var isFlipped = false
    let durationAndDelay : CGFloat = 0.35

    @State var show = false
    @State private var selectedTab = 0
    @State private var challengeImageName = "challenge-icon-selected"
    @State private var memoriesImageName = "memories-icon"
    @State private var profileImageName = "profile-icon"
    
    var body: some View {
        
        let currentMemories = memoryViewModel.memories[memoryViewModel.memories.count-1]
        
        NavigationView {
            ZStack{
                // challenge card
                ZStack {
                    VStack(alignment: .leading) {
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
                        Image(challengeViewModel.getDoodle(category: currentMemories.challenge!.category!))
//                        Image("doodle-food") // biar ga ada warning image not found. terminal nya rame bgt
                            .resizable()
                            .scaledToFill()
            //                .frame(width: 500, height: 500)
                            .opacity(0.12)
                            .background(checkChallengeCategoryColor(challengeCategory: currentMemories.challenge!.category!))
                            .frame(width: 600, height: 600)
                    )
                    .clipped()
                    .contentShape(Rectangle())
                    .cornerRadius(16)
                    .rotation3DEffect(Angle(degrees: uploadPhotoDegree), axis: (x: 0, y: 1, z: 0), perspective: 0.55)
                    
                    ChallengeCardView(challenge: currentMemories.challenge!, vm: challengeViewModel, shiftIndex: 4)
                        .rotation3DEffect(Angle(degrees: challengeCardDegree), axis: (x: 0, y: 1, z: 0), perspective: 0.55)
                }
                .padding(.top, 100)
                .padding(.bottom, 400)
                
                // for page navigation
                if (navChallengeModal == 1){
                    VStack {
                        // Page 1
                        Text("Do you like the challenge?")
                            .font(.custom("Poppins-semibold", size: 20))
                            .foregroundColor(.black)

                            .padding(.top, 230)
                        
                        // button
                        HStack {
                            ZStack {
                                Button(action: {
                                    self.flipCard()
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
                                    self.flipCard()
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
                            }
                        }
                        .padding(.top, 24)
                    }
                    .padding(.top,100)
                } else {
                    // Page 2
                    VStack{
                        ChallengeSumbitPage2(isLikeChallenge: $isLikeChallenge)

                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if ( navChallengeModal == 1 ){
                        Button("Prev") {
//                              // Navigate to Ongoing challenge
//                            OngoingChallengeView()
                            show = true
                        }
                    } else {
                        Button("Prev") {
                            navChallengeModal = 1
                            self.flipCard()
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $show) {
                TabView(selection: $selectedTab) {
                    OngoingChallengeView()
                        .tabItem {
                            Image(challengeImageName)
                            Text("Challenge")
                        }
                        .tag(0)
                   
                   
    //                Text("Memories Tab")
                    MemoryLaneView()
                        .tabItem {
                            Image(memoriesImageName)
                            Text("Memories")
                        }
                        .tag(1)
                    
                    NewProfileView()
                        .tabItem {
                            Image(profileImageName)
                            Text("Profile")
                        }
                        .tag(2)
                }
                .accentColor(Color.primaryDarkBlue)
                .onAppear() {
                    UITabBar.appearance().backgroundColor = .white
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .tabViewStyle(DefaultTabViewStyle())
                .transition(.slide)
                .onChange(of: selectedTab) { value in
                    switch value {
                    case 0:
                        challengeImageName = "challenge-icon-selected"
                        memoriesImageName = "memories-icon"
                        profileImageName = "profile-icon"
                    case 1:
                        memoriesImageName = "memories-icon-selected"
                        challengeImageName = "challenge-icon"
                        profileImageName = "profile-icon"
                    case 2:
                        profileImageName = "profile-icon-selected"
                        challengeImageName = "challenge-icon"
                        memoriesImageName = "memories-icon"
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                challengeCardDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                uploadPhotoDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                uploadPhotoDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                challengeCardDegree = 0
            }
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
    
}

//struct ChallengeViewPage1_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeViewPage1()
//    }
//}
