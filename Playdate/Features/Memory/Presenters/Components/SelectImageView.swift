//
//  SelectCircle.swift
//  Playdate
//
//  Created by Daniel Bernard Sahala Simamora on 05/05/23.
//

import SwiftUI

struct SelectImageView: View {
//    @EnvironmentObject var memoryViewModel: MemoryViewModel
    //Jangan pake environment object, pakenya state object supaya fungsi initnya bisa kepanggil
    @StateObject var challengeViewModel = ChallengeViewModel()
//    @StateObject var memoryViewModel = MemoryViewModel()
    @ObservedObject var memoryViewModel: MemoryViewModel // ganti ObservedObject supaya dia nge-refer ke single @StateObject aja di MemoryLaneView, karena trigger manipulasi database nya di situ -DANIEL
    var memory: Memory
    
    @State var isSelected: Bool = false // TRUE ketika image nya diklik, untuk ceklis ungu
    @Binding var isSelect: Bool // Tombol kanan atasnya adalah -> TRUE: "Select"; FALSE: "Cancel"
    @Binding var totalSelectedPhoto: Int
//    @State var circleIsClicked: Bool = false
    
    @State private var showSheet = false
    @State private var size: CGSize = .zero
    
    @State private var dateOfMemory: String = ""
    
    var body: some View {
        if let photo = memory.photo {
            if self.isSelect {
                Button {
                    showSheet = true
                    dateOfMemory = changeDateFormat(memory: memory)
                } label: {
                    Image(uiImage: photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 116, height: 118)
                        .clipped()
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
                            
                            Text("\(dateOfMemory)")
                                .font(.custom("Poppins-medium", size: 17))
                                .foregroundColor(Color.primaryDarkBlue)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(checkChallengeCategoryColor(challengeCategory: memory.challenge?.category ?? ""))
                                .frame(width: 342, height: 368)
                            
                            Image(uiImage: photo)
                                .resizable()
                                .frame(width: 310, height: 310)
                                .scaledToFill()
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
                            //Cara mengakses challenge dari memory bagaimana?
                            Text("\(memory.challenge?.name ?? "")")
                                .font(.custom("Poppins-semibold", size: 16))
                                .foregroundColor(Color.primaryDarkBlue)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Rectangle()
                                .fill(Color.primaryLightGray)
                                .frame(width: .infinity, height: 2, alignment: .center)
                            
                            Text("\"\(memory.momentDescription ?? "")\"")
                                .font(.custom("Poppins", size: 15))
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
                                Color.primaryWhite
                                    .preference(key: SizePreferenceKey.self, value: geometry.size)
                                
                                Image(challengeViewModel.getDoodle(category: memory.challenge!.category!))
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
            } else {
                ZStack {
                    Image(uiImage: photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 116, height: 118)
                        .clipped()
                        .contentShape(Rectangle())

                    SelectCircle(circleIsClicked: $isSelected) // buletannya muncul
                }
                .frame(width: 116, height: 118)
                .onTapGesture {
                    self.isSelected.toggle()
                    if isSelected {
                        totalSelectedPhoto += 1
                    }else {
                        totalSelectedPhoto -= 1
                    }
                    if let id = memory.id {
                        memoryViewModel.appendMemoryUUID(id)
                    }
                    
                    //                if self.isSelected {
                    //                }
                }
                .drawingGroup() // karena UIImage nya UIKit, aspectRatio SwiftUI gak bisa -daniel
            }
        }
    }
    
    func changeDateFormat(memory: Memory) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let dateString = dateFormatter.string(from: memory.date ?? Date())
        return "\(dateString)"
    }
    
    func checkChallengeCategoryColor(challengeCategory: String) -> Color {
        if challengeCategory.lowercased() == "travel" {
            return Color.primaryOrange
        } else if challengeCategory.lowercased() == "entertainment" {
            return Color.primaryPurple
        } else if challengeCategory.lowercased() == "food" {
            return Color.primaryRed
        } else if (challengeCategory.lowercased() == "well-being") {
            return Color.primaryGreen
        } else {
            return Color.gray
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SelectCircle: View {
    @Binding var circleIsClicked: Bool
//    @State var isClicked: Bool = false
    
    var body: some View {
        Group {
            Circle()
                .fill(.white)
                .frame(width: 24, height: 24)
                .opacity(0.5)
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: 2)
                )
                .overlay(
                    self.getPurpleCircle(circleIsClicked)
                )
                .padding(.leading, 80)
                .padding(.bottom, 80)
        }
    }
    
    func getPurpleCircle(_ isClicked: Bool) -> AnyView {
        if isClicked {
            return AnyView(
                ZStack {
                    Circle()
                        .fill(Color.primaryPurple)
                        .overlay(
                            Circle()
                                .stroke(.white, lineWidth: 2)
                        )
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                }
            )
        } else {
            return AnyView(EmptyView())
        }
    }
}
