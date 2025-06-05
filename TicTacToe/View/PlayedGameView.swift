import SwiftUI
import CoreData

struct PlayedGameView: View {
    @ObservedObject var viewModel: PlayedGameViewModel
    @State private var moveIndex: Int = 0
    var onBack: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                HStack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                Text("Przegląd gry")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                    ForEach(0..<9, id: \ .self) { index in
                        let row = index / 3
                        let col = index % 3
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.7))
                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                            Text(viewModel.boardAtMove(moveIndex)[row][col])
                                .font(.system(size: 50, weight: .bold))
                                .foregroundStyle(LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding(.horizontal, 20)
                if viewModel.moves.count > 0 {
                    VStack {
                        Slider(value: Binding(
                            get: { Double(moveIndex) },
                            set: { moveIndex = min(max(Int($0), 0), viewModel.moves.count) }
                        ).animation(nil), in: 0...Double(viewModel.moves.count), step: 1)
                        Text("Ruch: \(moveIndex) / \(viewModel.moves.count)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                }
                HStack {
                    Button(action: {
                        if moveIndex > 0 {
                            moveIndex -= 1
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                    Spacer()
                    Button(action: {
                        if moveIndex < viewModel.moves.count {
                            moveIndex += 1
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding()
        }
    }
} 
