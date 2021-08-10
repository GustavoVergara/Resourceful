import XCTest

import Resourceful

final class StringResourceTests: XCTestCase {
    
    func test_callAsFunction_instantiatesString_whenSpecifyingATableName() {
        let key = "LocalizedKey"
        let tableName = "Localizable"
        
        let expectedResult = NSLocalizedString(key, tableName: tableName, bundle: .module, comment: "")
        let sut = StringResource(key: key, tableName: tableName, bundle: .module)
        
        XCTAssertNotEqual(expectedResult, key)
        XCTAssertEqual(sut(), expectedResult)
    }
    
    func test_callAsFunction_instantiatesString_whenUsingTheDefaultTable() {
        let key = "LocalizedKey"
        
        let expectedResult = NSLocalizedString(key, bundle: .module, comment: "")
        let sut = StringResource(key: key, bundle: .module)
        
        XCTAssertNotEqual(expectedResult, key)
        XCTAssertEqual(sut(), expectedResult)
    }
    
}
