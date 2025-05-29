import SwiftUI

struct PlayerNamesView: View {
    @State private var player1Name: String = ""
    @State private var player2Name: String = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case player1, player2
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Nazwy graczy")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                
                Spacer()
                
                VStack(spacing: 20) {
                    CustomTextField(text: $player1Name, placeholder: "Gracz 1", icon: "person.fill")
                        .focused($focusedField, equals: .player1)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .player2
                        }
                    
                    CustomTextField(text: $player2Name, placeholder: "Gracz 2", icon: "person.fill")
                        .focused($focusedField, equals: .player2)
                        .submitLabel(.done)
                }
                .padding(.horizontal, 20)
                
                
                    CustomText(title: "Rozpocznij grę", icon: "play.fill")
                        .opacity(playersReady ? 1 : 0.6)
                
                Spacer()
                VStack {
                    Text("Mateusz Kędra")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("Dominik Kępczyk")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var playersReady: Bool {
        !player1Name.isEmpty && !player2Name.isEmpty
    }
}

#Preview {
    PlayerNamesView()
}
