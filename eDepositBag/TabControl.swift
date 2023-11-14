//
//  TabControl.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/14/23.
//

import SwiftUI

struct TabControl: View {
    @StateObject var bag = Bag()
    @StateObject var imageTypeList = ImageTypeList()
    
    @State var selection: Tab
    
    var body: some View {
        TabView(selection: $selection){
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
        .navigationBarBackButtonHidden(true)
    }//body

}

struct TabControl_Previews: PreviewProvider {
    static var previews: some View {
        TabControl(selection: Tab.bag)
    }
}
