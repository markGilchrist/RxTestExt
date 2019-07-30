import RxTest
import XCTest

extension TestableObserver {

    public func assertErrorIs<T: Error>(_ type: T, file: StaticString = #file, line: UInt = #line) {
        if let error = getErrorSafely(file: file, line: line) {
            XCTAssert(error.self is T, file: file, line: line)
        }
    }

    public func assertThatError(that: @escaping (Error) -> Bool, file: StaticString = #file, line: UInt = #line) {
        if let error = getErrorSafely(file: file, line: line) {
            XCTAssertTrue(that(error), file: file, line: line)
        }
    }

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
        XCTAssertNotEqual(0, completeions, file: file, line: line )
    }
    
    public func assertNotComplete(file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(0, completeions, file: file, line: line )
    }
    
    public func assertErrorMessage(message: String, file: StaticString = #file, line: UInt = #line) {
        if let error = getErrorSafely(file: file, line: line) {
            XCTAssertEqual(error.localizedDescription, message, file: file, line: line)
        }
    }

    // MARK:  internal functions
    
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

extension TestableObserver where Element: Comparable {

    /// Assert that the TestObserver/TestSubscriber received only the specified values in the specified order.
     public func assertValues(_ expected: Element..., file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(elements, expected, file: file, line: line)
    }

    /// Assert that the TestObserver/TestSubscriber received only the specified values in the specified order without terminating.
     public func assertValuesOnly(_ expected: Element..., file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(elements, expected, file: file, line: line)
        assertNotComplete(file: file, line: line)
    }

     public func assertNever(_ never: Element, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(!elements.contains(never), file: file, line: line)
    }

     public func assertOneValue(_ that: @escaping(Element) -> Bool, file: StaticString = #file, line: UInt = #line ) {
        XCTAssertEqual(elements.filter(that).count, 1, file: file, line: line)
    }

     public func assertOneValueIs(expected: Element, _ that: @escaping(Element) -> Bool, file: StaticString = #file, line: UInt = #line ) {
        if let recorded = getElementThatSafely(that, file: file, line: line) {
            XCTAssertEqual(expected, recorded, file: file, line: line)
        }
    }

     public func assertValueAt(_ index: Int, value: Element, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementSafely(index, file: file, line: line) {
            XCTAssertEqual(element, value, file: file, line: line)
        }
    }

     public func assertElementCount(_ expectedCount: Int, that: (Element) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(elements.filter(that).count, expectedCount, file: file, line: line )
    }

     public func assertNoError(_ file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(0, errorCount, file: file, line: line )
    }
}

extension TestableObserver where Element: Hashable {
    /**
     Assert that the TestObserver/TestSubscriber received only items that are in the specified collection as well, irrespective of the order they were received.
     This helps asserting when the order of the values is not guaranteed, i.e., when merging asynchronous streams.
     */

     public func assertValueSet(_ expected: Set<Element>, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(expected, Set(self.elements), file: file, line: line)
    }

    /**
     Assert that the TestObserver/TestSubscriber received only items that are in the specified collection as well, irrespective of the order they were received.
     This helps asserting when the order of the values is not guaranteed, i.e., when merging asynchronous streams.
     */

     public func assertValueSetOnly(_ expected: Set<Element>, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(expected, Set(self.elements), file: file, line: line)
        assertNotComplete(file: file, line: line)
    }
}
