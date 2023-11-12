//
//  Screen6Submit.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen6Submit: View {
    @Environment(\.presentationMode) var presentationMode
    private var bag: Bag
    @State private var bagNum:String
    @State private var name:String
    @State private var duid:String
    @State private var phone:String
    @State private var email:String
    @State private var department:String
    @State private var retailLocation: String
    @State private var POSName: String
    @State private var revenueDate: String
    @State private var fileType:String
    
    init(bag: Bag) {
        self.bag = bag
        _name = State(initialValue: bag.cashier?.name ?? "")
        _duid = State(initialValue: bag.cashier?.duid ?? "")
        _phone = State(initialValue: bag.cashier?.phone ?? "")
        _email = State(initialValue: bag.cashier?.email ?? "")
        _department = State(initialValue: bag.department)
        _retailLocation = State(initialValue: bag.retailLocation)
        _POSName = State(initialValue: bag.POSName)
        _revenueDate = State(initialValue: bag.revenueDate)
        _bagNum = State(initialValue: String(bag.bagNum))
        _fileType = State(initialValue: "hahaha")
    }
        enum ShowView{
            case preview, submit
        }
    
        @State private var showView = ShowView.preview
    
    
    
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
                            Text(bag.imageScans["IRI"] != nil ? "Yes" : "No")
                                .multilineTextAlignment(.center)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                        }
                        HStack {
                            Text("House Charge")
                                .fontWeight(.medium)
                            Spacer()
                            Text(bag.imageScans["House Charge"] != nil ? "Yes" : "No")
                                .multilineTextAlignment(.center)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                        }
                        HStack {
                            Text("Settlement Reports")
                                .fontWeight(.medium)
                            Spacer()
                            Text(bag.imageScans["Settlement Reports"] != nil ? "Yes" : "No")
                                .multilineTextAlignment(.center)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                        }
                        HStack {
                            Text("CARS")
                                .fontWeight(.medium)
                            Spacer()
                            Text(bag.imageScans["CARS"] != nil ? "Yes" : "No")
                                .multilineTextAlignment(.center)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                        }
                        HStack {
                            Text("Other")
                                .fontWeight(.medium)
                            Spacer()
                            Text("No")
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
                                // do somthing
        
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
            }
    
}


//struct Screen6Submit_Previews: PreviewProvider {
//    static var previews: some View {
//        Screen6Submit()
//    }
//}
