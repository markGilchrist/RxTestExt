//
//  ComparableTests.swift
//  RxTestExt_Example
//
//  Created by Mark on 09/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RxTestExt
import RxTest
import RxSwift
@testable import RxTestExt

class ComparableTests: XCTestCase {
    var testScheduler: TestScheduler!
    var intObserver: TestableObserver<Int>!
    var bag: DisposeBag!

    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        intObserver = testScheduler.createObserver(Int.self)
        bag = DisposeBag()
    }

    func test_assertValues() {
        // arrange + act
        Observable
            .just(1)
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertValues(1)
    }

    func test_assertValuesOnly() {
        // arrange + act
        let source = PublishSubject<Int>()
        source.subscribe(intObserver)
            .disposed(by: bag)
        source.onNext(1)

        // assert
        intObserver.assertValuesOnly(1)
    }

    func test_assertOneValue() {
        // arrange + act
        Observable
            .from([1, 2, 3, 4, 5])
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertOneValue({ $0 % 4 == 0 })
    }

    func test_assertOneValueIs() {
        // arrange + act
        Observable
            .from([1, 2, 3, 4, 5])
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertOneValueIs(expected: 4, { $0 % 4 == 0 })
    }

    func test_assertValueAt() {
        // arrange + act
        Observable
             .from([1, 2, 3])
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertValueAt(1, value: 2)
    }

    func test_assertFirstValue() {
        // arrange + act
        Observable
            .from([1, 2, 3])
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertFirstValue(value: 1)
    }

    func test_assertLastValue() {
        // arrange + act
        Observable
            .from([1, 2, 3])
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertLastValue(value: 3)
    }
    
    func test_assertElementCount() {
        // arrange + act
        Observable
            .from([1, 2, 3])
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // assert
        intObserver.assertElementCount(1, predicate: { $0 % 2 == 0 })
    }
}
