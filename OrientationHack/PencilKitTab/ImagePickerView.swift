//
//  ImagePickerView.swift
//  OrientationHack
//
//  Created by Iqrah Nadeem on 21/09/2022.
//

import PhotosUI
import SwiftUI

struct ImagePickerView: View {
    @State var selectedImages : [PhotosPickerItem] = []
    
    @State var data: Data?
    
    var body: some View {
        
        VStack{
            
            if let data = data, let uiimage = UIImage(data:data){
                Image(uiImage: uiimage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            
            Spacer()
            
            PhotosPicker(selection: $selectedImages,
                         maxSelectionCount: 1,
                         matching: .images){
                
                Text("Pick Photo")
                
            }
                         .onChange(of: selectedImages){
                             newValue in
                             guard let item = selectedImages.first else {
                                 return
                             }
                             item.loadTransferable(type: Data.self){result in
                                 switch result {
                                 case .success(let data):
                                     if let data = data {
                                         self.data = data
                                     }
                                     else{
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

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}
