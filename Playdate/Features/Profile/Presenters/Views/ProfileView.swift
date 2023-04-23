//
//  ProfileView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 23/04/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Alfine")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 25)
            
            VStack(alignment: .leading) {
                Text("You have completed")
                    .font(.title)
                
                HStack(alignment: .bottom) {
                    Text("25")
                        .font(.custom("Poppins", size: 100))
                        .fontWeight(.bold)
                    Text("challenges")
                        .font(.body)
                        .offset(x: 0, y: -35)
                }
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            .background(Color.primaryPurple)
            .foregroundColor(Color.primaryWhite)
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
