//
//  NimbleTests.swift
//  RxTestExt_Example
//
//  Created by Mark on 01/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import RxTest
import Quick
import RxSwift

@testable import RxTestExt

class NimbleTests: QuickSpec {

    enum TestError: LocalizedError {
        case nullPointerException

        var errorDescription: String? {
            return "example Message"
        }
    }

    override func spec() {
        super.spec()
        context("ensure expectatinons are imported") {
            var bag: DisposeBag!
            var scheduler: TestScheduler!
            var intObserver: TestableObserver<Int>!

            beforeEach {
                bag = DisposeBag()
                scheduler = TestScheduler(initialClock: 0)
                intObserver = scheduler.createObserver(Int.self)
            }

            describe("test one") {
                context("Error based tests") {
                    it("test_assertErrorIs") {
                        // arrange + act
                        Observable
                            .error(TestError.nullPointerException)
                            .subscribe(intObserver)
                            .disposed(by: bag)

                        // assert
                        intObserver.assertErrorIs(TestError.nullPointerException)
                    }

                    it("test_assertThatError") {
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

                    it("test_assertErrorMessage") {
                        // arrange + act
                        Observable
                            .error(TestError.nullPointerException)
                            .subscribe(intObserver)
                            .disposed(by: bag)

                        // assert
                        intObserver.assertErrorMessage(message: "example Message")
                    }
                }

                context("count based tests") {
                    it("test_assertValueCount") {
                        // arrange + act
                        Observable
                            .from([1, 2, 3, 4])
                            .subscribe(intObserver)
                            .disposed(by: bag)

                        // assert
                        intObserver.assertValueCount(4)
                    }
                }
            }
        }
    }
}
