//
//  HashableExtenstions.swift
//  Pods
//
//  Created by Mark on 09/08/2019.
//

import RxTest
import XCTest

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
