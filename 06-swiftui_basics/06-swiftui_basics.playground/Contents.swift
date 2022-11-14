import UIKit
import SwiftUI
import PlaygroundSupport

// MARK: - UIKit (vs) SwiftUI

// "ViewController Thinking"
class SimpleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blue = UIView()
        blue.backgroundColor = .blue
        view.addSubview(blue, anchors: [.leading(0), .trailing(0), .bottom(0), .top(0)])
        
        let whiteButton = UIButton(primaryAction: UIAction { _ in print("action") })
        whiteButton.backgroundColor = .white
        view.addSubview(whiteButton, anchors: [.centerX(0), .centerY(0), .width(100), .height(100)])
        
        let text = UILabel()
        text.text = "Hey"
        text.textColor = UIColor(.black)
        whiteButton.addSubview(text, anchors: [.centerX(0), .centerY(0)])
    }
}

run(false) {
    PlaygroundPage.current.setLiveView(SimpleViewController.preview)
}

// "SwiftUI Thinking"
struct SimpleView: View {
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 100)
                    Button {
                        count += 1
                    } label: {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            // bouncing around... how to fix, you ask?
                            Text("\(count)")
                                .foregroundColor(.primary)
                        }
                        .font(.title3)
                    }
                }
                Spacer()
            }
        }
    }
}

run(false) {
    PlaygroundPage.current.setLiveView(SimpleView().frame(width: 400, height: 700))
}

// Binding Example
struct StarButton: View {
    @Binding var starred: Bool
    
    init(_ starred: Binding<Bool>) {
        self._starred = starred
    }
    
    var body: some View {
        Button {
            starred.toggle()
        } label: {
            Image(systemName: starred ? "star.fill" : "star")
                .foregroundColor(.yellow)
        }
    }
}

// Refactored View from above
struct RefactoredView: View {
    @State var count: Int = 0
    @State var starred = false
    
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Spacer()
                box
                Spacer()
            }
        }
    }
    
    private var box: some View {
        ZStack {
            boxBackground
            boxContent
        }
    }
    
    private var boxBackground: some View {
        Rectangle()
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(.white)
            .frame(width: 100)
    }
    
    private var boxContent: some View {
        HStack(spacing: 0) {
            StarButton($starred)
            counter
        }
        .font(.title3)
        .padding(.leading, 5)
    }
    
    private var counter: some View {
        Button {
            count += 1
        } label: {
            ZStack {
                Text("XXX")
                    .opacity(0) // stop it from bouncing
                Text("\(count)")
                    .foregroundColor(.primary)
            }
        }
    }
}

run(false) {
    PlaygroundPage.current.setLiveView(RefactoredView().frame(width: 400, height: 700))
}

// No fixed widths or heights
struct GeometerReaderView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.blue
                VStack {
                    Spacer()
                    Color.white.frame(width: geo.size.width * 1/4, height: geo.size.width * 1/4)
                    Spacer()
                }
            }
        }
    }
}

run(false) {
    PlaygroundPage.current.setLiveView(GeometerReaderView().frame(width: 400, height: 700))
}

// A better way to be dynamic
struct DynamicHackView: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image(systemName: "square")
                    .opacity(0)
                    .font(.largeTitle)
                    .padding(20)
                Text("Hey")
            }
            .background(Color.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
}

run(false) {
    PlaygroundPage.current.setLiveView(DynamicHackView().frame(width: 400, height: 700))
}

// MARK: - UIKit (+) SwiftUI

struct TVShow {
    public var name: String
    public var status: String
    public var network: String?
    public var thumbnail: URL?
}

// Service Double
class TVService {
    func fetch() async -> [TVShow] {[
        TVShow(name: "Seinfeld", status: "Ended"),
        TVShow(name: "Rick and Morty", status: "Scheduled"),
        TVShow(name: "White Lotus", status: "Schedule"),
        TVShow(name: "Stranger Things", status: "Limbo")
    ]}
}

class LegacyTableCell: UITableViewCell {
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

class LegacyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private lazy var tableView = UITableView()
    private let cellReuseId = "cell"
    private var items = [TVShow]()
    private let service = TVService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        Task {
            self.items = await service.fetch()
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(LegacyTableCell.self, forCellReuseIdentifier: cellReuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        let show = items[indexPath.row]
        guard let tableCell = cell as? LegacyTableCell else { return cell }
        tableCell.nameLabel.text = show.name
        return cell
    }
}

run(false) {
    PlaygroundPage.current.setLiveView(LegacyViewController.preview)
}

// Updating cell with SwiftUI
struct DetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    var show: TVShow
    
    var body: some View {
        VStack(spacing: 10) {
            Text(show.name)
                .font(.title)
            Text(show.status)
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Dismiss")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.5).edgesIgnoringSafeArea(.all))
    }
}

class UpdatedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private lazy var tableView = UITableView()
    private let cellReuseId = "cell"
    private var items = [TVShow]()
    private let service = TVService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        Task {
            self.items = await service.fetch()
            self.tableView.reloadData()
        }
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        let show = items[indexPath.row]
        // UIHostingConfiguration available in iOS 16
        cell.contentConfiguration = UIHostingConfigurationBackport {
            VStack(alignment: .leading) {
                Text(show.name)
                    .font(.body.bold())
                Text(show.status)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let show = self.items[indexPath.row]
        let view = DetailView(show: show)
        let viewController = UIHostingController(rootView: view)
        self.present(viewController, animated: true)
    }
}

run(false) {
    PlaygroundPage.current.setLiveView(UpdatedViewController.preview)
}
