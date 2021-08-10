import XCTest
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif

import Resourceful

final class ImageResourceTests: XCTestCase {
    
    #if canImport(UIKit)
    @available(iOS 11.0, *)
    func test_callAsFunction_instantiatesUIImage() {
        let name = "Image"
        let expectedResult = UIImage(named: name, in: .module, compatibleWith: nil)
        
        let sut = ImageResource(name: name, bundle: .module)
        
        XCTAssertNotNil(expectedResult)
        XCTAssertEqual(sut(), expectedResult)
    }
    #endif
    
    #if canImport(SwiftUI)
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func test_callAsFunction_instantiatesSwiftUIImage() {
        let name = "Image"
        let expectedResult = Image(name, bundle: .module)
        
        let sut = ImageResource(name: name, bundle: .module)
        
        XCTAssertEqual(sut(), expectedResult)
    }
    #endif
    
}
