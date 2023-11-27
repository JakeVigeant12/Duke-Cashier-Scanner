import SwiftUI

struct MessageInbox: View {
    @EnvironmentObject var bag: Bag
    
    var body: some View {
        List(bag.messages, id: \.id) { message in
            VStack(alignment: .leading) {
                Text(message.content)
                    .font(.subheadline)
            }
        }
        
        
    }
}
struct MessageInbox_Previews: PreviewProvider {
    static var previews: some View {
        MessageInbox()
    }
}

