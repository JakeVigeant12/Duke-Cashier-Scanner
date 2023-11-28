//
//  PDFCreator.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/14/23.
//

import Foundation
import UIKit
import PDFKit

class PDFCreator {
    static let savePath = FileManager.default.temporaryDirectory.appendingPathComponent("TempPDF.pdf")

    static func createPDF(from imageTypeList: ImageTypeList) {
        let pageSize = CGRect(x: 0, y: 0, width: 8.27 * 72.0, height: 11.69 * 72.0) // A4 size
        let renderer = UIGraphicsPDFRenderer(bounds: pageSize)

        let data = renderer.pdfData { context in
            for imageType in imageTypeList.imageTypes {
                if !imageType.images.isEmpty {
                    // add a title page with the name of the image type
                    context.beginPage()
                    drawTitlePage(in: context, title: imageType.name, pageSize: pageSize.size)

                    // add a PDF page for each UIImage
                    for image in imageType.images {
                        context.beginPage()
                        drawImagePage(in: context, image: image, pageSize: pageSize.size)
                    }
                }
            }
        }

        // save to the temporary directory
        let tempPath = PDFCreator.savePath
        try? data.write(to: tempPath)
        print("PDF saved to \(tempPath)")
    }

    private static func drawTitlePage(in context: UIGraphicsPDFRendererContext, title: String, pageSize: CGSize) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        let textSize = attributedTitle.size()
        let textRect = CGRect(x: 0, y: (pageSize.height - textSize.height) / 2, width: pageSize.width, height: textSize.height) // correctly center the title
        attributedTitle.draw(in: textRect)
    }

    private static func drawImagePage(in context: UIGraphicsPDFRendererContext, image: UIImage, pageSize: CGSize) {
        let imageSize = image.size
        let widthRatio = pageSize.width / imageSize.width
        let heightRatio = pageSize.height / imageSize.height
        let scale = min(widthRatio, heightRatio)
        let scaledImageSize = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)
        let imageRect = CGRect(x: (pageSize.width - scaledImageSize.width) / 2, y: (pageSize.height - scaledImageSize.height) / 2, width: scaledImageSize.width, height: scaledImageSize.height)
        image.draw(in: imageRect)
    }
}
