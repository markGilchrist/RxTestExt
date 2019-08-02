//
//  ComparableAssertions.swift
//  RxSwift
//
//  Created by Mark on 02/08/2019.
//

import RxTest
import XCTest

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
    
    public func assertLastValue(value: Element, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementSafely(elements.count - 1, file: file, line: line) {
            XCTAssertEqual(element, value, file: file, line: line)
        }
    }
    
    public func assertFirstValue(value: Element, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementSafely(0, file: file, line: line) {
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
