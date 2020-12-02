//
//  Mirror.swift
//  Customizations
//
//  Created by Goki on 12/1/20.
//

import SwiftUI

// Usage: take any view, and call `.mirror()` on it.
extension View {
    func mirror(collapsed: Bool = false, rules: [Rule] = []) -> some View {
        VStack(spacing: 100) {
            self
            MirrorView(content: self, rules: rules)
        }
    }
}

// The rest of this file is "internal" and not very beautiful yet.
/// A simple Tree datastructure that holds nodes with `A` as the value.
struct Tree<A> {
    var value: A
    var children: [Tree<A>] = []
    init(_ value: A, children: [Tree<A>] = []) {
        self.value = value
        self.children = children
    }
}

extension Tree {
    func map<B>(_ transform: (A) -> B) -> Tree<B> {
        return Tree<B>(transform(value), children: children.map({ $0.map(transform) }))
    }
}

extension Tree: Equatable where A: Equatable { }
extension Tree: Hashable where A: Hashable { }

private let specialChars: Set<Character> = Set("<()>, ")

extension Substring {
    fileprivate mutating func dropSpaces() {
        while first?.isWhitespace == true {
            removeFirst()
        }
    }
    
    fileprivate mutating func parseName() -> String {
        var result: String = ""
        while let f = self.first, !specialChars.contains(f) {
            result.append(removeFirst())
        }
        dropSpaces()
        return result
    }
    
    fileprivate mutating func eat(_ character: Element) -> Bool {
        guard first == character else { return false }
        removeFirst()
        dropSpaces()
        return true
    }
    
    
    fileprivate mutating func parseHierarchy() -> Tree<String> {
        var children: [Tree<String>] = []

        if eat("(") {
            while !eat(")") {
                children.append(parseHierarchy())
                _ = eat(",")
            }
            return Tree("Tuple", children: children)
        }
        
        let name = parseName()
        assert(!name.isEmpty)
        
        if eat("<") {
            while !eat(">") {
                children.append(parseHierarchy())
                _ = eat(",")
            }
        }
        return Tree(name, children: children)
    }
}

extension Tree where A == String {
    /// Construct a tree structure that reflects the generic structure of a type.
    init<A>(reflecting value: A) {
        let m = Mirror(reflecting: value)
        let input = "\(m.subjectType)"
        print(input)
        var remainder = input[...]
        let hierarchy = remainder.parseHierarchy()
        assert(remainder.isEmpty)
        self = hierarchy
    }
}

extension CGPoint: VectorArithmetic {
    public static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }
    
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    public static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    
    public mutating func scale(by rhs: Double) {
        x *= CGFloat(rhs)
        y *= CGFloat(rhs)
    }
    
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    public var magnitudeSquared: Double { return Double(x*x + y*y) }
}

class Unique<A>: Identifiable {
    let value: A
    init(_ value: A) { self.value = value }
}

extension Unique: Equatable where A: Equatable {
    static func == (lhs: Unique<A>, rhs: Unique<A>) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
extension Unique: Hashable where A: Hashable {
    func hash(into hasher: inout Hasher) {
        value.hash(into: &hasher)
    }
}

struct Collect<A>: PreferenceKey {
    static var defaultValue: [A] { [] }
    static func reduce(value: inout [A], nextValue: () -> [A]) {
        value.append(contentsOf: nextValue())
    }
}

struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

/// Draws an edge from `from` to `to`
struct EdgeShape: Shape {
    var from: CGPoint
    var to: CGPoint
    var animatableData: AnimatablePair<CGPoint, CGPoint> {
        get { AnimatablePair(from, to) }
        set {
            from = newValue.first
            to = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)
        }
    }
}

/// A simple Diagram. It's not very performant yet, but works great for smallish trees.
struct Diagram<A: Identifiable & Hashable, V: View>: View {
    let tree: Tree<A>
    var strokeWidth: CGFloat = 1
    let node: (Binding<Bool>, A) -> V
    @State private var collapsed: Bool
    
    let collapsedDefault: Bool
    init(tree: Tree<A>, strokeWidth: CGFloat = 1, node: @escaping (Binding<Bool>, A) -> V, collapsed: Bool = false) {
        self.tree = tree
        self.strokeWidth = strokeWidth
        self.node = node
        self.collapsedDefault = collapsed
        self._collapsed = State(initialValue: collapsed && !tree.children.isEmpty)
    }
    
    private typealias Key = CollectDict<A.ID, Anchor<CGPoint>>

