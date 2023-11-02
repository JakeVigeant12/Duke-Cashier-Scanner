//
//  Screen3BagInfoEdit.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen3BagInfoEdit: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = "Martha Davidson"
    @State private var duid = "654321"
    @State private var phone = "919-812-1234"
    @State private var email = "Martha.Davidson@duke.edu"
    @State private var department = "Duke Stores"
    @State private var retailLocation = "University Store"
    @State private var POSName = "7200 - Reg - 13"
    
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
               .font(.body)
               .padding([.leading, .trailing], 20)
               
               Spacer().frame(height: 30)
               
               Text("Is information correct?")
                   .font(.title2)
                   .foregroundColor(Color.blue)
                   .padding(.bottom)
               
               HStack(spacing: 40) {
                   
                   NavigationLink(destination: Screen2ProfileEdit()) {
                       Text("No")
                           .foregroundColor(.white)
                           .frame(maxWidth: .infinity)
                           .padding()
                   }
                   .background(Color.red)
                   .opacity(0.8)
                   .cornerRadius(15)
                   
                   NavigationLink(destination: Screen4AskScanBarcode()) {
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
               
               Spacer()
           }
           .padding(.vertical)
           .navigationTitle("Deposit Bag Info")
           .navigationBarTitleDisplayMode(.inline)
       }
}

struct Screen3BagInfoEdit_Previews: PreviewProvider {
    static var previews: some View {
        Screen3BagInfoEdit()
    }
}
