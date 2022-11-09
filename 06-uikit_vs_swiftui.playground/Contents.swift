import UIKit
import SwiftUI
import PlaygroundSupport

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

PlaygroundPage.current.setLiveView(SimpleViewController().preview)

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

PlaygroundPage.current.setLiveView(
    SimpleView().frame(width: 400, height: 700)
)


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
                    .opacity(0)
                Text("\(count)")
                    .foregroundColor(.primary)
            }
        }
    }
}

PlaygroundPage.current.setLiveView(
    RefactoredView().frame(width: 400, height: 700)
)
