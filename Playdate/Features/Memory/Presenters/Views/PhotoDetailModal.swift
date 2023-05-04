//
//  PhotoDetailModal.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 04/05/23.
//

import SwiftUI

struct PhotoDetailModal: View {
    @State private var showSheet = false
    @State private var size: CGSize = .zero
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    showSheet = true
                } label: {
                    Image("couple")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .sheet(isPresented: $showSheet) {
                    VStack {
                        ZStack {
                            HStack {
                                Group {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(Color.primaryDarkGray)

                                    
                                    Text("Close")
                                        .foregroundColor(Color.primaryDarkGray)
                                        .offset(x: -4)
                                }
                                .onTapGesture {
                                    showSheet = false
                                }
                                    
                                Spacer()
                            }
                            
                            Text("22 April 2023")
                                .font(.custom("Poppins-medium", size: 17))
                                .foregroundColor(Color.primaryDarkBlue)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.primaryPurple)
                                .frame(width: 342, height: 368)
                            
                            Image("couple")
                                .resizable()
                                .frame(width: 310, height: 310)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .offset(y: -16)
                            
                            Text("PLAYDATE")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(.primaryWhite)
                                .opacity(0.5)
                                .offset(y: 160)
                        }
                        
                        VStack(spacing: 16) {
                            Text("Walk around the block and pick a flower for your partner!")
                                .font(.custom("Poppins-semibold", size: 16))
                                .foregroundColor(Color.primaryDarkBlue)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Rectangle()
                                .fill(Color.primaryLightGray)
                                .frame(width: .infinity, height: 2, alignment: .center)
                            
                            Text("\"" + "Walk around the block and pick a flower for your partner!" + "\"")
                                .font(.custom("Poppins-italic", size: 15))
                                .foregroundColor(Color.primaryDarkGray)
                                .italic()
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                
                        }
                        .padding(.top, 32)
                    }
                    .padding([.top, .leading, .trailing], 24)
                    .background(
                        GeometryReader { geometry in
                            ZStack {
                                Color.clear
                                    .preference(key: SizePreferenceKey.self, value: geometry.size)
                                
                                Image("doodle-food")
                                    .resizable()
                                    .scaledToFill()
                                    .opacity(0.12)
                                    .frame(width: 800, height: 800)
                            }
                        }
                    )
                    .onPreferenceChange(SizePreferenceKey.self) { newSize in
                        size.height = newSize.height
                    }
                    .presentationDetents([.height(size.height)])
                }
            }
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct PhotoDetailModal_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailModal()
    }
}
