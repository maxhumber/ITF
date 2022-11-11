import SwiftUI
import Kingfisher

struct ShowViewCell: View {
    @State var starred = false
    var show: Show
    
    init(_ show: Show) {
        self.show = show
    }
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "square")
                    .font(.largeTitle)
                    .layoutPriority(1)
                    .opacity(0)
                KFImage(show.thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .layoutPriority(0)
            }
            .clipShape(Circle())
            .padding(3)
            .background(
                Circle()
                    .foregroundColor(starred ? .yellow : .clear)
            )
            .onTapGesture(count: 2) {
                starred.toggle()
            }
            VStack(alignment: .leading) {
                Text(show.name)
                Text(show.network ?? "")
                    .font(.caption)
            }
        }
        .padding(.vertical, 3)
    }
}

struct ShowViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ShowView()
    }
}
