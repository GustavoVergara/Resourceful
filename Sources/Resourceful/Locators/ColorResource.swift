import Foundation

public struct ColorResource: Hashable {
    public var name: String
    public var bundle: Bundle
    
    public init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }
}

#if canImport(UIKit)
import UIKit

public extension ColorResource {
    @available(iOS 11.0, *)
    func callAsFunction(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIColor? {
        UIColor(named: name, in: bundle, compatibleWith: traitCollection)
    }
}
#endif


#if canImport(SwiftUI)
import SwiftUI

public extension ColorResource {
    @available(OSX 10.15, *)
    @available(iOS 13.0, *)
    func callAsFunction() -> Color {
        Color(name, bundle: bundle)
    }
}
#endif

