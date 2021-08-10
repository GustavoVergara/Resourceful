import XCTest
#if canImport(UIKit)
import UIKit
#endif

import Resourceful

final class NibResourceTests: XCTestCase {
    
    #if canImport(UIKit)
    @available(iOS 11.0, *)
    func test_callAsFunction_instantiatesUIView() {
        let name = "View"
        let expectedResult = UINib(nibName: "View", bundle: .module)
            .instantiate(withOwner: nil, options: nil).first as? UIView
        
        let sut = NibResource(name: name, bundle: .module)
        
        XCTAssertNotNil(expectedResult?.accessibilityIdentifier)
        XCTAssertEqual(
            sut(owner: nil)?.accessibilityIdentifier,
            expectedResult?.accessibilityIdentifier)
    }
    #endif
    
}
