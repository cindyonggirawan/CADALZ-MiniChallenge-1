//
//  submitPageExperimental.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 24/04/23.
//

import SwiftUI
import PhotosUI

struct submitPageExperimental: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    
    var body: some View {
        VStack {
            if let data = data, let uiimage = UIImage(data: data) {
                Image(uiImage: uiimage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            
            Spacer()
            
            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 1,
                matching: .images
            ) {
                Text("Pick Photo")
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
    }
}

struct submitPageExperimental_Previews: PreviewProvider {
    static var previews: some View {
        submitPageExperimental()
    }
}
