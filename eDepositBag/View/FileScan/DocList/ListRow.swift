//
//  DocList.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/12/23.
//

import SwiftUI

struct ListRow: View {
    @Binding var images: [String]
    @State private var showImage = false
    @State private var selectedImage: Int?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(images.indices, id: \.self) {index in
                    Button(action: {
                        withAnimation {
                            selectedImage = index
                            showImage = true
                        }
                    }) {
                        Image(systemName: images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .opacity(0.7)
                    .cornerRadius(15)
                    .frame(width: 200)
                }
            }
        }
        .frame(height: 130)
        .sheet(isPresented: $showImage) {
            ImageView(selectedImage: $selectedImage, images: $images)
        }
    }
}


struct ListRow_Previews: PreviewProvider {
    @State static var sampleImages = ["person","phone"]

    static var previews: some View {
        ListRow(images: $sampleImages)
    }
}
