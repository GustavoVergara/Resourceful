import Foundation

public struct NibResource: Hashable {
    public var name: String
    public var bundle: Bundle
    
    public init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }
}

#if canImport(UIKit)
import UIKit

public extension NibResource {
    func callAsFunction(owner: Any?, options: [UINib.OptionsKey : Any]? = nil) -> UIView? {
        UINib(nibName: name, bundle: bundle)
            .instantiate(withOwner: owner, options: options).first as? UIView
    }
}
#endif
