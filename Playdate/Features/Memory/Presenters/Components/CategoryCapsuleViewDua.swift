//
//  CategoryCapsuleViewDua.swift
//  Playdate
//
//  Created by Daniel Bernard Sahala Simamora on 05/05/23.
//

import SwiftUI

struct CategoryCapsuleViewDua: View {
    @ObservedObject var memoryViewModel: MemoryViewModel
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
                
                if self.isClicked {
                    
                    if !self.memoryViewModel.capsuleIsClickedOnce {
                        
                        self.memoryViewModel.filteredMemories = self.memoryViewModel.memories.filter({ mem in
                            if let chl = mem.challenge {
                                return chl.category == self.category
                            } else {
                                return false
                            }
                        })
                        self.memoryViewModel.capsuleIsClickedOnce = true
                    } else {
                        let newFilteredMemories = self.memoryViewModel.memories.filter({ mem in
                            if let chl = mem.challenge {
                                
                                return chl.category == self.category
                            } else {
                                return false
                            }
                        })
                        
                        self.memoryViewModel.filteredMemories += newFilteredMemories
                    }
                    
                    // tell which capsules r clicked
                    self.memoryViewModel.clickedCapsules.append(self.category)
                    print(self.memoryViewModel.clickedCapsules)
                    print("aa", self.memoryViewModel.memories.count)

                } else {
                    
                    if self.memoryViewModel.clickedCapsules.count != 1 {
                        self.memoryViewModel.filteredMemories.removeAll { mem in
                            if let chl = mem.challenge {
                                return chl.category == self.category
                            } else {
                                return false
                            }
                        }
                    } else {
                        self.memoryViewModel.filteredMemories = self.memoryViewModel.memories
                        self.memoryViewModel.capsuleIsClickedOnce = false // return to initial state
                    }

                    // unclicked capsules
                    if let index = self.memoryViewModel.clickedCapsules.firstIndex(where: { $0 == self.category }) {
                        self.memoryViewModel.clickedCapsules.remove(at: index)
                    }
                    print("bb", self.memoryViewModel.memories.count)

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
