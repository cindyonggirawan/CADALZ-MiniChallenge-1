//
//  SplashView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 21/04/23.
//

import SwiftUI

struct SplashView: View {
    @State private var scale: CGFloat = 1.0
    @State private var isActive = false
    @StateObject var memoryViewModel = MemoryViewModel()
    
    var body: some View {
        ZStack {
            if self.isActive {
                if memoryViewModel.memories.count == 0 {
                    OnboardingView()
                }else{
                    if memoryViewModel.memories[memoryViewModel.memories.count-1].status == "ongoing"{
                        OngoingChallengeView()
                    }
                }
            } else {
                Color.primaryPurple
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 1.0))
                    .onAppear {
                        scale = 1.2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation {
                                scale = 0.8
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                scale = 1.5
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                scale = 1.0
                            }
                        }
                    }
            }
        }
        .background(Color.primaryPurple)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.isActive = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
