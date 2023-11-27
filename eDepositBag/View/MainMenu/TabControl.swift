//
//  TabControl.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/14/23.
//

import SwiftUI

enum Tab {
    case bag
    case person
    case inbox
}

struct TabControl: View {
    
    // create and load the data model
    @StateObject var bag = Bag()
    @StateObject var imageTypeList = ImageTypeList()
    
    @State var selection: Tab
    
    var body: some View {
        TabView(selection: $selection){
            MessageInbox()
                .environmentObject(bag)
                .tabItem {
                    Label("Inbox", systemImage: "message")
                }
                .tag(Tab.inbox)
            
            Screen2ProfileEdit()
                .environmentObject(bag)
                .environmentObject(imageTypeList)
                .tabItem {
                    Label("User", systemImage: "person")
                }
                .tag(Tab.person)

            Screen3BagInfoEdit()
            
                .environmentObject(bag)
                .environmentObject(imageTypeList)
                .tabItem {
                    Label("Bag", systemImage: "doc")
                }
                .tag(Tab.bag)
            
            
        }
        .environment(\.colorScheme, .dark)
        .accentColor(.white)
        .navigationBarBackButtonHidden(true)
 
        .onAppear(){
            
//            UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.3)
            // Parse
            let _ = bag.parseOptions(url: Bag.selectionOptions!)
            let _ = bag.load(url: Bag.sandboxUser)
            let _ = bag.fetchMessages()

        }
    }//body

}

struct TabControl_Previews: PreviewProvider {
    static var previews: some View {
        TabControl(selection: Tab.bag)
    }
}
