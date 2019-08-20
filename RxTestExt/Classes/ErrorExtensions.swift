//
//  ErrorExtensions.swift
//  Nimble
//
//  Created by Mark on 02/08/2019.
//

import RxTest
import XCTest

extension TestableObserver {

    /// This asserts that there were no errors
    ///
    ///    // arrange + act
    ///    Observable
    ///    .just(1)
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertNoError()
    
    public func assertNoError(_ file: StaticString = #file, line: UInt = #line) {
        XCTAssert(0 == errorCount, _: "The error count was [\(errorCount)] not 0", file: file, line: line )
    }

    /// This asserts that there is an error of a type
    ///
    ///    // arrange + act
    ///    Observable
    ///    .error(TestError.nullPointerException)
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertErrorIs(TestError.nullPointerException)
    /// - Parameters:
    ///   - type: The type of error
    
    public func assertErrorIs<T: Error>(_ type: T, file: StaticString = #file, line: UInt = #line) {
        if let error = getErrorOrFail(file: file, line: line) {
            XCTAssert(error.self is T,_: "The error is not of type \(T.self)", file: file, line: line)
        }
    }

    /// This asserts that there is an error that satisfies the predicate supplied
    ///
    ///    // arrange + act
    ///    Observable
    ///    .error(TestError.nullPointerException)
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertThatError(that: { (e) -> Bool in
    ///    if let error = e as? TestError, error == .nullPointerException {
    ///            return true
    ///        }
    ///        return false
    ///    })
    /// - Parameters:
    ///   - that: The predicate to test the error by
    
    public func assertThatError(that: @escaping (Error) -> Bool, file: StaticString = #file, line: UInt = #line) {
        if let error = getErrorOrFail(file: file, line: line) {
            XCTAssert(that(error), _: "The error is not satify the predicate", file: file, line: line)
        }
    }
    
    /// This asserts that there is an error with a localizedDescription equal to the expected message supplied
    ///
    ///    // arrange + act
    ///    Observable
    ///    .error(TestError.nullPointerException)
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertErrorMessage(message: "example Message")
    ///
    /// - Parameters:
    ///   - message: The message of the expected error
    
    public func assertErrorMessage(message: String, file: StaticString = #file, line: UInt = #line) {
        if let error = getErrorOrFail(file: file, line: line) {
            XCTAssert(error.localizedDescription == message,_: "The error message [\(error.localizedDescription)] is not equal to the expected message [\(message)] ", file: file, line: line)
        }
    }
}
