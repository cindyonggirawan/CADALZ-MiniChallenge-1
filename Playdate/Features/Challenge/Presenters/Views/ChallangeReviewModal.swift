//
//  challangeReviewModal.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 22/04/23.
//

import SwiftUI

struct ChallangeReviewModal: View {
    @State var navChallengeModal = 1
    @State var isLikeChallenge = true
    
    var body: some View {
        NavigationView {
            VStack {
                ChallengeCardSmall()
                    .padding(20)
                
                if (navChallengeModal == 1){
                    Text("Do you like the challenge?")
                        .font(.custom("Poppins-semibold", size: 20))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    HStack {
                        ZStack {
                            Button(action: {
                                navChallengeModal = 2
                                isLikeChallenge = true
                                print("Button pressed \(isLikeChallenge)")
                            }) {
                                // Add LIKE Illustration here
                                Text("Like")
                            }
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.black)
                            .background(Color.green)
                            .clipShape(Circle())
                        }
                        .padding(20)
                        
                        ZStack {
                            Button(action: {
                                navChallengeModal = 2
                                isLikeChallenge = false
                                print("Button pressed \(isLikeChallenge)")
                            }) {
                                // Add LIKE Illustration here
                                Text("Dislike")
                            }
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.black)
                            .background(Color.red)
                            .clipShape(Circle())
                        }
                        .padding(20)
                    }
                    .padding(.bottom, 279)
                } else {
                    ChallengeSubmitModal()
                }
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if ( navChallengeModal == 1 ){
                            Button("Cancel") {}
                        } else {
                            Button("Prev") {
                                navChallengeModal = 1
                            }
                        }
                    }
                }
        }
    }
}

struct ChallangeReviewModal_Previews: PreviewProvider {
    static var previews: some View {
        ChallangeReviewModal()
    }
}
