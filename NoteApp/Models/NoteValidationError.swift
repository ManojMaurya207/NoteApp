//
//  NoteValidationError.swift
//  NoteApp
//
//  Created by Manoj on 01/10/25.
//
import Foundation

enum NoteValidationError: LocalizedError {
    case empty
    case tooShort
    case tooLong
    case duplicate
    
    var errorDescription: String? {
        switch self {
        case .empty: return "Note title can’t be empty."
        case .tooShort: return "Note title must be at least 2 characters."
        case .tooLong: return "Note title is too long (max 200)."
        case .duplicate: return "A note with this title already exists."
        }
    }
}
