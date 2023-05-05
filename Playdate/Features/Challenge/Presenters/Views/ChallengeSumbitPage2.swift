//
//  ChallengeSumbitPage2.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 03/05/23.
//

import SwiftUI
import PhotosUI
import Firebase

struct ChallengeSumbitPage2: View {
    @StateObject var challengeViewModel = ChallengeViewModel()
    @StateObject var memoryViewModel = MemoryViewModel()
    @Binding var isLikeChallenge: Bool
    @State var momentDescription = ""
    @State var navChallengeModal = 1
//    @State var selectedItems: [PhotosPickerItem] = []
    @State private var selectedItems: PhotosPickerItem?
    @State var data: Data?
    @State var selectedImage: Image?
    @State private var showImage: Bool = false
    
    @State var selectedUIImage: UIImage = UIImage()
    @State var showVstack = false
    
    @State var show = false
    @State private var selectedTab = 0
    @State private var challengeImageName = "challenge-icon-selected"
    @State private var memoriesImageName = "memories-icon"
    @State private var profileImageName = "profile-icon"
    
    var body: some View {
        
        let currentMemories = memoryViewModel.memories[memoryViewModel.memories.count-1]
        
        ZStack{
            if showVstack {
                VStack{
                    ZStack{
                        // Photo Picker
                        VStack(alignment: .leading) {
                            PhotosPicker (
                                selection: $selectedItems,
                                matching: .images
                            ) {
                                VStack {
                                    Image("icon-camera-white")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .foregroundColor(Color.white)
                                    Text("Add Photo")
                                        .font(.custom("Poppins", size: 14))
                                        .foregroundColor(Color.white)
                                }
//                                .background(Color.green)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [9]))
                                        .foregroundColor(Color.white)
                                        .frame(width: 310, height: 310)
                                )
                            }
                        }
                        .onChange(of: selectedItems) { _ in
                            Task {
                                if let data = try? await selectedItems?.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        showImage = true
                                        selectedUIImage = uiImage
                                        selectedImage = Image(uiImage: uiImage)
                                            .resizable()
                                        return
                                    }
                                    print("failed")
                                }
                            }
                        }
                        
                        //Show Image if any
                        if (showImage){
                            // Perlu di clipped ke swiftUI
                            selectedImage
                                .frame(width: 310, height: 310)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .padding(.bottom, 390)
                    .padding(.top,60)
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.4))
            }

            
            // Description
            VStack(alignment: .leading){
                Text("Write about this moment")
                    .font(.custom("Poppins", size: 18))
                    .bold()
                    .foregroundColor(Color.black)
                    .padding(.top, 48)

                TextField("How do you feel doing this challenge?", text: $momentDescription, axis: .vertical)
                    .limitInputLength(value: $momentDescription, length: 100)
                    .autocorrectionDisabled()
                    .textFieldStyle(.plain)
                    .lineLimit(3, reservesSpace: true)
                    .font(.custom("Poppins", size: 16))
                    .foregroundColor(Color.primaryDarkGray)
                
                if selectedImage != nil && !momentDescription.isEmpty {
                    Button(action: {
                        //TODO: send isLike data to firebase
                        updateChallengeLike(challengeId: currentMemories.challenge!.id! , isLike: isLikeChallenge)
                        memoryViewModel.submitMemory(photo: selectedUIImage, description: momentDescription)
                        print(memoryViewModel.memories)
                        show = true
                    }, label: {
                        Text("Submit")
                            .font(.custom("Poppins-Bold", size: 14))
                    })
                    .buttonStyle(FixedSizeRoundedButtonStyle())
                    .padding(.top, 100)
                } else {
                    Button(action: {
                        //TODO: send isLike data to firebase
                        show = false
                    }, label: {
                        Text("Submit")
                            .font(.custom("Poppins-Bold", size: 14))
                    })
                    .buttonStyle(FixedSizeRoundedButtonDisabledStyle())
                    .padding(.top, 100)
                    .disabled(true)
                }
            }
            .padding(.top, 400)
            .padding(24)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showVstack = true
                }
            }
        }
        .fullScreenCover(isPresented: $show, content: {
            TabView(selection: $selectedTab) {
                GenerateChallengeView()
                    .tabItem {
                        Image(challengeImageName)
                        Text("Challenge")
                    }
                    .tag(0)
               
               
//                Text("Memories Tab")
                MemoryLaneView()
                    .tabItem {
                        Image(memoriesImageName)
                        Text("Memories")
                    }
                    .tag(1)
                
                NewProfileView()
                    .tabItem {
                        Image(profileImageName)
                        Text("Profile")
                    }
                    .tag(2)
            }
            .accentColor(Color.primaryDarkBlue)
            .onAppear() {
                UITabBar.appearance().backgroundColor = .white
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .tabViewStyle(DefaultTabViewStyle())
            .transition(.slide)
            .onChange(of: selectedTab) { value in
                switch value {
                case 0:
                    challengeImageName = "challenge-icon-selected"
                    memoriesImageName = "memories-icon"
                    profileImageName = "profile-icon"
                case 1:
                    memoriesImageName = "memories-icon-selected"
                    challengeImageName = "challenge-icon"
                    profileImageName = "profile-icon"
                case 2:
                    profileImageName = "profile-icon-selected"
                    challengeImageName = "challenge-icon"
                    memoriesImageName = "memories-icon"
                default:
                    break
                }
            }
        })
    }
    
    // FIREBASE
    func updateChallengeLike(challengeId: String, isLike: Bool){
        
        let db = Firestore.firestore()
        let x = db.collection("Challenges").whereField("Id", isEqualTo: challengeId)
        x.getDocuments {
            (result, error) in
            if error == nil {
                for document in result!.documents {
//                    Check Data
                    let data = document.data()
                    
                    var like = data["Like"] as? Int ?? -1
                    var numberOfUser = data["NumberOfUser"] as? Int ?? -1
                    
                    print("fetched like: \(like) | numberOfUser: \(numberOfUser)")
                    if isLike {
                        like+=1
                    }
                    numberOfUser+=1
                    
                    print("Updated Like: \(like) NumberOfUser: \(numberOfUser) challenge id: \(challengeId)")
                    
//                    Update Data
                    document.reference.updateData([
                        "Like":like,
                        "NumberOfUser":numberOfUser])
                }
            }
        }
    }
}
//
//struct ChallengeSumbitPage2_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeSumbitPage2()
//    }
//}
