//
//  OnboardingView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 21/04/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
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
                RegistrationView()
            }, label: {
                Text("Next")
            })
            .buttonStyle(FixedSizeRoundedButtonStyle())
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
                .scaledToFit()
                .background(Color.primaryLightGray)
            
            Text(title)
                .font(.title)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .padding()
            
            Text(subtitle)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
        }
        .ignoresSafeArea(.all)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
