//
//  ArrayAssertions.swift
//  RxSwift
//
//  Created by Mark on 02/08/2019.
//

import RxTest
import XCTest

extension TestableObserver where Element == Array<Any> {
    public func assertFirstIsEmpty( file: StaticString = #file, line: UInt = #line) {
        if let element = getElementSafely(0, file: file, line: line) {
            XCTAssertTrue(element.isEmpty, file: file, line: line)
        }
    }
    
    public func assertLastIsEmpty( file: StaticString = #file, line: UInt = #line) {
        if let element = getElementSafely(elements.count - 1, file: file, line: line) {
            XCTAssertTrue(element.isEmpty, file: file, line: line)
        }
    }
}

