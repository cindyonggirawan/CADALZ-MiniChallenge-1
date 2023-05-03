//
//  MemoryLaneView.swift
//  Playdate
//
//  Created by Daniel Bernard Sahala Simamora on 02/05/23.
//

import SwiftUI
import PhotosUI
import UIKit

struct MemoryLaneView: View {
    @StateObject var memVm = MemoryViewModel()
    @StateObject var challengeViewModel = ChallengeViewModel()
    
    @State private var selectedImage:[PhotosPickerItem] = []
    @State private var selectedImageData: [Data] = []
    
    @State var photoIdx: Int = 0
    
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]
    
    var body: some View {
        /*
        NavigationStack {
            VStack{
                if selectedImageData.count > 0{
                    // Show Image
                    ScrollView{
                        LazyVGrid(columns: [.init(.adaptive(minimum: 500)), .init(.adaptive(minimum: 500))]){
                            ForEach(selectedImageData, id: \.self){dataItem in
                                if let dataItem = dataItem, let uiImage = UIImage(data: dataItem){
                                    Image(uiImage: uiImage).resizable().frame(width: 150, height: 150).aspectRatio(contentMode: .fill).cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                    }
                }
                else{
                    Spacer()
                    Text("Please select image by tapping on photo icon on toolbar").foregroundColor(.gray).font(.system(size: 25)).bold().multilineTextAlignment(.center)
                }
                Spacer()
                Text("\(selectedImageData.count) photos")
            }
            .navigationTitle("Photo Album")
            .toolbar{
                PhotosPicker(selection: $selectedImage, maxSelectionCount: 2, matching: .images, label: {
                    Image(systemName: "photo.fill").tint(.red)
                })
                .onChange(of: selectedImage) {newItem in
                    print("mantap", selectedImage.count)
                    Task{
                        selectedImage = []
                        for item in newItem {
                            if let data = try? await item.loadTransferable(type: Data.self){
                                print(type(of: data))
                                print(data)
                                selectedImageData.append(data)
                                print("====\n")
                            }
                        }
                    }
                }
            }
        }
         
        */
        /*
        ScrollView {
//            UIImage(data:)
            ForEach((vm.memories)) { memory in
                VStack {
                    if let photo = memory.photo {
                        Image(uiImage: photo)
                        Text("yeah")
                        
                    }
                    
                }
            }
        }
        */
        
        VStack {
            Text("Memory Lane")
                .font(.custom("Poppins-SemiBold", size: 17))
                .foregroundColor(Color.black)
            
            HStack(spacing: 4) {
                //TODO: Set Category Value
                CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Food", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Entertainment", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Travel", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
                CategoryCapsuleView(challengeViewModel: challengeViewModel, category: "Well-being", displayedChallenges: $challengeViewModel.displayedChallenges, lastDisplayIndex: $challengeViewModel.lastDisplayIndex)
            }
            .frame(maxWidth: 347)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(self.memVm.memories, id: \.self) { memory in
                        Image(uiImage: memory.photo!)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
    func calculateTheIndex(i: Int, j: Int) -> Int {
        return i + i + i + j
    }
    
    func increaseIndex() -> EmptyView {
        let idx = self.photoIdx
        if idx < self.memVm.memories.count {
            self.photoIdx += 1
            print(self.photoIdx)
            DispatchQueue.global(qos: .background).async {
            }
        }
        return EmptyView()
    }
}

//struct MemoryLaneView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoryLaneView()
//    }
//}
