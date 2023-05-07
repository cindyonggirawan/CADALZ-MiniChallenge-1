//
//  SplashView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 21/04/23.
//

import SwiftUI

struct SplashView: View {
    @State private var scale: CGFloat = 0.5
    @State private var isActive = false
    
//    @EnvironmentObject var memoryViewModel: MemoryViewModel
    @StateObject var memoryViewModel = MemoryViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        ZStack {
            if self.isActive {
                if memoryViewModel.memories.count == 0 {
                    if userViewModel.user.count == 0 {
                        OnboardingView()
                    } else {
                        TabBarView()
                    }
                } else {
                    TabBarView()
//                    if memoryViewModel.memories[memoryViewModel.memories.count-1].status == "ongoing"{
//                        TabBarView()
//                    } else {
//                        TabBarView()
//                    }
                }
            } else {
                Color.primaryPurple
                
                Image("doodle-splashscreen")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.3)
                    .opacity(0.12)
                
                Image("logo")
                    .resizable()
                    .offset(x: -15)
                    .scaledToFit()
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 1.0))
                    .onAppear {
                        scale = 0.7
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation {
                                scale = 0.3
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                scale = 1.0
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                scale = 0.5
                            }
                        }
                    }
            }
        }
        .background(Color.primaryPurple)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.isActive = true
            }
        }
//        .statusBarHidden()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
