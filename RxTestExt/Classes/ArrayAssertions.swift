//
//  ArrayAssertions.swift
//  RxSwift
//
//  Created by Mark on 02/08/2019.
//

import RxTest
import XCTest

extension TestableObserver where Element == Collection {
    
    /// This asserts that the first element is an empty array
    /// - note: If there have been no events the test will fail
    public func assertFirstIsEmpty( file: StaticString = #file, line: UInt = #line) {
        if let element = getElementOrFail(0, file: file, line: line) {
            XCTAssertTrue(element.isEmpty, file: file, line: line)
        }
    }
    
    /// This asserts that the last element is an empty array
    /// - note: If there have been no events the test will fail
    public func assertLastIsEmpty( file: StaticString = #file, line: UInt = #line) {
        if let element = getElementOrFail(elements.count - 1, file: file, line: line) {
            XCTAssertTrue(element.isEmpty, file: file, line: line)
        }
    }
    
    /// This asserts that the element at the given index is an empty array
    ///
    /// - Parameters:
    ///   - index: The element you wish to assert is Empty
    public func assertElementAtIsEmpty(_ index: Int, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementOrFail(index, file: file, line: line) {
            XCTAssertTrue(element.isEmpty, file: file, line: line)
        }
    }
    
    /// This asserts that elements at the given indexes are a empty arrays
    ///
    /// - Parameters:
    ///   - index: The elements you wish to assert are Empty
    public func assertElementsAtIsEmpty(_ indexes: Int..., file: StaticString = #file, line: UInt = #line) {
        for index in indexes {
            if let element = getElementOrFail(index, file: file, line: line) {
                XCTAssertTrue(element.isEmpty, file: file, line: line)
            }
        }
    }
}

