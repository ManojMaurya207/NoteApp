import Foundation
import SwiftUICore
import SwiftUI


struct ListView : View {
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
                                AddView(currentItem: item).environmentObject(listViewModel))
                        {
                            ListRowView(item: item)
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
                AddView()
            })
        )
    }
    
}


#Preview {
    NavigationView {
        ListView()
    }.environmentObject(ListViewModel())
}


#Preview {
    NavigationView {
        ListView()
    }.environmentObject(ListViewModel())
        .preferredColorScheme(.dark)
}
