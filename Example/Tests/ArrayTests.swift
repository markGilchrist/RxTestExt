//
//  ArrayTests.swift
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

class ArrayTests: XCTestCase {
    var testScheduler: TestScheduler!
    var intArrayObserver: TestableObserver<[Int]>!
    var bag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        intArrayObserver = testScheduler.createObserver([Int].self)
        bag = DisposeBag()
    }
    
    func test_assertFirstEmpty(){
        Observable.from([[],[1],[1,2,3,],[]])
            .subscribe(intArrayObserver)
            .disposed(by: bag)
        
        intArrayObserver?.assertFirstIsEmpty()
    }
}
