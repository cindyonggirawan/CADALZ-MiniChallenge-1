//
//  OnboardingView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 21/04/23.
//

import SwiftUI

struct OnboardingView: View {
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
                }, label: {
                    Text("Next")
                        .font(.custom("Poppins", size: 16))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
            }
            .padding(24)
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
                .scaledToFit()
                .background(Color.primaryLightGray)
                .padding(.bottom, 32)
            
            Text(title)
                .font(.custom("Poppins", size: 32))
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .padding(.bottom, 16)
            
            Text(subtitle)
                .font(.custom("Poppins", size: 20))
                .foregroundColor(Color.primaryDarkGray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 70)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
