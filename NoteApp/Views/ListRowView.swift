//
//  ListRowView.swift
//  NoteApp
//
//  Created by Manoj on 30/09/25.
//

import SwiftUICore
import SwiftUI



struct ListRowView: View {
    let item : NoteItemModel
    @EnvironmentObject var listViewModel : ListViewModel
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
            .foregroundColor(item.isCompleted ? Color.green : Color.red)
            .onTapGesture {
                withAnimation(.linear){
                    listViewModel.toggleCheck(item: item)
                }
            }
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical,8)
    }
}


#Preview {
    var item1 : NoteItemModel = NoteItemModel(title: "First item", noteText: "", isCompleted: false)
    var item2: NoteItemModel = NoteItemModel(title: "Second item", noteText: "", isCompleted: true)
    
    Group{
        ListRowView(item:item1)
        ListRowView(item:item2)
    }
}

