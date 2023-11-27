import SwiftUI

struct MessageInbox: View {
    @EnvironmentObject var bag: Bag
    
    var body: some View {
            List(bag.messages, id: \.id) { message in
                VStack(alignment: .leading) {
                    MessageRow(message: message)
                        .swipeActions {
                            Button {
                                let delSuccess = bag.deleteMessage(id: message.id)
                            } label: {
                                Label("Complete", systemImage: "checkmark.circle.fill")
                            }
                            .tint(.gray)
                        }
                }
                .listRowBackground(Color.black.opacity(0.1))
                
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
struct MessageInbox_Previews: PreviewProvider {
    static var previews: some View {
        MessageInbox()
    }
}

