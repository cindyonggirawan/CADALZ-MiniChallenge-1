//
//  NewProfileView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 04/05/23.
//

import SwiftUI

struct NewProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("profile-frame")
                    .resizable()
                    .scaledToFit()
                
                VStack {
                    Image("trophy")
                        .resizable()
                        .frame(width: 263, height: 264)
                    
                    VStack {
                        Text("Alfine Wijaya")
                            .font(.custom("Poppins-semibold", size: 24))
                            .foregroundColor(Color.primaryWhite)
                            .padding(.bottom, 2)
                        
                        Text("Newbie Adventurer")
                            .font(.custom("Poppins", size: 16))
                            .foregroundColor(Color.primaryWhite)
                    }
                    .padding(.bottom, 40)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.primaryWhite.opacity(0.2))
                            .shadow(radius: 10, y: 20)
                        
                        VStack {
                            Text("40")
                                .font(.custom("Poppins-semibold", size: 80))
                                .foregroundColor(Color.primaryWhite)
                            
                            Text("challenge completed")
                                .font(.custom("Poppins", size: 16))
                                .foregroundColor(Color.primaryWhite)
                                .padding(.bottom, 20)
                        }
                    }
                    .frame(width: 278, height: 172)
                    .offset(y: -20)
                }
            }
            .offset(y: -30)
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

struct NewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NewProfileView()
    }
}
