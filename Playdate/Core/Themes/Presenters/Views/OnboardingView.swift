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
    @State private var currentPageIndex = 0
    
    var body: some View {
//        NavigationView {
            VStack {
                ZStack(alignment: .topTrailing) {
                    TabView(selection: $currentPageIndex) {
                        OnboardingPageView(imageName: "onboarding1", title: "Dating is now more exciting with Playdate", subtitle: "Say goodbye to boring dates and hello to new adventures with us.")
                            .tag(0)
                        OnboardingPageView(imageName: "onboarding2", title: "Pick a challenge card and do it with your partner", subtitle: "Strengthen your relationship and have fun with our exciting challenges.")
                            .tag(1)
                        OnboardingPageView(imageName: "onboarding3", title: "Capture and treasure your loving memories!", subtitle: "Take a photo on every challenge completed and save it in memory lane.")
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                    .onAppear {
                        setupAppearance()
                    }
                    .onChange(of: currentPageIndex) { newIndex in
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                    
                    Button(action: {
                        show = true
                        dataManager.syncWithFirebase()
                    }, label: {
                        Text("Skip")
                            .font(.custom("Poppins", size: 16))
                            .foregroundColor(Color.primaryDarkBlue)
                    })
                }
                
                Button(action: {
                    if currentPageIndex < 2 {
                        currentPageIndex += 1
                    } else {
                        show = true
                        dataManager.syncWithFirebase()
                    }
                    // Connect to backend
//                    challengeViewModel.clearChallenges()
                }, label: {
                    if currentPageIndex < 2 {
                        Text("Next")
                            .font(.custom("Poppins-Bold", size: 14))
                    } else {
                        Text("Let's Go!")
                            .font(.custom("Poppins-Bold", size: 14))
                    }
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
            }
            .padding(24)
            .background(.white)
            .fullScreenCover(isPresented: $show) {
                RegistrationView()
            }
//        }
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
