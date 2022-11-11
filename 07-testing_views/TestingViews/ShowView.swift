import SwiftUI

struct ShowView: View {
    @StateObject private var viewModel = ShowViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.shows) { show in
                    ShowViewCell(show)
                        .onAppear {
                            viewModel.loadMoreIfNeccessary(show)
                        }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationTitle("Popular")
            .onAppear {
                viewModel.load()
            }
        }
    }
}

struct ShowView_Previews: PreviewProvider {
    static var previews: some View {
        ShowView()
    }
}
