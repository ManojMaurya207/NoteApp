import SwiftUI

@main
struct NoteAppApp: App {
    @StateObject var listViewModel : ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainScreen()
            }
            .environmentObject(listViewModel)
        }
    }
}
