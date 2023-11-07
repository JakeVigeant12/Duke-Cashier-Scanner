//
//  ContentView.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/1/23.
//

import SwiftUI

// main menu
struct ContentView: View {
    @EnvironmentObject var bag: Bag
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 30) {
                // Header
                Spacer().frame(height: 10)
                
                // Buttons
                NavigationLink(destination: Screen2ProfileEdit(bag: bag)
                ) {
                    Text((bag.cashier != nil) ? "Edit Profile" : "Create Profile" )
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(Color.blue)
                .cornerRadius(15)
                .padding(.horizontal, 30.0)
                if (bag.cashier != nil){
                    NavigationLink(destination: Screen3BagInfoEdit(bag: bag))
                    {
                        Text("Submit Virtual Deposit Bags")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding(.horizontal, 30.0)
                }
                //TODO add functionality to logout/set cashier to nil
                Button(action: {if bag.cashier != nil {
                    bag.logout()
                    return
                }
                    
                    let _ = bag.load(url: Bag.sandboxUser)}) {
                        Text((bag.cashier != nil) ? "Logout" : "Login")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding(.horizontal, 30.0)
                
                Spacer()
            }
            .padding(.vertical)
            .navigationTitle("Virtual Deposit Bags")
            
            .toolbar {
                ToolbarItem(placement: .principal) {  // principal means bisides the title
                    HStack {
                        Text("Duke")
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.blue.opacity(14))
                        Spacer()
                    }
                }
            }
        }//navigation
        
    }//body
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let bag = Bag()
        
        ContentView()
            .environmentObject(bag)
    }
}
