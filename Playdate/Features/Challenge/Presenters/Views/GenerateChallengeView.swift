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
    @StateObject var memoryViewModel = MemoryViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    @State var currentChallenges: Challenge = Challenge()

    @State var showOngoingPage = false
    
    @State private var selectedTab = 0
    @State private var challengeImageName = "challenge-icon-selected"
    @State private var memoriesImageName = "memories-icon"
    @State private var profileImageName = "profile-icon"
    
    var body: some View {
        //TODO: BELUM RESPONSIVE
        ZStack {
            VStack {
                //Title
                VStack(alignment: .leading) {
                    //TODO: Nama user ambil dari coredata
                    HStack{
                        Text("Hi \(userViewModel.user[userViewModel.user.count-1].name!),")
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
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Food", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Entertainment", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Travel", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Well-being", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                }
                .frame(maxWidth: 347)
                
                //Challenge Card
                //TODO: Card ZStack View & Logic
                ZStack() {
                    ForEach(self.challengeViewModel.displayedChallenges.reversed(), id: \.self) { i in // i: 4 3 2 1 0
                        ChallengeCardView(challenge: self.challengeViewModel.filteredChallenges[i], vm: self.challengeViewModel, shiftIndex: challengeViewModel.lastDisplayIndex - i)
                            .onAppear {
                                currentChallenges = challengeViewModel.filteredChallenges[challengeViewModel.displayedChallenges[0]]
                            }
                    }
                }
                .padding(.vertical, 10)
                
                //Accept Button
                Button(action: {
                    //TODO: Accept Action
                    memoryViewModel.addMemory(challenge: currentChallenges)
                    showOngoingPage = true
                }, label: {
                    Text("Accept Challenge!")
                        .font(.custom("Poppins-Bold", size: 14))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
                .zIndex(-1)
                .padding(.horizontal, 24)
                .padding(.top, 50)
                
                //Atur kembali ya paddingnya, karena ini sengaja diubah buat ga tentuin maxwidthnya, supaya bisa responsif
                //Sejauh ini yang gue pake itu kiri kanan atas bawah 24, tapi di taruh di container paling luar, dalam struktur file ini itu ZStack
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            

        }
        .fullScreenCover(isPresented: $showOngoingPage) {
            TabView(selection: $selectedTab) {
                OngoingChallengeView()
                    .tabItem {
                        Image(challengeImageName)
                        Text("Challenge")
                    }
                    .tag(0)
               
               
                Text("Memories Tab")
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

struct GenerateChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateChallengeView()
    }
}
