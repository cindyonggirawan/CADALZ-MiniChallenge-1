//
//  ProfileView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 23/04/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack () {
            Text("Profile")
                .font(.custom("Poppins-Bold", size: 18))
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .background(Color.primaryWhite)
                .padding(-50)
            
            Image("profile-default")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.top, 72)
                .padding(.bottom, 10)
            
            Text("\(userViewModel.user[userViewModel.user.count-1].name!)")
                .font(.custom("Poppins-Regular", size: 22))
                .padding(.bottom, 15)
            
            ZStack {
                Image("challenge-complete")
                
                VStack {
                    Text("You Have Completed")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(Color.primaryWhite)
                        .opacity(0.7)
                    
                    HStack (alignment: .bottom) {
                        Text("40")
                            .font(.custom("Poppins-Bold", size: 40))
                            .foregroundColor(Color.primaryWhite)
                            .padding(.top, -10)
                        
                        Text("Challenges!")
                            .font(.custom("Poppins-Bold", size: 14))
                            .foregroundColor(Color.primaryWhite)
                            .opacity(0.7)
                            .padding(.bottom, 10)
                    }
                }
            }
            
            Spacer()
        }
        .padding(24)
        .background(Color.primaryLightGray)
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
