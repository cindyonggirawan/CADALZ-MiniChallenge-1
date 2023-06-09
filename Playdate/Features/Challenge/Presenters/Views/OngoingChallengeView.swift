//
//  OngoingChallengeView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct OngoingChallengeView: View {
    @StateObject var memoryViewModel = MemoryViewModel()
    @StateObject var challengeViewModel = ChallengeViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    @State var showSheet = false
    @State var isGiveUp = false
    
    @State private var selectedTab = 0
    @State private var challengeImageName = "challenge-icon-selected"
    @State private var memoriesImageName = "memories-icon"
    @State private var profileImageName = "profile-icon"
    
    var body: some View {
        
        let currentMemory = memoryViewModel.memories[memoryViewModel.memories.count-1]
        
        VStack{
            VStack {
                VStack(alignment: .leading) {
                    HStack{
                        Text("Hi \(userViewModel.user[userViewModel.user.count-1].name!),")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.primaryWhite.opacity(0.7))
                            .padding(.bottom, -8)
                        Spacer()
                    }
                    
                    Text("Let’s do the challenge!")
                        .font(.custom("Poppins-Medium", size: 22))
                        .foregroundColor(.primaryWhite)
                }
                .frame(maxWidth: 342)
                
                Spacer()
                
                //Challenge text
                HStack {
                    // Ini penyebab error karena masih nil
                    if let challenge = currentMemory.challenge {
                        Text(challenge.name!)
                            .font(.custom("Poppins-SemiBold", size: 28))
                            .lineSpacing(4)
                            .foregroundColor(.primaryWhite)
                    } else {
                        Text("NO ONGOING CHALLENGE") // -daniel
                            .font(.custom("Poppins-SemiBold", size: 28))
                            .lineSpacing(4)
                            .foregroundColor(.primaryWhite)
                    }
                    Spacer()
                }
                .padding(.bottom, 30)
                .frame(maxWidth: 342)
                
                Spacer()
                
                //Countdown
                VStack(spacing: 8) {
                    if let date = currentMemory.date {
                        if date >= Date() {
                            TimerView(setDate: currentMemory.date!)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(.primaryWhite)
                        }
                    } else {
                        Text("00:00:00")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundColor(.primaryWhite)
                    }
                    Text("Time left to do the challenge")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(.primaryWhite.opacity(0.5))
                }
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(Color.primaryWhite.opacity(0.2))
                .cornerRadius(8)
                .padding(.vertical, 10)
                
            }
            .padding(.vertical, 25)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.6)
            .background(Image(challengeViewModel.getDoodle(category: (currentMemory.challenge?.category!) ?? "food"))
                    .resizable()
                    .scaledToFill()
                    .opacity(0.12)
                    .background(memoryViewModel.checkChallengeCategoryColor(challengeCategory: (currentMemory.challenge?.category!) ?? "food"))
                    .frame(width: 600, height: UIScreen.main.bounds.height * 0.6)
                    .edgesIgnoringSafeArea(.top)
            )
//            .background(.blue)
            
            VStack {
                Button(action: {
                    showSheet = true
                }, label: {
                    Text("Finish Challenge")
                        .font(.custom("Poppins-Bold", size: 14))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
                .padding(.top, 10)
                .padding(.horizontal, 24)
                .fullScreenCover(isPresented: $showSheet) {
                    ChallengeViewPage1()
                }
                
                Button(action: {
                    memoryViewModel.removeMemory()
                    isGiveUp = true
                }, label: {
                    Text("Give Up")
                        .font(.custom("Poppins-SemiBold", size: 14))
                        .foregroundColor(.primaryDarkBlue)
                })
                .buttonStyle(FixedSizeNoFillRoundedButtonStyle())
                .padding(.top, 5)
                .padding(.horizontal, 24)
            }
            Spacer()
            
        }
        .fullScreenCover(isPresented: $isGiveUp, content: {
            TabView(selection: $selectedTab) {
                GenerateChallengeView()
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
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct OngoingChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        OngoingChallengeView()
    }
}
