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
//    @EnvironmentObject var memoryViewModel: MemoryViewModel
    @StateObject var memoryViewModel = MemoryViewModel()
    
    @StateObject var challengeViewModel = ChallengeViewModel()
    
    @State var isSelected: Bool = false
    @State var isSelect: Bool = true  // Tombol kanan atasnya adalah -> TRUE: "Select"; FALSE: "Cancel"
    @State var circleIsClicked: Bool = false
    @State var totalSelectedPhoto = 0
    
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
                    CategoryCapsuleViewDua(memoryViewModel: memoryViewModel, category: "Food")
                    CategoryCapsuleViewDua(memoryViewModel: memoryViewModel, category: "Entertainment")
                    CategoryCapsuleViewDua(memoryViewModel: memoryViewModel, category: "Travel")
                    CategoryCapsuleViewDua(memoryViewModel: memoryViewModel, category: "Well-being")
                }
                .frame(maxWidth: 347)
                .padding(.vertical, 25)

                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(self.memoryViewModel.filteredMemories, id: \.self) { memory in
                            if memory.photo != nil {
                                SelectImageView(memoryViewModel: memoryViewModel, memory: memory, isSelect: $isSelect, totalSelectedPhoto: $totalSelectedPhoto)
                            }
                        }
                    }
                }
                
                if !isSelected {
                    //SHOW SELECTED PHOTO
                    if totalSelectedPhoto == 0 {
                        Text("Select Photo")
                    }else if totalSelectedPhoto == 1{
                        Text("1 Photo Selected")
                    }else {
                        Text("\(totalSelectedPhoto) Photos Selected")
                    }
                }
            }
            .background(Color.primaryWhite)
            .navigationTitle("Memory Lane")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Text(self.isSelect ? "Select" : "Cancel")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .padding(.leading, 55)
                        .onTapGesture {
                            self.isSelect.toggle()
                        }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading){
                    Image("trash-icon")
                        .onTapGesture {
                            print(memoryViewModel.memoriesId.count)
                            if memoryViewModel.memoriesId.count > 0 { // DELETE-CONFIRMATION PAS ADA YG MAU DIHAPUS AJA
                                self.isShowingAlert = true
                            }
                        }
                    // IPHONE ALERT POP UP
                        .alert("Delete your \(memoryViewModel.memoriesId.count) memories?", isPresented: $isShowingAlert) {
                            Button("Delete", role: .destructive) {
                                // GO DELETE MEMORIES!
                                memoryViewModel.deleteMemoryPhotos()
                                memoryViewModel.memoriesId = []
                                self.isSelect = true
                            }
                        }
                }
            }
        }
    }
}
