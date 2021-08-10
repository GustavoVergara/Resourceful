import Foundation

public struct ImageResource: Hashable {
    public var name: String
    public var bundle: Bundle
  
    public init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }
}

#if canImport(UIKit)
import UIKit

public extension ImageResource {
    func callAsFunction(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIImage? {
        UIImage(named: name, in: bundle, compatibleWith: traitCollection)
    }
}
#endif

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, *)
@available(OSX 10.15, *)
public extension ImageResource {
    
    func callAsFunction() -> Image {
        Image(name, bundle: bundle)
    }
  
    var image: Image? {
      Image(name, bundle: bundle)
    }
}
#endif

private class BundleToken {}

