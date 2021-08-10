import XCTest
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif

import Resourceful

final class FontResourceTests: XCTestCase {
    
    private static func createSUT() -> FontResource {
        FontResource(name: Value.fontName, bundle: .module, fileExtension: Value.fontExtension)
    }
    
    override class func setUp() {
        do {
            try createSUT().register()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    #if canImport(UIKit)
    func test_register_registersFonts() {
        XCTAssertNotNil(UIFont(name: Value.fontName, size: 19))
    }
    
    func test_callAsFunction_instantiatesUIFont() {
        let size = 19 as CGFloat
        
        let expectedResult = UIFont(name: Value.fontName, size: size)
        let sut = Self.createSUT()
        
        XCTAssertEqual(sut(size: size), expectedResult)
    }
    #endif
    
    #if canImport(SwiftUI)
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func test_callAsFunction_instantiatesFont() {
        let size = 19 as CGFloat
        
        let expectedResult = Font.custom(Value.fontName, size: size)
        let sut = Self.createSUT()
        
        XCTAssertNotNil(expectedResult)
        XCTAssertEqual(sut(size: size), expectedResult)
    }
    #endif
    
    enum Value {
        static let fontName = "OpenSans"
        static let fontExtension = "ttf"
    }
    
}
