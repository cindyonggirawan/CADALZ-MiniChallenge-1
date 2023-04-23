//
//  TabBarView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 21/04/23.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @State private var challengeImageName = "challenge-icon-selected"
    @State private var memoriesImageName = "memories-icon"
    @State private var profileImageName = "profile-icon"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            GenerateChallengeView()
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
            
            ProfileView()
                .tabItem {
                    Image(profileImageName)
                    Text("Profile")
                }
                .tag(2)
        }
        .accentColor(Color.primaryDarkBlue)
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

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
