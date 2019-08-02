//
//  ErrorExtensions.swift
//  Nimble
//
//  Created by Mark on 02/08/2019.
//

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
}
