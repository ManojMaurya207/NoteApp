//
//  ListViewModel.swift
//  NoteApp
//
//  Created by Manoj on 01/10/25.
//
import Foundation

class ListViewModel : ObservableObject {
    @Published var items : [NoteItemModel] = []{
        didSet{
            saveItems()
        }
    }
    
    let itemsKey: String = "notes"
    init() {
        loadItems()
    }
    
    
    func deleteItem(indexSet : IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from : IndexSet,to :Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(text: String) throws {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else { throw NoteValidationError.empty }
        guard trimmed.count >= 2 else { throw NoteValidationError.tooShort }
        guard trimmed.count <= 200 else { throw NoteValidationError.tooLong }
        guard !items.contains(where: { $0.title.caseInsensitiveCompare(trimmed) == .orderedSame })
        else { throw NoteValidationError.duplicate }
        
        let newItem = NoteItemModel(title: trimmed, noteText: "", isCompleted: false)
        items.append(newItem)
    }

    func toggleCheck(item : NoteItemModel){
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index] = item.toggleCompletion()
        }
    }
    
    func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: itemsKey)
        }
    }
    
    func loadItems() {
        if let data = UserDefaults.standard.data(forKey: itemsKey),
            let decoded = try? JSONDecoder().decode([NoteItemModel].self, from: data) {
            self.items = decoded
        }
    }
    
    
}

