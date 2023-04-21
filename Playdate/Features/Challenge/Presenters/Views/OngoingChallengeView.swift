//
//  OngoingChallengeView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct OngoingChallengeView: View {
    var body: some View {
        VStack{
            VStack {
                VStack(alignment: .leading) {
                    //TODO: Nama user ambil dari coredata
                    HStack{
                        Text("Hi Alfine,")
                            //TODO: Font Family Poppins
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                            .foregroundColor(.primaryWhite.opacity(0.7))
                            .padding(.bottom, -1)
                        Spacer()
                    }
                    
                    Text("Let’s do the challenge!")
                        //TODO: Font Family Poppins
                        .font(.system(size: 22))
                        .fontWeight(.medium)
                        .foregroundColor(.primaryWhite)
                }
                .frame(maxWidth: 342)
                
                Spacer()
                
                //Challenge text
                HStack {
                    Text("Watch a horror film released before the year 2000 with your partner")
                    //TODO: Font Family Poppins
                        .font(.system(size: 28))
                        .fontWeight(.semibold)
                        .lineSpacing(4)
                        .foregroundColor(.primaryWhite)
                    Spacer()
                }
                .padding(.bottom, 30)
                .frame(maxWidth: 342)
                
                Spacer()
                
                //Countdown
                VStack(spacing: 8) {
                    Text("12:06:30")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(.primaryWhite)
                    Text("Time left to do the challenge")
                    //TODO: Font Family Poppins
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.primaryWhite.opacity(0.5))
                }
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(Color.primaryWhite.opacity(0.2))
                .cornerRadius(8)
                
            }
            .padding(.vertical, 25)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.6)
            .background(Color.primaryPurple)
            
            VStack {
                Button(action: {
                    //TODO: Accept Action
                    
                }, label: {
                    Text("Finish Challenge")
                        //TODO: Set Font Family "Poppins"
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
                .padding(.top, 20)
                
                
                    Button(action: {
                        //TODO: Accept Action
                        
                    }, label: {
                        Text("Give Up")
                            //TODO: Set Font Family "Poppins"
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                    })
                    .buttonStyle(.plain)
                    .padding(.top, 20)
            }
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct OngoingChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        OngoingChallengeView()
    }
}
