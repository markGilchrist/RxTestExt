import RxTest
import XCTest

extension TestableObserver {
    
    // MARK: Value assertions
    public func assertNoValues(_ file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(0, valueCount, file: file, line: line)
    }
    
    public func assertValueCount(_ count: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(count, valueCount, file: file, line: line)
    }
    
    public func assertThatAt(_ index: Int, that: @escaping(Element) -> Bool, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementSafely(index, file: file, line: line) {
            XCTAssertTrue(that(element))
        }
    }
    
    public func assertComplete(file: StaticString = #file, line: UInt = #line) {
        XCTAssertNotEqual(0, completions, file: file, line: line )
    }
    
    public func assertNotComplete(file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(0, completions, file: file, line: line )
    }
    
    public func assertErrorMessage(message: String, file: StaticString = #file, line: UInt = #line) {
        if let error = getErrorSafely(file: file, line: line) {
            XCTAssertEqual(error.localizedDescription, message, file: file, line: line)
        }
    }
    
    // MARK: internal functions
    
    internal func getElementSafely(_ index: Int, file: StaticString, line: UInt ) -> Element? {
        guard index >= 0 && index < elements.count else {
            XCTFail("index out of bounds index ->[\(index)], count -> [\(elements.count)]", file: file, line: line)
            return nil
        }
        return self.elements[index]
    }
    
    internal func getElementThatSafely(_ that: @escaping (Element) -> Bool, file: StaticString, line: UInt) -> Element? {
        let filtered = elements.filter { that($0) }
        guard filtered.count == 1 else {
            XCTFail("the pridicate returns an invalid count -> [\(filtered.count)]", file: file, line: line)
            return nil
        }
        return filtered.first!
    }
    
    internal func getErrorSafely( file: StaticString, line: UInt) -> Error? {
        guard errors.count == 1 else {
            let message = errors.count == 0 ? "No errors present" : "More than one Error Present \(errors.count)"
            XCTFail(message, file: file, line: line)
            return nil
        }
        return self.errors[0]
    }
}
