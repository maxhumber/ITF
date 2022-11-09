import SwiftUI

extension UIViewController {
    public var preview: some View {
        Preview(viewController: self)
    }
    
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
}
