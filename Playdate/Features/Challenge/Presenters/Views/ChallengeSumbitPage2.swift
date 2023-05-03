//
//  ChallengeSumbitPage2.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 03/05/23.
//

import SwiftUI
import PhotosUI

struct ChallengeSumbitPage2: View {
    @Binding var isLikeChallenge: Bool
    @State var momentDescription = ""
    @State var navChallengeModal = 1
//    @State var selectedItems: [PhotosPickerItem] = []
    @State private var selectedItems: PhotosPickerItem?
    @State var data: Data?
    @State private var selectedImage: Image?
    @State private var showImage: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
//                ChallengeCardSmall()
//                    .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Add photos")
                        .font(.custom("Poppins", size: 18))
                        .bold()
                        .foregroundColor(Color.black)
                    
                    PhotosPicker (
                        selection: $selectedItems,
                        matching: .images
                    ) {
                        ZStack {
                            VStack {
                                Image("profile-icon")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                
                                Text("Upload")
                                    .font(.custom("Poppins", size: 16))
                                    .foregroundColor(Color.primaryDarkGray)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.primaryLightGray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                    .foregroundColor(Color.primaryDarkGray)
                            )
//                            if let data = data, let uiimage = UIImage(data: data) {
//                                Image(uiImage: uiimage)
//                                    .resizable()
//                            }
                        }
                    }
//                    .onChange(of: selectedItems) { newValue in
//                        guard let item = selectedItems.first else {
//                            return
//                        }
//                        item.loadTransferable(type: Data.self) { result in
//                            switch result {
//                            case .success(let data):
//                                if let data = data {
//                                    self.data = data
//                                } else {
//                                    print("Data is nil")
//                                }
//                            case .failure(let failure):
//                                fatalError("\(failure)")
//                            }
//                        }
//                    }
                    // TRIAL
                    .onChange(of: selectedItems) { _ in
                        Task {
                            if let data = try? await selectedItems?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    showImage = true
                                    selectedImage = Image(uiImage: uiImage)
                                        .resizable()
                                    return
                                }
                            }
                            print("failed")
                        }
                    }
                }
                .padding(.bottom, 20)
                
                if (showImage){
                    selectedImage
                }
                
                VStack(alignment: .leading) {
                    Text("Write about this moment")
                        .font(.custom("Poppins", size: 18))
                        .bold()
                        .foregroundColor(Color.black)
                    
                    TextField("How do you feel doing this challenge?", text: $momentDescription, axis: .vertical)
                        .textFieldStyle(UnborderedTextFieldStyle())
                        .font(.custom("Poppins", size: 16))
                        .foregroundColor(Color.primaryDarkGray)
                }
                
                Spacer()
                
                Button(action: {
                    //TODO: send isLike data to firebase
//                    FBaddLikeToChallenge()
//                    pake function ini buat simpen ke memory ->
//                    MemoryViewModel.submitMemory(photo: URL(resolvingBookmarkData: uiimage, bookmarkDataIsStale: &<#T##Bool#>), description: momentDescription)
                    
                }, label: {
                    Text("Submit")
                        .font(.custom("Poppins-Bold", size: 14))
                })
                .buttonStyle(FixedSizeRoundedButtonStyle())
            }
            .padding(20)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    if ( navChallengeModal == 1 ){
//                        Button("Cancel") {}
//                    } else {
//                        Button("Prev") {
//                            navChallengeModal = 1
//                        }
//                    }
//                }
//            }
        }
    }
}
//
//struct ChallengeSumbitPage2_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeSumbitPage2()
//    }
//}
