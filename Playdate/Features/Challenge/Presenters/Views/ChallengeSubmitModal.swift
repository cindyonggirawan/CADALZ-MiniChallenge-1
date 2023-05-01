//
//  ChallengeSubmitModal.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 23/04/23.
//

import SwiftUI
import PhotosUI

struct ChallengeSubmitModal: View {
    @Binding var isLikeChallenge: Bool
    @State var momentDescription = ""
    @State var navChallengeModal = 1
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    
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
                    
                    if let data = data, let uiimage = UIImage(data: data) {
                        Image(uiImage: uiimage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    
                    PhotosPicker(
                        selection: $selectedItems,
                        maxSelectionCount: 1,
                        matching: .images
                    ) {
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
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                .foregroundColor(Color.primaryDarkGray)
                        )
                    }
                    .onChange(of: selectedItems) { newValue in
                        guard let item = selectedItems.first else {
                            return
                        }
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let data):
                                if let data = data {
                                    self.data = data
                                } else {
                                    print("Data is nil")
                                }
                            case .failure(let failure):
                                fatalError("\(failure)")
                            }
                        }
                    }
                }
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Write about this moment")
                        .font(.custom("Poppins", size: 18))
                        .bold()
                        .foregroundColor(Color.black)
                    
                    TextField("How do you feel doing this challenge?", text: $momentDescription, axis: .vertical)
                        .textFieldStyle(UnborderedTextFieldStyle())
                        .font(.custom("Poppins", size: 16))
                }
                
                Spacer()
                
                Button(action: {
                    //TODO: send isLike data to firebase
//                    FBaddLikeToChallenge()
//                    pake function ini buat simpen ke memory -> memoryViewModel.submitMemory(photo: <#T##UIImage#>, description: <#T##String#>) (BELUM DI TESTING SAMA SEKALI)
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

//struct ChallengeSubmitModal_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeSubmitModal()
//    }
//}
