//
//  PDFCreator.swift
//  eDepositBag
//
//  Created by Evan on 11/14/23.
//

import Foundation
import UIKit
import PDFKit

// create a pdf file
class PDFCreator {
    // file path (in temporaryDirectory)
    static let savePath = FileManager.default.temporaryDirectory.appendingPathComponent("TempPDF.pdf")

    static func createPDF(from imageTypeList: ImageTypeList, info bag: Bag) {
        let pageSize = CGRect(x: 0, y: 0, width: 8.27 * 72.0, height: 11.69 * 72.0) // A4 size
        let renderer = UIGraphicsPDFRenderer(bounds: pageSize)
 
        let data = renderer.pdfData { context in
            // begin
            context.beginPage()
            
            // handle the info that what type of images are included
            var docIncluded : [String] = []
            for type in imageTypeList.imageTypes{
                docIncluded.append(type.images.isEmpty ? "No" : "Yes")
            }
            
            // draw the title page
            PDFCreator.drawTitlePage(types: docIncluded, info: bag, in: context, pageSize: pageSize.size)
            
            for imageType in imageTypeList.imageTypes {
                if !imageType.images.isEmpty {
                    // add a title page with the name of the image type
                    context.beginPage()
                    drawSubTitlePage(in: context, title: imageType.name, pageSize: pageSize.size)

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

    // draw the title page
    private static func drawTitlePage(types typeIncluded: [String], info bag: Bag, in context: UIGraphicsPDFRendererContext, pageSize: CGSize) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left

        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), // increased font size
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        let contentAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        // get the date of today and format it
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        
        // define the content to be placed on the title page
        let titleData: [(title: String, content: String, isSubtitle: Bool)] = [
            // subtitle
            ("Bag Information", "", false),
            // contents
            ("Department", bag.department, false),
            ("Retail Location", bag.retailLocation, false),
            ("POS Name", bag.POSName, false),
            ("Revenue Date", bag.revenueDate, false),
            ("Deposit Bag #", bag.bagNum, false),
            ("Submitted by", bag.cashier?.name ?? "", false),
            ("Date Submitted", dateString, false),
            // space before subtitle
            ("", "", true),
            // subtitle
            ("Includes Scanned Documents", "", false),
            // contents
            ("IRIs", typeIncluded[0], false),
            ("House Charge", typeIncluded[1], false),
            ("Settlement Reports", typeIncluded[2], false),
            ("CARS", typeIncluded[3], false),
            ("Other", typeIncluded[4], false)
        ]

        let leftColumnWidth = pageSize.width / 2
        var yOffset: CGFloat = 72.0 // start 1 inch from the top of the page

        for (title, content, isSubtitle) in titleData {
            let titleString = NSAttributedString(string: title, attributes: titleAttributes)
            let contentString = NSAttributedString(string: content, attributes: contentAttributes)

            let titleSize = titleString.size()
            let contentSize = contentString.size()

            // check if it's a space before subtitle
            if isSubtitle {
                yOffset += titleSize.height // add space before the subtitle
            }

            let titleRect = CGRect(x: 72, y: yOffset, width: leftColumnWidth - 72, height: titleSize.height)
            titleString.draw(in: titleRect)

            if !isSubtitle {
                let contentRect = CGRect(x: leftColumnWidth, y: yOffset, width: leftColumnWidth - 72, height: contentSize.height)
                contentString.draw(in: contentRect)
            }

            // increase yOffset for the next row, adding extra space if it is a subtitle
            yOffset += max(titleSize.height, contentSize.height) + (title.isEmpty ? 20 : 10)
        }
    }

    // draw the subtitle page
    private static func drawSubTitlePage(in context: UIGraphicsPDFRendererContext, title: String, pageSize: CGSize) {
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

    // draw the image page
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
