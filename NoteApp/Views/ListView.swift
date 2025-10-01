import Foundation
import SwiftUICore
import SwiftUI


struct ListView : View {
    @EnvironmentObject var listViewModel : ListViewModel
    var body: some View {
        List{
            ForEach(listViewModel.items,){ item in
                ListRowView(item: item).onTapGesture {
                    // Open a NotePage 
                }
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
        }
        .listStyle(PlainListStyle())
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
