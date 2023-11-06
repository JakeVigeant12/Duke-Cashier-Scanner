//
//  Screen4AskScanBarcode.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen4AskScanBarcode: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bag: Bag

    @State private var name = "Martha Davidson"
    @State private var duid = "654321"
    @State private var phone = "919-812-1234"
    @State private var email = "Martha.Davidson@duke.edu"
    @State private var department = "Duke Stores"
    @State private var retailLocation = "University Store"
    @State private var POSName = "7200 - Reg - 13"
    @State private var revenueDate = "2023.11.11"
    @State private var bagNum = 0
    
    enum ShowView{
        case ask, next, showBagNum
    }
    
    @State private var showView = ShowView.ask
    @State private var startScan = false
    
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
               }
               //can not be edited
               .disabled(true)

               .padding([.leading, .trailing], 20)
               
               HStack {
                   Text("Revenue Date")
                       .fontWeight(.medium)
                   Spacer()
                   if(showView == .next){
                       TextField("Revenue Date", text: $revenueDate)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                           .disabled(true)
                   }else{
                       TextField("Revenue Date", text: $revenueDate)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                   }
               }
               .padding([.top, .leading, .trailing], 20)
               
               if(showView == .next){
                   HStack {
                       Text("Bag Number")
                           .fontWeight(.medium)
                       Spacer()

                       Text("\(bagNum)")
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                           .foregroundColor(.blue)
                   }
                   .padding([.top, .leading, .trailing], 20)
               }

               
               
               Spacer().frame(height: 30)

               switch showView {
               case .ask:
                   Group{
                       Text("Are you sending cash deposit to University Cashiering?")
                           .font(.title2)
                           .foregroundColor(Color.blue)
                           .multilineTextAlignment(.center)

                       HStack(spacing: 40) {
  
                           
                           Button(action: {
                               withAnimation{
                                   showView = .next
                                   submit()

                               }
                           }) {
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
                                   showView = .showBagNum

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
               case .next:
                   
                   HStack(spacing: 40) {
                       Button(action: {
                           withAnimation{
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
                       
                       NavigationLink(destination: Screen5FileScan()) {
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
               case .showBagNum:
                   Group{
                       Text("Please press the button below to sacn the barcode on the deposit bag.")
                           .font(.title2)
                           .foregroundColor(Color.blue)
                           .padding(.bottom)
                           .multilineTextAlignment(.center)
                       
                       HStack {
                           Text("Bag Number")
                               .fontWeight(.medium)
                           Spacer()
                           
                           Button(action: {
                               withAnimation {
                                   startScan = true
                                   showView = .next
                               }
                           }) {
                               Text("\(bagNum)")
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                           }
                           .background(Color.blue)
                           .opacity(0.7)
                           .cornerRadius(15)
                           .frame(width: 200)
                       }
                       .padding([.top, .leading, .trailing], 20)
                   }
               }
                   

               
               Spacer()
           }
           .padding(.vertical)
        
           .navigationTitle("Date and Bag Number")
           .navigationBarTitleDisplayMode(.inline)
        
           .sheet(isPresented: $startScan) {
               BarcodeScan()
           }
       }
    func submit(){
        bag.revenueDate = revenueDate
    }
    
}

struct Screen4AskScanBarcode_Previews: PreviewProvider {
    static var previews: some View {
        Screen4AskScanBarcode()
    }
}
