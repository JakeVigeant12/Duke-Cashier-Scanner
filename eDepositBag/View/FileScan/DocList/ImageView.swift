//
//  ImageView.swift
//  eDepositBag
//
//  Created by Evan on 11/13/23.
//

import SwiftUI

// full screen image view
struct ImageView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: Int?
    @Binding var images: [UIImage]
    // for image scaling
    @State private var scale: CGFloat = 1.0
    @State private var select = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // image view, able to slide
            TabView(selection: $select) {
                ForEach(images.indices, id: \.self) { index in
                    Image(uiImage: images[index])
                        .resizable()
                        .scaledToFit()
                        .tag(index)  // set tags to indicate current image
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .onAppear(){
                select = selectedImage!
            }
            
            VStack {
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
        images.remove(at: select)
        // deleted the last image
        if images.count == select{
            // set as the former one
            if images.count != 0 {
                select -= 1
            }else{
                presentationMode.wrappedValue.dismiss()
            }
        }// else select remains the same

    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(selectedImage: .constant(1), images: .constant([UIImage(named: "test_image")!, UIImage(named: "test_image")!]))
    }
}
