//
//  NoteItem.swift
//  NoteApp
//
//  Created by Manoj on 30/09/25.
//

import Foundation

struct NoteItemModel : Identifiable,Codable{
    var id: String
    let title : String
    let noteText : String
    let isCompleted : Bool
    
    init(id: String = UUID().uuidString, title: String, noteText: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.noteText = noteText
        self.isCompleted = isCompleted
    }
        
    func toggleCompletion() -> NoteItemModel{
        return NoteItemModel(id: id, title: title, noteText: noteText, isCompleted: !isCompleted)
    }
}
