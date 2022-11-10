// Source: https://gist.github.com/V8tr/3d28b3468bb60b02c5134d8d6ad78c43

import UIKit

public enum LayoutAnchor {
    case constant(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, constant: CGFloat)
    case relative(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, relatedTo: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat)
    case relativeSafeArea(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, relatedTo: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat)
}

extension LayoutAnchor {
    public static let leading = relative(attribute: .leading, relation: .equal, relatedTo: .leading)
    public static let trailing = relative(attribute: .trailing, relation: .equal, relatedTo: .trailing)
    public static let top = relative(attribute: .top, relation: .equal, relatedTo: .top)
    public static let bottom = relative(attribute: .bottom, relation: .equal, relatedTo: .bottom)
    public static let centerX = relative(attribute: .centerX, relation: .equal, relatedTo: .centerX)
    public static let centerY = relative(attribute: .centerY, relation: .equal, relatedTo: .centerY)
    public static let width = constant(attribute: .width, relation: .equal)
    public static let height = constant(attribute: .height, relation: .equal)
    public static let leadingSafeArea = relativeSafeArea(attribute: .leading, relation: .equal, relatedTo: .leading)
    public static let trailingSafeArea = relativeSafeArea(attribute: .trailing, relation: .equal, relatedTo: .trailing)
    public static let topSafeArea = relativeSafeArea(attribute: .top, relation: .equal, relatedTo: .top)
    public static let bottomSafeArea = relativeSafeArea(attribute: .bottom, relation: .equal, relatedTo: .bottom)
    
    public static func constant(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation) -> ((CGFloat) -> LayoutAnchor) {
        return { constant in
                .constant(attribute: attribute, relation: relation, constant: constant)
        }
    }
    
    public static func relative(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, relatedTo: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1) -> ((CGFloat) -> LayoutAnchor) {
        return { constant in
                .relative(attribute: attribute, relation: relation, relatedTo: relatedTo, multiplier: multiplier, constant: constant)
        }
    }
    
    public static func relativeSafeArea(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, relatedTo: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1.0) -> ((CGFloat) -> LayoutAnchor) {
        return { constant in
                .relativeSafeArea(attribute: attribute, relation: relation, relatedTo: relatedTo, multiplier: multiplier, constant: constant)
        }
    }
}

extension UIView {
    public func addSubview(_ subview: UIView, anchors: [LayoutAnchor]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        subview.activate(anchors: anchors, relativeTo: self)
    }
    
    public func activate(anchors: [LayoutAnchor], relativeTo item: UIView? = nil) {
        let constraints = anchors.map { NSLayoutConstraint(from: self, to: item, anchor: $0) }
        NSLayoutConstraint.activate(constraints)
    }
}

extension NSLayoutConstraint {
    public convenience init(from: UIView, to item: UIView?, anchor: LayoutAnchor) {
        switch anchor {
        case let .constant(attribute: attr, relation: relation, constant: constant):
            self.init(item: from, attribute: attr, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)
        case let .relative(attribute: attr, relation: relation, relatedTo: relatedTo, multiplier: multiplier, constant: constant):
            self.init(item: from, attribute: attr, relatedBy: relation, toItem: item, attribute: relatedTo, multiplier: multiplier, constant: constant)
        case let .relativeSafeArea(attribute: attr, relation: relation, relatedTo: relatedTo, multiplier: multiplier, constant: constant):
            guard let safeAreaLayoutGuide = item?.safeAreaLayoutGuide else { fatalError("\(String(describing: item)) safeAreaLayoutGuide problem") }
            self.init(item: from, attribute: attr, relatedBy: relation, toItem: safeAreaLayoutGuide, attribute: relatedTo, multiplier: multiplier, constant: constant)
        }
    }
}
