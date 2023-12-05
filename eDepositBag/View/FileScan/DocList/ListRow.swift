//
//  DocList.swift
//  eDepositBag
//
//  Created by Evan on 11/12/23.
//

import SwiftUI

// a row of the image list
struct ListRow: View {
    @ObservedObject var imageType: ImageType
    @State private var showImage = false
    @State private var selectedImage: Int?
    
    var body: some View {
        if !imageType.images.isEmpty{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    // image list
                    ForEach(imageType.images.indices, id: \.self) {index in
                        // every image is a button, click for full screen view
                        Button(action: {
                            withAnimation {
                                selectedImage = index
                                showImage = true
                            }
                        }) {
                            Image(uiImage: imageType.images[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .padding(.trailing, 10)
                        }
                    }
                }
            }
            // show the image in full screen 
            .sheet(isPresented: $showImage) {
                ImageView(selectedImage: $selectedImage, images: $imageType.images)
            }
        }
    }
}


struct ListRow_Previews: PreviewProvider {
    @State static var imageType = ImageType(name: "haha", images: [UIImage(named: "test_image")!,UIImage(named: "test_image")!])

    static var previews: some View {
        ListRow(imageType: imageType)
    }
}
