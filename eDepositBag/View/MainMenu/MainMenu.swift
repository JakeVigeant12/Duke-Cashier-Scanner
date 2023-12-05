//
//  MainMenu.swift
//  eDepositBag
//
//  Created by Evan on 11/16/23.
//

import SwiftUI

// the start menu, and load the data from sanbox
struct MainMenu: View {
    @State private var isMenuVisible = false
    @State private var isLogoTop = false
    @EnvironmentObject var bag: Bag
    
    var body: some View {
        NavigationView {
            ZStack{
                // menu
                VStack(spacing: 10){
                    Text("E-Deposit Bag")
                        .font(.title)
                        .fontWeight(.medium)
                        
                    VStack(alignment: .leading, spacing: 8){
                        Label("Edit Your Info", systemImage: "person")
                            .font(.callout.bold())
                            .padding(.top, 15)
                        
                        // user info button
                        NavigationLink(destination: TabControl(selection: TabViewTag.person)
                            .environmentObject(bag)
                        ) {
                            Text("User Information")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                        
                        Label("Create A Bag", systemImage: "doc")
                            .font(.callout.bold())
                            .padding(.top, 15)
                        
                        // bag info button
                        NavigationLink(destination: TabControl(selection: TabViewTag.bag)
                            .environmentObject(bag)
                        ) {
                            Text("Virtual Deposit Bag")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.vertical, 12)
                            
                                .frame(maxWidth: .infinity)
                                .background(.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                        Label("Messages", systemImage: "message")
                            .font(.callout.bold())
                            .padding(.top, 15)
        
                        // message button
                        NavigationLink(destination: TabControl(selection: TabViewTag.inbox)
                        ) {
                            Text("View Messages\n\(bag.messages.count) Unresolved")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.vertical, 12)
                            
                                .frame(maxWidth: .infinity)
                                .background(.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                    }
                    .padding(.bottom, 15)
                }
                .foregroundStyle(.white)
                .padding(.horizontal,30)
                .padding(.top, 35)
                .padding(.bottom, 25)
                
                .background {
                    TransparentBlur(removeAllFilters: false)
                        .blur(radius: 9, opaque: true)
                        .background(.white.opacity(0.05))
                }
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(.white.opacity(0.5), lineWidth: 2)
                }
                .shadow(color: .black.opacity(0.2), radius: 10)
                .padding(.horizontal, 40)
                
                // animation
                .opacity(isMenuVisible ? 1.0 : 0.0)
                
                // duke logo
                VStack(alignment: .center){
                    Image("duke_logo_white")
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .scaleEffect(1.7)
                    if(isLogoTop){
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .frame(maxWidth: 390)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .background {
                Image("bg1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            .onAppear {
                // animation
                withAnimation(.easeInOut(duration: 1)) {
                    isLogoTop = true
                }
                
                // delay animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isMenuVisible = true
                    }
                }
                
                // load data
                let _ = bag.parseOptions(url: Bag.selectionOptions!)
                let _ = bag.load(url: Bag.sandboxUser)
                let _ = bag.fetchMessages()
            }
        }

    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        let bag = Bag()
        MainMenu()
            .environmentObject(bag)
    }
}
