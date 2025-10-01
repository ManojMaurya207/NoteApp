import Foundation
import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var textFieldText: String = ""
    @State private var errorMessage: String?
    @State private var showError = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TextField("Type something here", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)

                Button(action: {
                    saveBtnPressed()
                }, label: {
                    Text("SAVE")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
            // attach the alert here
            .alert(errorMessage ?? "Error", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            }
        }
    }
    
    private func saveBtnPressed() {
        do {
            try listViewModel.addItem(text: textFieldText)
            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}


#Preview {
    NavigationView {
        AddView()
    }
    .environmentObject(ListViewModel())
}
