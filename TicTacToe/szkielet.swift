//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//    
//    @State public var moveCount: Int = 0
//    @State public var isChecked: [[Bool]] = [[false, false, false],
//    [false,false,false],
//    [false,false,false]]
//    public var fieldToFlush: (Int, Int) = (0, 0)
//    
//
//    var body: some View {
//        VStack {
//            HStack {
//                VStack {
//                    Button (role: .cancel) {
//                        moveCount += 1
//                        setChecked(x: 0, y: 0)
//                    }
//                    label: {
//                        if(moveCount == 0) {
//                            Image(systemName: "xmark")
//                                .resizable()
//                                .opacity(0)
//                        }
//                        if(moveCount % 2 == 0 && moveCount != 0 && isChecked[0][0]) {
//                            Image(systemName: "circle")
//                                .resizable()
//                        }
//                        else if (moveCount != 0) {
//                            Image(systemName: "xmark")
//                                .resizable()
//                        }
//                    }
//                }
//                .frame(width:100, height: 100, alignment: .leading)
//                .border(.black)
//                VStack {
//                }
//                .frame(width:100, height: 100, alignment: .leading)
//                .border(.black)
//                VStack {
//                    
//                }
//                .frame(width:100, height: 100)
//                .border(.black)
//            }
//            HStack {
//                VStack {
//                    
//                }
//                .frame(width:100, height: 100)
//                .border(.black)
//                VStack {
//                    
//                }
//                .frame(width:100, height: 100)
//                .border(.black)
//                VStack {
//                    
//                }
//                .frame(width:100, height: 100)
//                .border(.black)
//            }
//            HStack {
//                VStack {
//                    
//                }
//                .frame(width:100, height: 100)
//                .border(.black)
//                VStack {
//                    
//                }
//                .frame(width:100, height: 100)
//                .border(.black)
//                VStack {
//                    
//                }
//                .frame(width:100, height: 100)
//                .border(.black)
//            }
//        }
//        .border(.black)
//    }
//    
//    private mutating func setChecked(x: Int, y: Int) {
//        isChecked[x][y] = true
//        if(moveCount % 6 == 0) {
//            isChecked[fieldToFlush.0][fieldToFlush.1] = false
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
//
