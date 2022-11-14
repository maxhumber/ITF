import SwiftUI
import Core

struct PopularView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.shows) { show in
                    Cell(show)
                        .onAppear {
                            viewModel.loadMoreIfNeccessary(show)
                        }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationTitle(viewModel.title)
            .onAppear {
                viewModel.load()
            }
        }
    }
}


struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
