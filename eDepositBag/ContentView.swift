//
//  ContentView.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/1/23.
//

import SwiftUI

enum Tab {
    case bag
    case person
}

// main menu
struct ContentView: View {
    @EnvironmentObject var bag: Bag

    var body: some View {
        
        NavigationView{
            VStack(spacing: 30) {
                // Header
                Spacer().frame(height: 10)
                
                NavigationLink(destination: TabControl(selection: Tab.person)
                ) {
                    Text("Edit Defalt User Information")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(Color.blue)
                .cornerRadius(15)
                .padding(.horizontal, 30.0)
                
                NavigationLink(destination: TabControl(selection: Tab.bag)
                ) {
                    Text("Create a Virtual Deposit Bag")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(Color.blue)
                .cornerRadius(15)
                .padding(.horizontal, 30.0)

                Spacer()
                
//                Button(action: {bag.load(url: Bag.sandboxUser)}
//                       , label: {
//                        Text("Login")
//                        .background(Color.blue)
//                        .cornerRadius(15)
//                        .padding(.horizontal, 30.0)
//                })
                
           

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
        ContentView()
    }
}
