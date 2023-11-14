//
//  Screen6Submit.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen6Submit: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bag: Bag
    @EnvironmentObject var imageTypeList: ImageTypeList
    
    @State private var bagNum: String = ""
    @State private var name: String = ""
    @State private var duid: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var department: String = ""
    @State private var retailLocation: String = ""
    @State private var POSName: String = ""
    @State private var revenueDate: String = ""
    
    @State private var isPresentedPDF = false
    @State private var showView = ShowView.preview
    
    enum ShowView{
        case preview, submit
    }


    
    var body: some View {
        VStack(spacing: 20) {
            Group{
                HStack {
                    Text("Department")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("Department", text: $department)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("Retail Location")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("Retail Location", text: $retailLocation)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("POS Name")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("POS Name", text: $POSName)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("Revenue Date")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("Revenue Date", text: $revenueDate)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("Bag Number")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("Bag Number", text: $bagNum)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("Submitted by")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("Name", text: $name)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("Date Submitted")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("today", text: $revenueDate)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
            }
            .disabled(true)
            .font(.body)
            .padding([.leading, .trailing], 20)

            Spacer().frame(height: 0)

            Text("Includes Scanned Documents")
            Group{
                HStack {
                    Text("IRIs")
                        .fontWeight(.medium)
                    Spacer()
                    Text(imageTypeList.imageTypes[0].images.count != 0 ? "Yes" : "No")
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("House Charge")
                        .fontWeight(.medium)
                    Spacer()
                    Text(imageTypeList.imageTypes[1].images.count != 0 ? "Yes" : "No")
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("Settlement Reports")
                        .fontWeight(.medium)
                    Spacer()
                    Text(imageTypeList.imageTypes[2].images.count != 0 ? "Yes" : "No")
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("CARS")
                        .fontWeight(.medium)
                    Spacer()
                    Text(imageTypeList.imageTypes[3].images.count != 0 ? "Yes" : "No")
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("Other")
                        .fontWeight(.medium)
                    Spacer()
                    Text(imageTypeList.imageTypes[4].images.count != 0 ? "Yes" : "No")
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
            }
            .padding([.leading, .trailing], 20)

            Spacer().frame(height: 0)

            switch showView {
            case .preview:
                HStack(spacing: 40){
                    Button(action: {
                        withAnimation(){
                            showView = .submit
                        }
                        // TODO: some action. here just delete the temp pdf

                        let pdfURL = FileManager.default.temporaryDirectory.appendingPathComponent("TempPDF.pdf")

                        do {
                            if FileManager.default.fileExists(atPath: pdfURL.path) {
                                try FileManager.default.removeItem(at: pdfURL)
                                print("PDF file deleted successfully.")
                            } else {
                                print("PDF file does not exist.")
                            }
                        } catch {
                            print("An error occurred while trying to delete the PDF file: \(error)")
                        }
                        
                        
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.green)
                    .opacity(0.8)
                    .cornerRadius(15)

                    Button(action: {
                        // TODO: create pdf
                        PDFCreator.createPDF(from: imageTypeList)
                        
                        

                        isPresentedPDF.toggle()
                    }) {
                        Text("Preview")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.orange)
                    .opacity(0.8)
                    .cornerRadius(15)
                }
                .sheet(isPresented: $isPresentedPDF) {
//                                        UploadPDFView(docURL: Bag.testURL!)
                    UploadPDFView(docURL: FileManager.default.temporaryDirectory.appendingPathComponent("TempPDF.pdf"))
                            }
                .padding(.horizontal, 50.0)
            case .submit:
                HStack(spacing: 40){
                    Button(action: {
                        withAnimation(){
                            showView = .preview
                        }
                    }) {
                        Text("Cancel")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.red)
                    .opacity(0.8)
                    .cornerRadius(15)

                    Button(action: {
                        // do somthing
                    }) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.green)
                    .opacity(0.8)
                    .cornerRadius(15)
                }
                .padding(.horizontal, 50.0)
            }



            Spacer()
   }
        .padding(.vertical)
        .navigationTitle("Save & Preview")
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear(){
            if let cashier = bag.cashier {
                name = cashier.name
                duid = cashier.duid
                phone = cashier.phone
                email = cashier.email
            }
            department = bag.department
            retailLocation = bag.retailLocation
            POSName = bag.POSName
            revenueDate = bag.revenueDate
            bagNum = bag.bagNum == 0 ? "No Bag Number" : String(bag.bagNum)

        }
    }
    
}


struct Screen6Submit_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var bag = Bag()
    static var previews: some View {
        Screen6Submit()
            .environmentObject(bag)
            .environmentObject(imageTypeList)
    }
}
