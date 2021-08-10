public struct FontResource: Hashable {
    public var name: String
    public var bundle: Bundle
    public var fileExtension: String
    
    public init(name: String, bundle: Bundle, fileExtension: String) {
        self.name = name
        self.bundle = bundle
        self.fileExtension = fileExtension
    }
    
    public func register() throws {
        guard let fontURL = bundle.url(forResource: name, withExtension: fileExtension) else {
            throw FontRegistrationError.fileNotFound(named: name)
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            throw FontRegistrationError.failedToLoadData(named: name)
        }

        guard let font = CGFont(fontDataProvider) else {
            throw FontRegistrationError.failedToCreateFontFromData(named: name)
        }

        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        if success == false {
            throw FontRegistrationError.errorRegisteringFont(named: name)
        }
    }
}

enum FontRegistrationError: Error {
    case fileNotFound(named: String)
    case failedToLoadData(named: String)
    case failedToCreateFontFromData(named: String)
    case errorRegisteringFont(named: String)
    
    var localizedDescription: String {
        switch self {
        case .fileNotFound(let fontName):
            return "Couldn't find font \(fontName)"
        case .failedToLoadData(let fontName):
            return "Couldn't load data from the font \(fontName)"
        case .failedToCreateFontFromData:
            return "Couldn't create font from data"
        case .errorRegisteringFont:
            return "Error registering font: maybe it was already registered."
        }
    }
}

#if canImport(UIKit)
import UIKit

public extension FontResource {
    func callAsFunction(size: CGFloat) -> UIFont? {
        UIFont(name: name, size: size)
    }
}
#endif

#if canImport(SwiftUI)
import SwiftUI

public extension FontResource {
    @available(OSX 10.15, *)
    @available(iOS 13.0, *)
    func callAsFunction(size: CGFloat) -> Font {
        Font.custom(name, size: size)
    }
    
    @available(OSX 11.0, *)
    @available(iOS 14.0, *)
    func callAsFunction(size: CGFloat, relativeTo textStyle: Font.TextStyle) -> Font {
        Font.custom(name, size: size, relativeTo: textStyle)
    }
    
    @available(OSX 11.0, *)
    @available(iOS 14.0, *)
    func callAsFunction(fixedSize: CGFloat) -> Font {
        Font.custom(name, fixedSize: fixedSize)
    }
}
#endif
