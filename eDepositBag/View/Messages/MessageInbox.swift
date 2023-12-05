import SwiftUI

struct MessageInbox: View {
    @EnvironmentObject var bag: Bag
    @State var delSuccess = false
    // for upadate button animation
    @State private var rotation: Double = 0
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                
                // when the message list is empty
                if bag.messages.isEmpty {
                    HStack {
                        Text("No Messages At This Time")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
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
                            .padding(.leading, 20)
                            .padding(.trailing, 15)
                        
                        // update button
                        Button(action: {
                            withAnimation(.linear(duration: 0.5)) {
                                rotation += 360
                                // fetch data
                                let _ = bag.fetchMessages()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                rotation = 0
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                                // rotation animation
                                .rotationEffect(Angle(degrees: rotation))
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.vertical,12)
                                .padding(.horizontal,14)
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
                                .padding(.trailing, 20)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    // List of messages
                    List {
                        // Refresh button
                        HStack {
                            Text("Feedback Tasks")
                                .font(.title2)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "arrow.clockwise")
                                // rotation animation
                                .rotationEffect(Angle(degrees: rotation))
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                        rotation += 360
                                        // fetch data
                                        let _ = bag.fetchMessages()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        rotation = 0
                                    }
                                }
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.vertical,10)
                                .padding(.horizontal,14)
                        }
                        .listRowBackground(                                TransparentBlur(removeAllFilters: false)
                            .blur(radius: 9, opaque: true)
                            .background(.black.opacity(0.1)))
                        
                        
                        // List of messages
                        ForEach(bag.messages, id: \.id) { message in
                            VStack(alignment: .leading) {
                                MessageRow(message: message)
                                    .swipeActions {
                                        // Resolve message
                                        Button {
                                            delSuccess = bag.deleteMessage(id: message.id)
                                        } label: {
                                            Label("Complete", systemImage: "checkmark.circle.fill")
                                        }
                                        .tint(.blue.opacity(0.5))
                                    }
                            }
                            .listRowBackground(                                TransparentBlur(removeAllFilters: false)
                                .blur(radius: 9, opaque: true)
                                .background(.black.opacity(0.1)))
                        }
                    }
                    .scrollContentBackground(.hidden)
                    

                }
            }
            .background {
                Image("bg1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.1))
                TransparentBlur(removeAllFilters: false)
            }
            
            .navigationTitle("Message Box")
            .navigationBarTitleDisplayMode(.large)
        }

    }
}

struct MessageInbox_Previews: PreviewProvider {
    static var bag = Bag()
    static var previews: some View {
        TabControl(selection: TabViewTag.inbox)
            .environmentObject(bag)
    }
}

