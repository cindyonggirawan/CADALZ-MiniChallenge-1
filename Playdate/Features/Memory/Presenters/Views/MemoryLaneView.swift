//
//  SwiftUIView.swift
//  Playdate
//
//  Created by Daniel Bernard Sahala Simamora on 04/05/23.
//

import SwiftUI
import PhotosUI
import UIKit


struct MemoryLaneView: View {
//    @StateObject var memoryViewModel = MemoryViewModel()
    @EnvironmentObject var memoryViewModel: MemoryViewModel
    
    @StateObject var challengeViewModel = ChallengeViewModel()
    
    @State var isSelected: Bool = true
    @State var circleIsClicked: Bool = false
    
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: 108 + 5)),
        GridItem(.flexible(minimum: 100, maximum: 108 + 5)),
        GridItem(.flexible(minimum: 100, maximum: 108 + 5))
    ]
    
    @State var isShowingAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 4) {
                    //TODO: Set Category Value
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Food", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Entertainment", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Travel", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                    CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Well-being", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                }
                .frame(maxWidth: 347)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(self.memoryViewModel.memories, id: \.self) { memory in
                            if memory.photo != nil {
//                                VStack {
//                                    Text("\(memory.id!)") // BUAT NGELIAT UUID NYA BENTAR
//                                }
                                SelectImageView(memory: memory, isSelected: $isSelected)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigation) {
                    Image("trash-icon")
                        .onTapGesture {
                            if memoryViewModel.memoriesId.count > 0 { // DELETE-CONFIRMATION PAS ADA YG MAU DIHAPUS AJA
                                self.isShowingAlert = true
                            }
                        }
                    // IPHONE ALERT POP UP
                        .alert("Delete your \(memoryViewModel.memoriesId.count) memories?", isPresented: $isShowingAlert) {
                            Button("Delete", role: .destructive) {
                                // GO DELETE MEMORIES!
                                memoryViewModel.deleteMemoryPhotos()
                            }
                        }

                    
                    Text("Memory Lane")
                        .font(.custom("Poppins-SemiBold", size: 17))
                        .foregroundColor(Color.black)
                        .padding(.leading, 120)
                    
                    Text(self.isSelected ? "Select" : "Cancel")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .padding(.leading, 60)
                        .onTapGesture {
                            self.isSelected.toggle()
                        }
                }
            }
        }
    }
}
 

//struct MemoryLaneView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoryLaneView()
//    }
//}
