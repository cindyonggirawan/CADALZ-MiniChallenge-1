//
//  TabBarView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 21/04/23.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var memoryViewModel: MemoryViewModel
    
    @State private var selectedTab = 0
    @State private var challengeImageName = "challenge-icon-selected"
    @State private var memoriesImageName = "memories-icon"
    @State private var profileImageName = "profile-icon"
    
    @StateObject var userViewModel = UserViewModel()
    
    @State var showingMemoryDeleteButton: Bool = false
    @State var x: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
//            MemoryLaneView()
//                .tabItem {
//                    Label((x == 0 ? "Select Photo" : String(x) + (x > 1 ? " Photos " : " Photo ") + "Selected"), image: "trash-icon") // mohon maaf nested ternary :V
//                }
//                .tag(0)
            
            if memoryViewModel.memories.count == 0 {
                if userViewModel.user.count != 0 {
                    GenerateChallengeView()
                        .tabItem {
                            Image(challengeImageName)
                            Text("Challenge")
                        }
                        .tag(0)
                }
            } else {
                if memoryViewModel.memories[memoryViewModel.memories.count-1].status == "ongoing" {
                    OngoingChallengeView()
                        .tabItem {
                            Image(challengeImageName)
                            Text("Challenge")
                        }
                        .tag(0)
                } else if userViewModel.user.count != 0 {
                    GenerateChallengeView()
                        .tabItem {
                            Image(challengeImageName)
                            Text("Challenge")
                        }
                        .tag(0)
                }
            }

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
                challengeImageName = "challenge-icon"
                memoriesImageName = "memories-icon-selected"
                profileImageName = "profile-icon"
            case 2:
                challengeImageName = "challenge-icon"
                memoriesImageName = "memories-icon"
                profileImageName = "profile-icon-selected"
            default:
                break
            }
        }
        
    }
}

//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
//}
