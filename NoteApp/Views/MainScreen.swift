import Foundation
import SwiftUICore
import SwiftUI


struct MainScreen : View {
    @EnvironmentObject var listViewModel : ListViewModel
    var body: some View {
        ZStack{
            if listViewModel.items.isEmpty{
                EmptyItemView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }else{
                List{
                    ForEach(listViewModel.items,){ item in
                        NavigationLink(
                            destination:
                                AddNoteScreen(currentItem: item).environmentObject(listViewModel))
                        {
                            NoteItemView(item: item)
                        }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo list 📋")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: {
                AddNoteScreen()
            })
        )
    }
    
}


#Preview {
    NavigationView {
        MainScreen()
    }.environmentObject(ListViewModel())
}


#Preview {
    NavigationView {
        MainScreen()
    }.environmentObject(ListViewModel())
        .preferredColorScheme(.dark)
}
