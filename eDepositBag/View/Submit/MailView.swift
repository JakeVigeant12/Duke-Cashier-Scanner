//
//  MailView.swift
//  eDepositBag
//  Used tutorial: https://blog.egesucu.com.tr/how-to-send-mail-in-swiftui-86ae0be5d318, fitting to document emailing needs
//  Created by Jake Vigeant on 11/27/23.
//
import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    // emaill message info
    var content: String
    var to: String
    var subject: String
    var pdfURL: URL
//    var pdfURL: String
    // binding from parent to dismiss
    @Binding var isShowing: Bool

    // setups the actual message
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        guard MFMailComposeViewController.canSendMail() else {
                print("Simulator Cannot send Mail")
                return MFMailComposeViewController()
            }

            let viewController = MFMailComposeViewController()
            viewController.setToRecipients([to])
            viewController.setSubject(subject)
            viewController.setMessageBody(content, isHTML: false)
            viewController.mailComposeDelegate = context.coordinator
        do {
            // Read PDF data from the file
            let pdfData = try Data(contentsOf: pdfURL)

            // Attach the PDF data to the email
            viewController.addAttachmentData(pdfData, mimeType: "application/pdf", fileName: "YourFileName.pdf")
        } catch {
            print("Error attaching PDF: \(error.localizedDescription)")
        }

            return viewController

    }


    // not needed
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
    }

    // connects to coordinator for dismisal
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // handles actions after sending the email
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView

        init(_ parent: MailView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
        }
    }
}
