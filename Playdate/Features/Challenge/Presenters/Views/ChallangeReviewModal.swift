//
//  challangeReviewModal.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 22/04/23.
//

import SwiftUI

struct ChallangeReviewModal: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ChallengeCardSmall()
                Spacer()
                Text("Do you like the challenge?")
                    .font(.custom("Poppins-semibold", size: 20))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                Spacer()
                HStack {
                    ZStack {
                        Button(action: {
                            // Add LIKE Function here
                            print("Button pressed")
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
                            // Add LIKE Function here
                            print("Button pressed")
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

            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {}
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
