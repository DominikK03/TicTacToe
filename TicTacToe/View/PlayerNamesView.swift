import SwiftUI
import CoreData

struct PlayerNamesView: View {
    var onStart: ([Player], Board, Game) -> Void
    var onBack: () -> Void
    var context: NSManagedObjectContext
    @State private var player1Name: String = ""
    @State private var player2Name: String = ""
    @State private var player1Symbol: Symbol = Symbol.CROSS
    @State private var player2Symbol: Symbol = Symbol.CIRCLE
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
                HStack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("Nazwy graczy")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                
                Spacer()
                
                VStack(spacing: 30) {
                    // Gracz 1
                    VStack(spacing: 15) {
                        CustomTextField(text: $player1Name, placeholder: "Gracz 1", icon: "person.fill")
                            .focused($focusedField, equals: .player1)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .player2
                            }
                        HStack {
                            Text("Wybierz symbol:")
                                .font(.subheadline)
                                .foregroundColor(.purple)
                            Spacer()
                            SymbolPicker(selectedSymbol: $player1Symbol, oppositeSymbol: $player2Symbol)
                        }
                    }
                    // Gracz 2
                    VStack(spacing: 15) {
                        CustomTextField(text: $player2Name, placeholder: "Gracz 2", icon: "person.fill")
                            .focused($focusedField, equals: .player2)
                            .submitLabel(.done)
                        HStack {
                            Text("Wybierz symbol:")
                                .font(.subheadline)
                                .foregroundColor(.purple)
                            Spacer()
                            SymbolPicker(selectedSymbol: $player2Symbol, oppositeSymbol: $player1Symbol)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Button(action: {
                    let player1 = Player(name: player1Name, chosenSymbol: player1Symbol)
                    let player2 = Player(name: player2Name, chosenSymbol: player2Symbol)
                    let game = Game(context: context, firstPlayer: player1Name, secondPlayer: player2Name)
                    var board = Board(board: [])
                    board.initBoard(context: context, game: game)
                    onStart([player1, player2], board, game)
                }) {
                    CustomText(title: "Rozpocznij grę", icon: "play.fill")
                        .opacity(playersReady ? 1 : 0.6)
                }
                .disabled(!playersReady)
                
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

struct SymbolPicker: View {
    @Binding var selectedSymbol: Symbol
    @Binding var oppositeSymbol: Symbol
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                selectedSymbol = Symbol.CROSS
                oppositeSymbol = Symbol.CIRCLE
            }) {
                Text("X")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 40, height: 40)
                    .background(selectedSymbol == Symbol.CROSS ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
                    .foregroundColor(selectedSymbol == Symbol.CROSS ? .blue : .gray)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedSymbol == Symbol.CROSS ? Color.blue : Color.gray.opacity(0.5), lineWidth: 2)
                    )
            }
            
            Button(action: {
                selectedSymbol = Symbol.CIRCLE
                oppositeSymbol = Symbol.CROSS
            }) {
                Text("O")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 40, height: 40)
                    .background(selectedSymbol == Symbol.CIRCLE ? Color.purple.opacity(0.3) : Color.gray.opacity(0.1))
                    .foregroundColor(selectedSymbol == Symbol.CIRCLE ? .purple : .gray)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedSymbol == Symbol.CIRCLE ? Color.purple : Color.gray.opacity(0.5), lineWidth: 2)
                    )
            }
        }
    }
}

#Preview {
    PlayerNamesView(onStart: {_,_,_ in}, onBack: {}, context: PersistenceController.preview.container.viewContext)
}
