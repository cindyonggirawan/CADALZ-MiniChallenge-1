//
//  OngoingChallengeView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct OngoingChallengeView: View {
    var toDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    var body: some View {
        VStack{
            VStack {
                VStack(alignment: .leading) {
                    //TODO: Nama user ambil dari coredata
                    HStack{
                        Text("Hi Alfine,")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.primaryWhite.opacity(0.7))
                            .padding(.bottom, -8)
                        Spacer()
                    }
                    
                    Text("Let’s do the challenge!")
                        .font(.custom("Poppins-Medium", size: 22))
                        .foregroundColor(.primaryWhite)
                }
                .frame(maxWidth: 342)
                
                Spacer()
                
                //Challenge text
                HStack {
                    Text("Watch a horror film released before the year 2000 with your partner")
                        .font(.custom("Poppins-SemiBold", size: 28))
                        .lineSpacing(4)
                        .foregroundColor(.primaryWhite)
                    Spacer()
                }
                .padding(.bottom, 30)
                .frame(maxWidth: 342)
                
                Spacer()
                
                //Countdown
                VStack(spacing: 8) {
                    TimerView(setDate: toDate)
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(.primaryWhite)
                    Text("Time left to do the challenge")
                        .font(.custom("Poppins-Medium", size: 14))
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
                        .font(.custom("Poppins-Bold", size: 14))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
                .padding(.top, 20)
                .padding(.horizontal, 24)
                
                Button(action: {
                    //TODO: Accept Action
                    
                }, label: {
                    Text("Give Up")
                        .font(.custom("Poppins-SemiBold", size: 14))
                })
                .buttonStyle(.plain)
                .padding(.top, 20)
                .padding(.horizontal, 24)
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
