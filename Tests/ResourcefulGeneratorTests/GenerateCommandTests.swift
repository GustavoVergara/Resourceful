import XCTest
import ArgumentParser

@testable import ResourcefulGenerator

final class GenerateCommandTests: XCTestCase {
    var outputListener: OutputListener!
    var sut: ParsableCommand!
    
    override func setUpWithError() throws {
        outputListener = OutputListener()
        outputListener.openConsolePipe()
        sut = GenerateCommand()
        try sut.validate()
        
    }
    
    override func tearDown() {
        outputListener.closeConsolePipe()
    }
    
    func test_run_outputsImagesFileContents() throws {
        try sut.run()
        waitForOutput()
        XCTAssertEqual(outputListener.contents, try Stub.generatedImages())
    }
    
    private func waitForOutput() {
        let outputExpectation = expectation(description: "output to not be empty")
        outputListener.onContentsChange = { _ in
            outputExpectation.fulfill()
        }
        wait(for: [outputExpectation], timeout: 0.01)
    }
    
    enum Stub {
        static func generatedImages() throws -> String? {
            try Bundle.module
                .url(forResource: "GeneratedImages", withExtension: nil)
                .map { try Data(contentsOf: $0) }
                .flatMap { String(data: $0, encoding: .utf8) }
        }
    }
}
