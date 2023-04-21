//
//  CategoryCapsuleView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct CategoryCapsuleView: View {
    var body: some View {
        Text("Entertaiment")
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundColor(Color(red: 190/255, green: 190/255, blue: 190/255))
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color(red: 249/255, green: 249/255, blue: 249/255))
//            .background(.black)
            .cornerRadius(24)
    }
}

struct CategoryCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCapsuleView()
    }
}
