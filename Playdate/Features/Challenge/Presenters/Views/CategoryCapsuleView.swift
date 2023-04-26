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
                
//                if self.isClicked {
//                    self.challengeViewModel.capsuleIsClickedOnce = true
//                }
                
                if self.isClicked {

                    if !self.challengeViewModel.capsuleIsClickedOnce { self.challengeViewModel.filteredChallenges.removeAll() }
                    
                    for challenge in challengeViewModel.challenges {
                        let challengeCategory: String = challenge.category ?? "No Category Name"
                        if self.category == challengeCategory {
                            
                            print(challengeCategory)
                            self.challengeViewModel.filteredChallenges.append(challenge)
                        }
                    }
                    
                    self.challengeViewModel.filteredChallenges = self.challengeViewModel.filteredChallenges.shuffled()
                    self.challengeViewModel.capsuleIsClickedOnce = true
                } else {
                    if self.challengeViewModel.filteredChallenges.count == 0 {
                        print("masuk")
                        self.challengeViewModel.filteredChallenges = self.challengeViewModel.challenges.shuffled()
                    }
                    for challenge in challengeViewModel.filteredChallenges {
                        let challengeCategory: String = challenge.category ?? "No Category Name"
                        if self.category == challengeCategory {
                            if let index = challengeViewModel.filteredChallenges.firstIndex(of: challenge) {
                                challengeViewModel.filteredChallenges.remove(at: index)
                            }
                        }
                    }
                }
            }
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
            case "wellbeing": // nanti ini dihapus aja
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
            case "wellbeing": // nanti ini dihapus aja
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
