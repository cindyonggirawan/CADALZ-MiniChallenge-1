//
//  OngoingChallengeView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct OngoingChallengeView: View {
    @StateObject var memoryViewModel = MemoryViewModel()
    @State var showSheet = false
    @State var isGiveUp = false
    
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
                    Text(memoryViewModel.memories[memoryViewModel.memories.count-1].challenge!.name!)
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
                    TimerView(setDate: memoryViewModel.memories[memoryViewModel.memories.count-1].date!)
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
            .background(memoryViewModel.checkChallengeCategoryColor(memory: memoryViewModel.memories[memoryViewModel.memories.count-1]))
            
            VStack {
                Button(action: {
                    showSheet = true
                }, label: {
                    Text("Finish Challenge")
                        .font(.custom("Poppins-Bold", size: 14))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
                .padding(.top, 20)
                .padding(.horizontal, 24)
                .sheet(isPresented: $showSheet) {
                    ChallangeReviewModal()
                }
                
                Button(action: {
                    memoryViewModel.removeMemory()
                    isGiveUp = true
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
        .fullScreenCover(isPresented: $isGiveUp, content: {
            GenerateChallengeView()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct OngoingChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        OngoingChallengeView()
    }
}
