//
//  reviewChellengeModal.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 22/04/23.
//

import SwiftUI


struct reviewPageExperimental: View {
    @State private var isReviewPresented = false
    
    var body: some View {
        Button("Present!") {
            self.isReviewPresented.toggle()
        }
        .fullScreenCover(isPresented: $isReviewPresented, content: ChallangeReviewModal.init)
    }
}

struct reviewPageExperimental_Previews: PreviewProvider {
    static var previews: some View {
        reviewPageExperimental()
    }
}
