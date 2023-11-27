import SwiftUI

struct MessageInbox: View {
    @EnvironmentObject var bag: Bag
    @State var delSuccess = false
    
    var body: some View {
        VStack{
            Spacer()
            

            
            
            if bag.messages.isEmpty {
                HStack {
                    Text("No Messages At This Time")
                        .foregroundColor(.white)
                        .font(.title)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.gray.opacity(0.8))
                        )
                    Image(systemName: "arrow.clockwise.circle")
                        .font(.title)
                        .foregroundColor(.white)
                        .onTapGesture {
                            let _ = bag.fetchMessages()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.gray.opacity(0.8))
                        )
                
                        
                }
  
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image("bg1")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .overlay(Color.black.opacity(0.1))
                )
                .opacity(0.8)
            } else {
                // List of messages
                List {
                    // Refresh button
                    HStack {
                        Text("Feedback Tasks")
                        Spacer()
                        Image(systemName: "arrow.clockwise.circle")
                            .font(.title)
                            .foregroundColor(.white)
                            .onTapGesture {
                                let _ = bag.fetchMessages()
                            }
                            .padding()
                    }
                    
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
                                    .tint(.gray)
                                }
                        }
                        .listRowBackground(Color.black.opacity(0.1))
                    }
                }
                .scrollContentBackground(.hidden)
                .background {
                    Image("bg1")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .overlay(Color.black.opacity(0.1))
                    TransparentBlur(removeAllFilters: false)
                
                }
            }
        }
    }
}

struct MessageInbox_Previews: PreviewProvider {
    static var previews: some View {
        MessageInbox()
    }
}

