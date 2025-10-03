import Foundation
import SwiftUI


struct AddNoteScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel

    @State private var textFieldText: String = ""   // title
    @State private var noteText: String = ""        // note content
    @State private var errorMessage: String?
    @State private var showError = false

    var currentItem: NoteItemModel?   // optional: nil = add, non-nil = edit

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Title Field
                TextField("Add Title", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)

                // Note Field (multiline)
                TextEditor(text: $noteText)
                    .frame(minHeight: 300)
                    .padding(8)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)

                // Save Button
                Button(action: { saveBtnPressed() }) {
                    Text(currentItem == nil ? "SAVE" : "UPDATE")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }
            .padding(14)
            .alert(errorMessage ?? "Error", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            }
            .onAppear {
                // Prefill if editing
                if let item = currentItem {
                    textFieldText = item.title
                    noteText = item.noteText
                }
            }
        }
    }
    
    private func saveBtnPressed() {
        do {
            let trimmedTitle = textFieldText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if let item = currentItem {
                // EDIT MODE
                try listViewModel.updateItem(item: item, newTitle: trimmedTitle, newNote: noteText)
            } else {
                // ADD MODE
                try listViewModel.addItem(text: trimmedTitle, note: noteText)
            }

            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}




#Preview {
    NavigationView {
        AddNoteScreen()
    }
    .environmentObject(ListViewModel())
}
