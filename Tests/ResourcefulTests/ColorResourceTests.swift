import XCTest
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif

import Resourceful

final class ColorResourceTests: XCTestCase {
    
    #if canImport(UIKit)
    @available(iOS 11.0, *)
    func test_callAsFunction_instantiatesUIColor() {
        let colorName = "Color"
        let expectedResult = UIColor(named: colorName, in: .module, compatibleWith: nil)
        
        let sut = ColorResource(name: colorName, bundle: .module)
        
        XCTAssertNotNil(expectedResult)
        XCTAssertEqual(sut(), expectedResult)
    }
    #endif
    
    #if canImport(SwiftUI)
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func test_callAsFunction_instantiatesSwiftUIColor() {
        let colorName = "Color"
        let expectedResult = Color(colorName, bundle: .module)
        
        let sut = ColorResource(name: colorName, bundle: .module)
        
        XCTAssertEqual(sut(), expectedResult)
    }
    #endif
    
}
