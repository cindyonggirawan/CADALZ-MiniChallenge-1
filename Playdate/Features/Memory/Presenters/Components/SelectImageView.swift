//
//  SelectCircle.swift
//  Playdate
//
//  Created by Daniel Bernard Sahala Simamora on 05/05/23.
//

import SwiftUI

struct SelectCircle: View {
    @Binding var circleIsClicked: Bool
    @State var isClicked: Bool = false
    
    var body: some View {
        Group {
            Circle()
                .fill(.white)
                .frame(width: 24, height: 24)
                .opacity(0.5)
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: 2)
                )
                .overlay(
                    self.getPurpleCircle(isClicked)
                )
                .padding(.leading, 80)
                .padding(.bottom, 80)
        }
    }
    
    func getPurpleCircle(_ isClicked: Bool) -> AnyView {
        if isClicked {
            return AnyView(
                ZStack {
                    Circle()
                        .fill(Color.primaryPurple)
                        .overlay(
                            Circle()
                                .stroke(.white, lineWidth: 2)
                        )
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                }
            )
        } else {
            return AnyView(EmptyView())
        }
    }
}
