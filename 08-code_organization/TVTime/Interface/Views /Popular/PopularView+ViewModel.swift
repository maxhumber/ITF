import Foundation
import Core

extension PopularView {
    class ViewModel: ObservableObject {
        @Published var shows = [Show]()
        @Published var error: Error? = nil
        @Published var loading = false
        @Published var title: String
        
        private var page = 1
        private let service = ShowService()
        
        init() {
            if CommandLine.arguments.contains("enable-testing") {
                self.title = "Testing"
            } else {
                self.title = "Popular"
            }
        }
        
        @MainActor func load() {
            if self.loading { return }
            Task {
                defer { self.loading = false }
                do {
                    self.loading = true
                    let result = try await service.popular(page)
                    self.shows.append(contentsOf: result)
                    self.page += 1
                } catch {
                    self.error = error
                }
            }
        }
        
        @MainActor func loadMoreIfNeccessary(_ show: Show) {
            guard let index = shows.firstIndex(of: show), index == (shows.count - 2) else { return }
            load()
        }
        
        func delete(at offsets: IndexSet) {
            shows.remove(atOffsets: offsets)
        }
    }

}
