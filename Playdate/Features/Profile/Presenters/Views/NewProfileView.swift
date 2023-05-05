//
//  NewProfileView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 04/05/23.
//

import SwiftUI

struct NewProfileView: View {
    @StateObject var userViewModel = UserViewModel()
    @StateObject var memoryViewModel = MemoryViewModel()
    
    @State private var showSplash = false
    @State private var showAlert = false
    @State private var name = ""
    
    var body: some View {
        VStack {
//            Text("Profile")
//                .font(.custom("Poppins-Bold", size: 18))
//                .foregroundColor(Color.primaryDarkBlue)
//                .background(Color.primaryWhite)
            
            ZStack {
                Image("profile-frame")
                    .resizable()
                    .scaledToFit()
                
                VStack {
                    Image("trophy")
                        .resizable()
                        .frame(width: 263, height: 264)
                    
                    VStack {
                        Text("\(userViewModel.user[userViewModel.user.count-1].name ?? "")")
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
                            Text("\(getMemoriesCount())")
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
            .offset(y: -5)
            
            Button(action: {
                showAlert = true
            }, label: {
                Text("Delete my account")
                    .font(.custom("Poppins-Bold", size: 14))
            })
            .buttonStyle(FixedSizeRoundedButtonStyle())
            .frame(width: 342)
            .offset(y: -15)
            .padding(.bottom, 10)
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
        }
//        .padding(.bottom, 20)
        .background(Color.primaryWhite)
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
    
    func getMemoriesCount() -> Int {
        if memoryViewModel.memories.count != 0 {
            if memoryViewModel.memories[memoryViewModel.memories.count-1].status == "ongoing"{
                return memoryViewModel.memories.count - 1
            }else {
                return memoryViewModel.memories.count
            }
        }else {
            return 0
        }
    }
}

//struct NewProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewProfileView()
//    }
//}
