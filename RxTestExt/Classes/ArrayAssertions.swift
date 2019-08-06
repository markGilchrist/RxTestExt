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
        if let element = getElementOrFail(0, file: file, line: line) {
            XCTAssertTrue(element.isEmpty, file: file, line: line)
        }
    }
    
    public func assertLastIsEmpty( file: StaticString = #file, line: UInt = #line) {
        if let element = getElementOrFail(elements.count - 1, file: file, line: line) {
            XCTAssertTrue(element.isEmpty, file: file, line: line)
        }
    }
    
    public func assertElementAtIsEmpty(_ index:Int, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementOrFail(index, file: file, line: line) {
            XCTAssertTrue(element.isEmpty, file: file, line: line)
        }
    }
}

