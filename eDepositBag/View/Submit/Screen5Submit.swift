//
//  Screen6Submit.swift
//  eDepositBag
//
//  Created by Evan on 11/2/23.
//

import SwiftUI

struct Screen5Submit: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bag: Bag
    @EnvironmentObject var imageTypeList: ImageTypeList
    @EnvironmentObject var tabModel: TabModel
    @State private var sendEmail = false
    
    @State private var isPresentedPDF = false
    @State private var showView = ShowView.preview
    @State private var today: String = ""
    
    // view tags
    enum ShowView{
        case preview, submit
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // list all the info with textfields
                Group{
                    HStack {
                        Text("Department")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("Department", text: $bag.department)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("Retail Location")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("Retail Location", text: $bag.retailLocation)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("POS Name")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("POS Name", text: $bag.POSName)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("Revenue Date")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("Revenue Date", text: $bag.revenueDate)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("Bag Number")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("Bag Number", text: $bag.bagNum)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("Submitted by")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("Name", text: $tabModel.userName)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("Date Submitted")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("today", text: $today)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                }
                .foregroundStyle(.white)
                .disabled(true)
                .font(.body)
                .padding([.leading, .trailing], 20)

                Spacer().frame(height: 0)
                
                // included document type list
                VStack{
                    Text("Includes Scanned Documents")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                    Spacer()
                    HStack {
                        Text("IRIs")
                            .fontWeight(.medium)
                        Spacer()
                        Text(imageTypeList.imageTypes[0].images.count != 0 ? "Yes" : "No")
                            .frame(width: 120)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                    }
                    HStack {
                        Text("House Charge")
                            .fontWeight(.medium)
                        Spacer()
                        Text(imageTypeList.imageTypes[1].images.count != 0 ? "Yes" : "No")
                            .frame(width: 120)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                    }
                    HStack {
                        Text("Settlement Reports")
                            .fontWeight(.medium)
                        Spacer()
                        Text(imageTypeList.imageTypes[2].images.count != 0 ? "Yes" : "No")
                            .frame(width: 120)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                    }
                    HStack {
                        Text("CARS")
                            .fontWeight(.medium)
                        Spacer()
                        Text(imageTypeList.imageTypes[3].images.count != 0 ? "Yes" : "No")
                            .frame(width: 120)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                    }
                    HStack {
                        Text("Other")
                            .fontWeight(.medium)
                        Spacer()
                        Text(imageTypeList.imageTypes[4].images.count != 0 ? "Yes" : "No")
                            .frame(width: 120)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                    }
                }
                .foregroundStyle(.white)
                .padding(20)
                
                .background {
                    TransparentBlur(removeAllFilters: false)
                        .blur(radius: 9, opaque: true)
                        .background(.white.opacity(0.05))
                }
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 10)
                .padding(.horizontal, 20)

                Spacer()

                // buttons
                switch showView {
                case .preview:
                    HStack(spacing: 40){
                        Button(action: {
                            withAnimation(){
                                showView = .submit
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
                            // create pdf
                            PDFCreator.createPDF(from: imageTypeList, info: bag)
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
                    .shadow(color: .black.opacity(0.2), radius: 10)
                    
                    .sheet(isPresented: $isPresentedPDF) {
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
                            sendEmail = true
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
                    .shadow(color: .black.opacity(0.2), radius: 10)
                    .padding(.horizontal, 50.0)
                }
                Spacer()
       
            .padding(.vertical)
        }
        
        }
        
        // create a email
        .sheet(isPresented: $sendEmail) {
            MailView(
                content:"",
                to: "afobags@duke.edu",
                subject: "\(bag.cashier!.duid) - \(bag.retailLocation)",
                pdfURL: PDFCreator.savePath,
                isShowing: $sendEmail

            )
        }

        .background {
            Image("bg1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.1))
            TransparentBlur(removeAllFilters: false)
        }
        
        .navigationTitle("Save & Preview")
        .navigationBarTitleDisplayMode(.large)
        
        .onAppear(){
            // get the date of today
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            today = dateFormatter.string(from: Date())
        }
    }
    
}


struct Screen5Submit_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var bag = Bag()
    static var tableModel = TabModel()
    static var previews: some View {
        Screen5Submit()
            .environmentObject(bag)
            .environmentObject(imageTypeList)
            .environmentObject(tableModel)
    }
}
