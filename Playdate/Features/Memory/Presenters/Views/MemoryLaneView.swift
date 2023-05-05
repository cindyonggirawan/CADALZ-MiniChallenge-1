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
    
    @State var isSelected: Bool = true
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
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(self.memoryViewModel.filteredMemories, id: \.self) { memory in
                            if memory.photo != nil {
//                                VStack {
//                                    Text("\(memory.id!)") // BUAT NGELIAT UUID NYA BENTAR
//                                }
                                SelectImageView(memory: memory, isSelected: $isSelected, totalSelectedPhoto: $totalSelectedPhoto)
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
//                ToolbarItemGroup(placement: .navigation) {
                    
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Text(self.isSelected ? "Select" : "Cancel")
                            .font(.system(size: 17))
                            .foregroundColor(.gray)
                            .padding(.leading, 60)
                            .onTapGesture {
                                self.isSelected.toggle()
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
                            }
                        }
                }


                    
//                    Text("Memory Lane")
//                        .font(.custom("Poppins-SemiBold", size: 17))
//                        .foregroundColor(Color.black)
//                        .padding(.leading, 120)
                    
                    
//                }
            }
        }
    }
}
 

//struct MemoryLaneView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoryLaneView()
//    }
//}
