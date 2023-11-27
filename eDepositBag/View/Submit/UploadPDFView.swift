//
//  UploadPDFView.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/12/23.
// PDF View structure taken from https://www.youtube.com/watch?v=hxKS8mZ-alE
import MessageUI
import SwiftUI
import PDFKit

struct UploadPDFView: View {
    @Environment(\.presentationMode) var presentationMode // Used for dismissing the view
    let docURL: URL

    var body: some View {
        ZStack(alignment: .top) {
            tempPDFView(docURL: docURL)
            
            VStack(alignment: .center) {
                    
                Spacer()
                    .frame(height: 725)
                // dismiss button at bottom
                HStack{
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background(Color.green)
                    .opacity(0.7)
                    .cornerRadius(15)
                    .padding()
                    Spacer()
                        .frame(width: 9)
                }

            }
        }
    }
        
}

struct tempPDFView: UIViewRepresentable {

    let docURL:  URL
    init(docURL:URL){
        self.docURL = docURL
    }
    func makeUIView(context : Context) -> some UIView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayDirection = .vertical
        pdfView.document = PDFDocument(url: self.docURL)
        pdfView.isUserInteractionEnabled = true

        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //not needed
    }

}


struct UploadPDFView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "test_pdf", withExtension: "pdf") {
            UploadPDFView(docURL: url)
        } else {
            Text("PDF file not found.")
        }
    }
}
