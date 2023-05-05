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
    @StateObject var memoryViewModel = MemoryViewModel()
    var memory: Memory
    
    @Binding var isSelected: Bool
    @State var circleIsClicked: Bool = false
    
    @State private var showSheet = false
    @State private var size: CGSize = .zero
    
    @State private var dateOfMemory: String = ""
    
    var body: some View {
        if self.isSelected {
            Button {
                showSheet = true
                dateOfMemory = changeDateFormat(memory: memory)
            } label: {
                Image(uiImage: memory.photo!)
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
                            .foregroundColor(Color.primaryPurple)
                            .frame(width: 342, height: 368)
                        
                        Image(uiImage: memory.photo!)
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
        } else {
            ZStack {
                Image(uiImage: memory.photo!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 116, height: 118)
                    .clipped()
                    .contentShape(Rectangle())
                
                if !self.isSelected {
                    SelectCircle(circleIsClicked: $circleIsClicked) // buletannya muncul
                }
            }
            .frame(width: 116, height: 118)
            .onTapGesture {
                if !self.isSelected {
                    self.circleIsClicked.toggle()
                    
                    if let id = memory.id {
                        memoryViewModel.appendMemoryUUID(id)
                    }
                }
            }
            .drawingGroup() // karena UIImage nya UIKit, aspectRatio SwiftUI gak bisa -daniel
        }
    }
    
    func changeDateFormat(memory: Memory) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let dateString = dateFormatter.string(from: memory.date ?? Date())
        return "\(dateString)"
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
    @State var isClicked: Bool = false
    
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
