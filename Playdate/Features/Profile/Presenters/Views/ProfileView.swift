//
//  ProfileView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 23/04/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var userViewModel = UserViewModel()
    @StateObject var memoryViewModel = MemoryViewModel()
    
    @State private var showSplash = false
    @State private var showAlert = false
    @State private var name = ""
    
    var body: some View {
        VStack {
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
            
            Text("\(userViewModel.user[userViewModel.user.count-1].name ?? "")")
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
            
            Button(action: {
                showAlert = true
            }, label: {
                Text("Delete my account")
                    .font(.custom("Poppins-Bold", size: 14))
            })
            .buttonStyle(FixedSizeRoundedButtonStyle())
            .alert("Are you sure to delete your account?", isPresented: $showAlert) {
                TextField("Name", text: $name)
                Button("Delete", action: {
                    if deleteThisUser() {
                        userViewModel.removeUser(name: userViewModel.user[userViewModel.user.count-1].name!)
                        memoryViewModel.removeAllMemories()
                        showSplash = true
                    }
                })
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Enter your name to delete your account and all your memories.")
            }
            
            Spacer()
        }
        .padding(24)
        .background(Color.primaryLightGray)
        .fullScreenCover(isPresented: $showSplash) {
            SplashView()
        }
    }
    
    func deleteThisUser() -> Bool {
        if name == userViewModel.user[userViewModel.user.count-1].name! {
            return true
        } else {
            return false
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
