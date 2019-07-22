

import RxTest
import XCTest

extension TestableObserver {
    
    func assertErrorIs<T: Error>(_ type: T.Type, file: StaticString = #file, line: UInt = #line){
        if let error = getErrorSafely() {
            XCTAssertTrue(error is T.Type, file: file, line: line)
        }
    }
    
    func assertThatError(that: @escaping (Error) -> Bool , file: StaticString = #file, line: UInt = #line){
        if let error = getErrorSafely() {
            XCTAssertTrue(that(error), file: file, line: line)
        }
    }
    
    func asssertValueCount(_ count:Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(count, valueCount, file: file, line: line)
    }
    
    func assertThatAt(_ index: Int, that: @escaping(Element) -> Bool, file: StaticString = #file, line: UInt = #line){
        if let element = getElementSafely(index) {
            XCTAssertTrue(that(element))
        }
    }
    
    internal func getElementSafely(_ index: Int, file: StaticString = #file, line: UInt = #line) -> Element? {
        guard index >= 0 && index < elements.count else {
            XCTFail("index out of bounds index ->[\(index)], count -> [\(elements.count)]" , file: file, line: line)
            return nil
        }
        return self.elements[index]
    }
    
    internal func getErrorSafely( file: StaticString = #file, line: UInt = #line) -> Error? {
        guard errors.count != 1 else {
            let message = errors.count == 0 ? "No errors present" : "More than one Error Present"
            XCTFail(message , file: file, line: line)
            return nil
        }
        return self.errors[0]
    }
}

extension TestableObserver where Element: Comparable {
    
    func assertComplete(file: StaticString = #file, line: UInt = #line){
        XCTAssertNotEqual(0, completeions, file: #file, line: #line )
    }
    
    func assertNotComplete(file: StaticString = #file, line: UInt = #line){
        XCTAssertEqual(0, completeions, file: #file, line: #line )
    }
    
    func assertElements(_ recorded: Element...,file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(elements, recorded, file: file, line: line)
    }
    
    func assertValueAt(_ index: Int, value: Element, file: StaticString = #file, line: UInt = #line){
        if let element = getElementSafely(index) {
            XCTAssertEqual(element, value, file: #file, line: #line)
        }
    }
    
    func assertElementCount(_ expectedCount: Int, that: (Element) -> Bool) {
        XCTAssertEqual(elements.filter(that).count, expectedCount, file: #file, line: #line )
    }
    
    func assertNoError() {
        XCTAssertEqual(0, errorCount, file: #file, line: #line )
    }
}
