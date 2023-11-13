//
//  ImageView.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/13/23.
//

import SwiftUI

struct ImageView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: Int?
    @Binding var images: [String]
    // for image scaling
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let index = selectedImage, images.indices.contains(index) {
                Image(systemName: images[index])
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)  // apply the scaling factor
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            self.scale = value  // update the scaling ratio
                        }
                    )
            } else {
                Text("Image not found")
            }

            VStack{
                Spacer()
                    .frame(height: 720)
                HStack(spacing: 60) {
                    // delete
                    Button(action: deleteImage) {
                        Text("Delete")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.red)
                    .opacity(0.8)
                    .cornerRadius(15)
                    .padding()
                    Spacer()
                    
                    // dismiss
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.green)
                    .opacity(0.8)
                    .cornerRadius(15)
                    .padding()
                }
                
            }

        }
    }

    func deleteImage() {
        if let index = selectedImage {
            images.remove(at: index)
            selectedImage = nil
        }
        presentationMode.wrappedValue.dismiss()
    }
}


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(selectedImage: .constant(2), images: .constant(["square.and.arrow.up", "pencil", "trash"]))
    }
}
