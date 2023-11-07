//
//  Screen5FileScan.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen5FileScan: View {
    @Environment(\.presentationMode) var presentationMode
    private var bag:Bag
    @State private var bagNum = 223
    @State private var name:String
    @State private var duid:String
    @State private var phone:String
    @State private var email:String
    @State private var department:String
    @State private var retailLocation: String
    @State private var POSName: String
    @State private var revenueDate: String
    init(bag: Bag) {
        self.bag = bag
        _name = State(initialValue: "")
        _duid = State(initialValue: "")
        _phone = State(initialValue: "")
        _email = State(initialValue: "")
        _department = State(initialValue: "")
        _retailLocation = State(initialValue: "")
        _POSName = State(initialValue: "")
        _revenueDate = State(initialValue: "")

        if let cashier = bag.cashier {
            _name = State(initialValue: cashier.name)
            _duid = State(initialValue: cashier.duid)
            _phone = State(initialValue: cashier.phone)
            _email = State(initialValue: cashier.email)
        }
        
        _department = State(initialValue: bag.department)
        _retailLocation = State(initialValue: bag.retailLocation)
        _POSName = State(initialValue: bag.POSName)
        _revenueDate = State(initialValue: bag.revenueDate)
        _bagNum = State(initialValue: bag.bagNum)


    }
    enum ShowView{
        case ask, chooseType, prepareScan
    }
    
    @State private var showView = ShowView.ask
    @State private var startScan = false
    
    @State private var fileType = "hahaha"
    
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
               }
               //can not be edited
               .disabled(true)
               .padding([.leading, .trailing], 20)
               
               Spacer().frame(height: 30)

               switch showView {
               case .ask:
                   Group{
                       Text("Do you have more documents to scan?")
                           .font(.title2)
                           .foregroundColor(Color.blue)
                           .multilineTextAlignment(.center)

                       HStack(spacing: 40) {
                           NavigationLink(destination: Screen6Submit(bag : bag)) {
                               Text("No")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.red)
                           .opacity(0.8)
                           .cornerRadius(15)
                           
                           Button(action: {
                               withAnimation{
                                   showView = .chooseType
                               }
                           }) {
                               Text("Yes")
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
               case .chooseType:
                   VStack{
                       Group{
                           Button(action: {
                               withAnimation(){
                                   fileType = "IRI"
                                   showView = .prepareScan
                               }
                           }) {
                               Text("IRI")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.blue)
                           .cornerRadius(15)
                           .padding(.horizontal, 50.0)
                           
                           Button(action: {
                               withAnimation(){
                                   fileType = "HOUSE CHARGE"
                                   showView = .prepareScan
                               }
                           }) {
                               Text("HOUSE CHARGE")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.blue)
                           .cornerRadius(15)
                           .padding(.horizontal, 50.0)
                           
                           Button(action: {
                               withAnimation(){
                                   fileType = "SETTLEMENT REPORT (Mdse Concessions ONLY)"
                                   showView = .prepareScan
                               }
                           }) {
                               Text("SETTLEMENT REPORT\n(Mdse Concessions ONLY)")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.blue)
                           .cornerRadius(15)
                           .padding(.horizontal, 50.0)
                           
                           Button(action: {
                               withAnimation(){
                                   fileType = "CARS (Duke Technology Ctr ONLY)"
                                   showView = .prepareScan
                               }
                           }) {
                               Text("CARS\n(Duke Technology Ctr ONLY)")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.blue)
                           .cornerRadius(15)
                           .padding(.horizontal, 50.0)
                           
                           Button(action: {
                               withAnimation(){
                                   fileType = "OTHER"
                                   showView = .prepareScan
                               }
                           }) {
                               Text("OTHER")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.blue)
                           .cornerRadius(15)
                           .padding(.horizontal, 50.0)
                       }
                       .opacity(0.8)
                       
                       Spacer().frame(height: 30)
                       
                       HStack(spacing: 40) {
                           Button(action: {
                               withAnimation(){
                                   showView = .ask
                               }
                           }) {
                               Text("Back")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.red)
                           .opacity(0.8)
                           .cornerRadius(15)
                           
                           NavigationLink(destination: Screen6Submit(bag:bag)) {
                               Text("Next")
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

               case .prepareScan:
                   Group{
                       Text(fileType)
                           .font(.title2)
                           .foregroundColor(Color.blue)
                           .padding(.bottom)
                           .multilineTextAlignment(.center)
                       
                       Text("Select camera to begin scanning:")
                           .foregroundColor(Color.gray)
                           .padding(.bottom)
                           .multilineTextAlignment(.center)
                       
                           Button(action: {
                               withAnimation {
                                   startScan = true
                               }
                           }) {
                               Image(systemName: "camera")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 100, height: 100)
                                   .foregroundColor(.blue)
                                   .padding()
                           }
                           .opacity(0.7)
                           .cornerRadius(15)
                           .frame(width: 200)
                       HStack(spacing: 40) {
                           Button(action: {
                               // TODO
                               
                               //do something
                           }) {
                               Text("Continue")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.blue)
                           .opacity(0.8)
                           .cornerRadius(15)
                           
                           Button(action: {
                               withAnimation(){
                                   showView = .chooseType
                               }
                           }) {
                               Text("Finish")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.blue)
                           .opacity(0.8)
                           .cornerRadius(15)
                       }
                       .padding(.horizontal, 50.0)
                   }
               }
                   

               
               Spacer()
           }
           .padding(.vertical)
        
           .navigationTitle("Scan Documents")
           .navigationBarTitleDisplayMode(.inline)
        
           .sheet(isPresented: $startScan) {
               DocScan()
           }
       }
}

struct Screen5FileScan_Previews: PreviewProvider {
    static var previews: some View {
        let bag = Bag()
        Screen5FileScan(bag:bag)
    }
}
