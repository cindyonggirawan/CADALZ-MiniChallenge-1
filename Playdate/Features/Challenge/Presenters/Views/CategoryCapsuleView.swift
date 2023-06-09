//
//  CategoryCapsuleView.swift
//  Playdate
//
//  Created by Alfine on 21/04/23.
//

import SwiftUI

struct CategoryCapsuleView: View {
    @ObservedObject var challengeViewModel: ChallengeViewModel
    var category: String
    @Binding var displayedChallenges: [Int]
    @Binding var lastDisplayIndex: Int
    
    @State var isClicked: Bool = false
    
    var body: some View {
        Text(category)
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundColor(isClicked ? self.getForegroundColor(category) : self.getForegroundColor("notClicked"))
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(isClicked ? self.getBackgroundColor(category) : self.getBackgroundColor("notClicked"))
            .cornerRadius(24)
            .onTapGesture {
                self.isClicked.toggle()
                
                
                if self.isClicked {
                    
                    if !self.challengeViewModel.capsuleIsClickedOnce {
                        
                        self.challengeViewModel.filteredChallenges = self.challengeViewModel.filteredChallenges.filter({ chl in
                            return chl.category! == self.category
                        })
                        self.challengeViewModel.capsuleIsClickedOnce = true
                    } else {
                        let newFilteredChlgs = self.challengeViewModel.challenges.filter({ chl in
                            return chl.category! == self.category
                        })
                        
                        self.challengeViewModel.filteredChallenges += newFilteredChlgs
                        self.challengeViewModel.filteredChallenges = self.challengeViewModel.filteredChallenges.shuffled()
                    }
                    
                    self.restartCardIndices()
                    
                    // tell which capsules r clicked
                    self.challengeViewModel.clickedCapsules.append(self.category)
                } else {
                    
                    if self.challengeViewModel.clickedCapsules.count != 1 {
                        self.challengeViewModel.filteredChallenges.removeAll { chl in
                            return chl.category! == self.category
                        }
                    } else {
                        self.challengeViewModel.filteredChallenges = self.challengeViewModel.challenges.shuffled()
                        self.challengeViewModel.capsuleIsClickedOnce = false // return to initial state
                    }
                    
                    self.restartCardIndices()

                    // unclicked capsules
                    if let index = self.challengeViewModel.clickedCapsules.firstIndex(where: { $0 == self.category }) {
                        self.challengeViewModel.clickedCapsules.remove(at: index)
                    }
                }
            }
    }
    
    func restartCardIndices() -> () {
        // restart cards' indices
        self.challengeViewModel.displayedChallenges =  [0, 1, 2, 3, 4]
        self.challengeViewModel.lastDisplayIndex = 4
    }
    
    func getForegroundColor(_ category: String) -> Color {
        let categoryTemp = category.lowercased()
        
        switch categoryTemp {
            case "food":
                return Color(red: 210/255, green: 16/255, blue: 16/255)
            case "entertainment":
                return Color(red: 142/255, green: 90/255, blue: 255/255)
            case "travel":
                return Color(red: 243/255, green: 146/255, blue: 0/255)
            case "well-being":
                return Color(red: 106/255, green: 184/255, blue: 29/255)
            default:
                return Color(red: 151/255, green: 151/255, blue: 151/255)
        }
    }
    
    func getBackgroundColor(_ category: String) -> Color {
        let categoryTemp = category.lowercased()
        
        switch categoryTemp {
            case "food":
                return Color(red: 255/255, green: 238/255, blue: 238/255)
            case "entertainment":
                return Color(red: 242/255, green: 233/255, blue: 255/255)
            case "travel":
                return Color(red: 255/255, green: 243/255, blue: 224/255)
            case "well-being":
                return Color(red: 241/255, green: 255/255, blue: 226/255)
            default:
                return Color(red: 249/255, green: 249/255, blue: 249/255)
        }
    }
    
    
    
    
    
    
}



//struct CategoryCapsuleView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryCapsuleView()
//    }
//}
