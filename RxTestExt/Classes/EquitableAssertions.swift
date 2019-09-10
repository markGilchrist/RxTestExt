//
//  ComparableAssertions.swift
//  RxSwift
//
//  Created by Mark on 02/08/2019.
//

import RxTest
import XCTest

extension TestableObserver where Element: Equatable {

    /// Assert that the TestObserver/TestSubscriber received only the specified values in the specified order.
    ///
    /// example
    ///
    ///    // arrange + act
    ///    Observable
    ///    .just(1)
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertValues(1)
    public func assertValues(_ expected: Element..., file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(elements, expected, file: file, line: line)
    }

    /// Assert that the TestObserver/TestSubscriber received only the specified values in the specified order without terminating.

    ///
    /// example
    ///
    ///    // arrange + act
    ///    let source = PublishSubject<Int>()
    ///    source.subscribe(intObserver)
    ///    .disposed(by: bag)
    ///    source.onNext(1)
    ///
    ///    // assert
    ///    intObserver.assertValuesOnly(1)

    public func assertValuesOnly(_ expected: Element..., file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(elements, expected, file: file, line: line)
        assertNotComplete(file: file, line: line)
    }

    /// This asserts that a particular element never appears an observable stream
    ///
    ///
    /// example
    ///
    ///    // arrange + act
    ///    Observable
    ///        .from([1,2,3,4])
    ///        .subscribe(intObserver)
    ///        .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertNever(19)
    ///
    /// - Parameters:
    ///   - never: The element that shoud never appear
    public func assertNever(_ never: Element, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(!elements.contains(never), file: file, line: line)
    }

    /// This function assert that one and only one event satisfies the suplied predicate
    ///
    /// - Parameters:
    ///   - that: The searching predicate
    ///
    /// example
    ///    // arrange + act
    ///    Observable
    ///    .from([1,2,3,4,5])
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertOneValue({ $0 % 4 == 0 })

    public func assertOneValue(_ that: @escaping(Element) -> Bool, file: StaticString = #file, line: UInt = #line ) {
        if let _ = getElementByPrdicateOrFail(that, file: file, line: line) {
            XCTAssertTrue( true, file: file, line: line)
        }
    }

    /// This function assert that one and only one event satisfies the suplied predicate and is equal to the expected element supplied
    ///
    /// example
    ///    // arrange + act
    ///    Observable
    ///    .from([1,2,3,4,5])
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertOneValueIs(expected: 4, { $0 % 4 == 0 })

    /// - Parameters:
    ///   - expected: Element
    ///   - that: search predicate

    public func assertOneValueIs(expected: Element, _ that: @escaping(Element) -> Bool, file: StaticString = #file, line: UInt = #line ) {
        if let recorded = getElementByPrdicateOrFail(that, file: file, line: line) {
            XCTAssertEqual(expected, recorded, file: file, line: line)
        }
    }

    /// This asserts that an element at a given index is equal to an expected
    /// element
    ///
    ///    func test_assertValueAt() {
    ///        // arrange + act
    ///        Observable
    ///            .from([1,2,3])
    ///            .subscribe(intObserver)
    ///            .disposed(by: bag)
    ///
    ///        // assert
    ///        intObserver.assertValueAt(1, value: 2)
    ///    }
    ///
    /// - Parameters:
    ///   - index: The Index you think it is at
    ///   - value: The Expected Element
    public func assertValueAt(_ index: Int, value: Element, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementOrFail(index, file: file, line: line) {
            XCTAssertEqual(element, value, file: file, line: line)
        }
    }

    /// This asserts the last element is equal to an expected element
    ///
    ///    func test_assertValueAt() {
    ///        // arrange + act
    ///        Observable
    ///            .from([1,2,3])
    ///            .subscribe(intObserver)
    ///            .disposed(by: bag)
    ///
    ///        // assert
    ///        intObserver.assertLastValue(1, value: 2)
    ///    }
    ///
    /// - Parameters:
    ///   - value: The Expected Element
    public func assertLastValue(value: Element, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementOrFail(elements.count - 1, file: file, line: line) {
            XCTAssertEqual(element, value, file: file, line: line)
        }
    }

    /// This asserts the first element is equal to an expected element
    ///
    ///    func test_assertValueAt() {
    ///        // arrange + act
    ///        Observable
    ///            .from([1,2,3])
    ///            .subscribe(intObserver)
    ///            .disposed(by: bag)
    ///
    ///        // assert
    ///        intObserver.assertFirstValue(value: 2)
    ///    }
    ///
    /// - Parameters:
    ///   - value: The Expected Element
    public func assertFirstValue(value: Element, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementOrFail(0, file: file, line: line) {
            XCTAssertEqual(element, value, file: file, line: line)
        }
    }
}
