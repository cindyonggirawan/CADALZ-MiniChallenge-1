//
//  OnboardingView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 21/04/23.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject var challengeViewModel = ChallengeViewModel()
    
    @StateObject var memoryViewModel = MemoryViewModel()
    @StateObject var userViewModel = UserViewModel()

    @State private var show = false
    
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    OnboardingPageView(imageName: "onboarding1", title: "1 Capture fun memories with your partner", subtitle: "1 Take a photo every challenge and save it in memory lane.")
                    OnboardingPageView(imageName: "onboarding2", title: "2 Capture fun memories with your partner", subtitle: "2 Take a photo every challenge and save it in memory lane.")
                    OnboardingPageView(imageName: "onboarding3", title: "3 Capture fun memories with your partner", subtitle: "3 Take a photo every challenge and save it in memory lane.")
                }
                .tabViewStyle(PageTabViewStyle())
                .onAppear {
                    setupAppearance()
                }
                
                Button(action: {
                    show = true
                    // Connect to backend
//                    challengeViewModel.clearChallenges()
                    dataManager.syncWithFirebase()
                }, label: {
                    Text("Next")
                        .font(.custom("Poppins-Bold", size: 14))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
            }
            .padding(24)
            .background(.white)
            .fullScreenCover(isPresented: $show) {
                RegistrationView()
            }
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(maxWidth: .infinity)
                .scaledToFit()
                .background(Color.primaryLightGray)
                .padding(.bottom, 32)
            
            Text(title)
                .font(.custom("Poppins-SemiBold", size: 24))
                .foregroundColor(.primaryDarkBlue)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            Text(subtitle)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color.primaryDarkGray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 70)
        }
    }
}

//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}
