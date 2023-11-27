//
//  MainMenu.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/16/23.
//

import SwiftUI

struct MainMenu: View {
    @State private var isMenuVisible = false
    @State private var isLogoTop = false
    @EnvironmentObject var bag: Bag
    

    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing: 10){
                    Text("E-Deposit Bag")
                        .font(.title)
                        .fontWeight(.medium)
                        
                    VStack(alignment: .leading, spacing: 8){
                        Label("Edit Your Info", systemImage: "person")
                            .font(.callout.bold())
                            .padding(.top, 15)
                        
                        NavigationLink(destination: TabControl(selection: Tab.person)
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
        
                        NavigationLink(destination: TabControl(selection: Tab.bag)
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
        
                        NavigationLink(destination: TabControl(selection: Tab.inbox)
                        ) {
                            Text("View Messages - \(bag.messages.count) Unresolved")
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
                
                .opacity(isMenuVisible ? 1.0 : 0.0)
                
                
                VStack(alignment: .center){ // 居中对齐
                    Image("duke_logo_white")
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .scaleEffect(1.7)

                    if(isLogoTop){
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 充满整个屏幕

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
                withAnimation(.easeInOut(duration: 1)) {
                    isLogoTop = true
                    let _ = bag.load(url: Bag.sandboxUser)
                    let _ = bag.fetchMessages()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isMenuVisible = true
                    }
                }
            }
        }

    }
}

//#Preview {
//    MainMenu()
//}