    var body: some View {
        return VStack(alignment: .center) {
            node($collapsed, tree.value)
               .anchorPreference(key: Key.self, value: .bottom, transform: {
                   [self.tree.value.id: $0]
               })
                .padding()
            if !collapsed {
                       HStack(alignment: .top, spacing: 10) {
                           ForEach(tree.children, id: \.value, content: { child in
                               Diagram(tree: child, strokeWidth: self.strokeWidth, node: self.node, collapsed: self.collapsedDefault)
                           })
                       }
                   }
        }.backgroundPreferenceValue(Key.self, { (centers: [A.ID: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                if !self.collapsed {
                    ForEach(self.tree.children, id: \.value, content: {
                     child in
                        EdgeShape(from:
                            proxy[centers[self.tree.value.id]!],
                                  to: proxy[centers[child.value.id]!])
                            .stroke(lineWidth: self.strokeWidth)
                    })
                }
            }
        })
    }
}

extension Color {
    static func keynoteLikeGradient(hue: Double) -> [Color] {
        return [
            Color(hue: hue, saturation: 0.66, brightness: 1),
            Color(hue: hue, saturation: 1, brightness: 0.73),
        ]
    }
}

/// A node used to display a type
struct MyNode: ViewModifier {
    @State var hue: Hue = .orange
    func body(content: Content) -> some View {
        content
        .foregroundColor(.white)
        .padding()
        .background(RoundedRectangle(cornerRadius: 5).fill(
            LinearGradient(gradient: Gradient(colors: Color.keynoteLikeGradient(hue: Double(hue.value)/360)), startPoint: .top, endPoint: .bottom)
        ))
        .background(Color.white)
        .onTapGesture {
            switch hue {
            case .orange: hue = .blue
            case .blue:   hue = .green
            case .green:  hue = .orange
            default:      hue = .orange
            }
        }
    }
}

struct MirrorView<Content>: View {
    let content: Content
    var collapsed: Bool = false
    var rules: [Rule] = []
    
    var body: some View {
        let tree = Tree(reflecting: content).simplified(rules: rules).map(Unique.init)
        return Diagram(tree: tree, strokeWidth: 2, node: { _, value in
            Text(value.value.text)
                .bold()
                .fixedSize()
                .modifier(MyNode(hue: value.value.hue))
        }).foregroundColor(.gray)
    }
}

// For presentations, it's nicer to simplify the tree a little bit.
struct DiagramState {
    var hue: Hue = .orange
}

extension Tree where A == String {
    func simplified(rules: [Rule] = []) -> Tree<Colored> {
        _simplified(rules: rules, .init())
    }

    
    private func _simplified(rules: [Rule], _ _state: DiagramState) -> Tree<Colored> {
        let (state, childState) = rules.reduce(into: (_state, _state)) { (st, rule) in
            rule.apply(self, &st.0, &st.1)
        }
        if value == "Optional" && children.count == 1 {
            let child = children[0]
            return Tree<Colored>(Colored(child.value + "?", hue: state.hue), children: child.children.map { $0._simplified(rules: rules, childState) })
        } else if value == "TupleView" && children.first?.value == "Tuple" {
            return children[0]._simplified(rules: rules, state)
        } else if value == "ModifiedContent" {
            if children.count == 2 {
                let child = children[1]
                let name = child.value.simplerName

                if basicModifiers.contains(child.value) {
                    return Tree<Colored>(Colored(name, hue: state.hue), children: [
                        children[0]._simplified(rules: rules, childState)
                    ])
                }
                if inlineSecondChildModifiers.contains(child.value) {
                    let n = children[1].children[0]._simplified(rules: rules, childState).value
                    return Tree<Colored>(Colored(name + "(\(n.text))", hue: n.hue), children: [
                        children[0]._simplified(rules: rules, childState),
                        
                    ])
                }
                if twoChildModifiers.contains(child.value) {
                    return Tree<Colored>(Colored(name, hue: state.hue), children: [
                        children[0]._simplified(rules: rules, childState),
                        children[1].children[0]._simplified(rules: rules, childState)
                    ])
                }
            }
        }
        return Tree<Colored>(Colored(value.simplerName, hue: state.hue), children: children.map { $0._simplified(rules: rules, childState) })
    }
}

struct Rule {
    // The first is the state of the current node. The second the child state
    let apply: (Tree<String>, inout DiagramState, inout DiagramState) -> ()
}

struct Hue: Hashable {
    var value: Int // 0...255
    
    static let orange = Hue(value: 7)
    static let green = Hue(value: 150)
    static let blue = Hue(value: 220)
}

struct Colored: Hashable {
    var text: String
    var hue: Hue = .orange // 0..<256
    init(_ text: String, hue: Hue) {
        self.text = text
        self.hue = hue
    }
}

let basicModifiers: Set<String> = [
    "_FixedSizeLayout",
    "_PaddingLayout",
    "_FrameLayout",
    "_AspectRatioLayout",

]

let twoChildModifiers: Set<String> = [
    "_BackgroundModifier",
    "_OverlayModifier",
]

let inlineSecondChildModifiers: Set<String> = [
    "_EnvironmentKeyWritingModifier",
    "_PreferenceWritingModifier",
    "_PreferenceActionModifier"
]

extension String {
    var simplerName: String {
        switch self {
        case "_FixedSizeLayout": return ".fixedSize"
        case "_PaddingLayout": return ".padding"
        case "_BackgroundModifier": return ".background"
        case "_FrameLayout": return ".frame"
        case "_PreferenceWritingModifier": return ".preference"
        case "_PreferenceActionModifier": return ".onPreferenceChange"
        case "_AspectRatioLayout": return ".aspectRatio"
        case _ where first == "_": return String(dropFirst())
        default: return self
        }
    }
}

// Builtin Rules
let highlightSubtreeOfEnvironment = Rule(apply: { tree, state, childState in
    if tree.value == "ModifiedContent" && tree.children[1].value == "_EnvironmentKeyWritingModifier" {
        childState.hue = .blue
    }
})

let highlightPreferenceAncestors = Rule(apply: { tree, state, childState in
    if tree.containsPreference {
        state.hue = .blue
    }
})

extension Tree where A == String {
    private var isPreference: Bool {
        value == "_PreferenceWritingModifier"
    }
    var containsPreference: Bool {
        children.contains {
            $0.isPreference || $0.containsPreference
        }
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
