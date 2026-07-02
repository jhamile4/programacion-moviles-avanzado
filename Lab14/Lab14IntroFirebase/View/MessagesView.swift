import SwiftUI
import FirebaseAuth

struct MessagesView: View {
    @StateObject private var databaseService = DatabaseService()
    @State private var newMessage = ""
    @State private var showingProfile = false
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Messages")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: NotificationView()){
                    Image(systemName: "bell.fill")
                        .foregroundStyle(.orange)
                        .font(.title2)
                }
                
                NavigationLink(destination: QueryTestView()){
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.blue)
                        .font(.title2)
                }
                
                Button("Profile"){
                    showingProfile = true
                }
                .padding(8)
                .background(Color.blue)
                .foregroundStyle(.white)
                .cornerRadius(8)
                
                Button("Sign Out") {
                    try? Auth.auth().signOut()
                }
                .foregroundColor(.red)
            }
            .padding()
            
            // Messages list
            List(databaseService.messages) { message in
                VStack(alignment: .leading, spacing: 5) {
                    Text(message.text)
                        .font(.body)
                    
                    HStack {
                        Text(message.userEmail)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(message.timestamp, style: .time)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 2)
            }
            
            // New message input
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Send") {
                    if !newMessage.isEmpty {
                        databaseService.addMessage(text: newMessage)
                        newMessage = ""
                    }
                }
                .disabled(newMessage.isEmpty)
            }
            .padding()
        }
        .onAppear {
            databaseService.startListening()
        }
        .sheet(isPresented: $showingProfile){
            UserProfileView()
        }
    }
}
#Preview{
    MessagesView()
}
