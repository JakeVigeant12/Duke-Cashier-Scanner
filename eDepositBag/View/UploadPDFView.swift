//
//  UploadPDFView.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/12/23.
// PDF View structure taken from https://www.youtube.com/watch?v=hxKS8mZ-alE

import SwiftUI
import PDFKit
struct UploadPDFView: UIViewRepresentable {

    let documentURL:  URL
    init(docURL:URL){
        self.documentURL = docURL
    }
    func makeUIView(context : Context) -> some UIView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayDirection = .vertical
        pdfView.document = PDFDocument(url: self.documentURL)
        pdfView.isUserInteractionEnabled = true

        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //not needed
    }

}


