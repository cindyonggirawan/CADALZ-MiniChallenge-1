////
////  reviewChellengeModal.swift
////  Playdate
////
////  Created by Louis Mayco Dillon Wijaya on 22/04/23.
////
//
//import SwiftUI
//
//
//struct reviewChellengeModal: View {
//    @State private var isReviewPresented = false
//    
//    var body: some View {
//        Button("Present!") {
//            self.isReviewPresented.toggle()
//        }
//        .fullScreenCover(isPresented: $isReviewPresented, content: ChallengeReviewPage.init)
//    }
//}
//
//struct reviewChellengeModal_Previews: PreviewProvider {
//    static var previews: some View {
//        reviewChellengeModal()
//    }
//}
//
//struct ChallengeReviewPage: View {
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        VStack {
//            Text("This is a modal view")
//            Text("Tap to dismiss")
//        }
//        .background(Color.red)
//        .edgesIgnoringSafeArea(.all)
//        .onTapGesture {
//            presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
