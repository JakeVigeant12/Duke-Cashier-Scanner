//
//  Screen2ProfileEdit.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen2ProfileEdit: View {
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
                       Text("Name")
                           .fontWeight(.medium)
                       Spacer()
                       TextField("Name", text: $name)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                   }
                   HStack {
                       Text("DUID")
                           .fontWeight(.medium)
                       Spacer()
                       TextField("DUID", text: $duid)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                   }
                   HStack {
                       Text("Phone")
                           .fontWeight(.medium)
                       Spacer()
                       TextField("Phone", text: $phone)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                   }
                   HStack {
                       Text("Email")
                           .fontWeight(.medium)
                       Spacer()
                       TextField("Email", text: $email)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                   }
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
               
               Spacer().frame(height: 40)

               Button(action: {
                   presentationMode.wrappedValue.dismiss()
               }) {
                   Text("Save")
                       .foregroundColor(.white)
                       .frame(maxWidth: .infinity)
                       .padding()
               }
               .background(Color.blue)
               .opacity(0.9)
               .cornerRadius(15)
               .padding(.horizontal, 70.0)
               
               Spacer()
           }
           .padding(.vertical)
           .navigationTitle("User Profile")
           .navigationBarTitleDisplayMode(.inline)
       }
}

struct Screen2ProfileEdit_Previews: PreviewProvider {
    static var previews: some View {
        Screen2ProfileEdit()
    }
}
