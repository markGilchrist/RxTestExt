//
//  ErrorTests.swift
//  RxTestExt_Example
//
//  Created by Mark on 14/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RxTestExt
import RxTest
import RxSwift
@testable import RxTestExt

class ErrorTests: XCTestCase {
    var testScheduler: TestScheduler!
    var intObserver: TestableObserver<Int>!
    var bag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        intObserver = testScheduler.createObserver(Int.self)
        bag = DisposeBag()
    }
    
    enum TestError: LocalizedError {
        case nullPointerException
        case andersonsError
        
        var errorDescription: String? {
            return "example Message"
        }
    }
    
    func test_assertNoError() {
        // arrange + act
        Observable
            .just(1)
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // assert
        intObserver.assertNoError()
    }
    
    func test_assertErrorIs() {
        // arrange + act
        Observable
            .error(TestError.nullPointerException)
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // assert
        intObserver.assertErrorIs(TestError.nullPointerException)
    }
    
    func test_assertThatError() {
        // arrange + act
        Observable
            .error(TestError.nullPointerException)
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // assert
        intObserver.assertThatError(that: { (e) -> Bool in
            if let error = e as? TestError, error == .nullPointerException {
                return true
            }
            return false
        })
    }
    
    func test_assertErrorMessage() {
        // arrange + act
        Observable
            .error(TestError.nullPointerException)
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // assert
        intObserver.assertErrorMessage(message: "example Message")
    }
}
