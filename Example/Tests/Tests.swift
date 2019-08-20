import XCTest
import RxTestExt
import RxTest
import RxSwift
@testable import RxTestExt

class Tests: XCTestCase {
    var testScheduler: TestScheduler!
    var intObserver: TestableObserver<Int>!
    var bag: DisposeBag!

   

    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        intObserver = testScheduler.createObserver(Int.self)
        bag = DisposeBag()
    }

    func test_assertNoValues() {
        // arrange + act
        Observable
            .empty()
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // assert
        intObserver.assertNoValues()
    }
    
    func test_assertValueCount() {
        // arrange + act
        Observable
            .from([1, 2, 3, 4])
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // assert
        intObserver.assertValueCount(4)
    }
    
    func test_assertThatAt() {
        // arrange + act
        Observable
            .just(1)
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // assert
        intObserver.assertThatAt(0, predicate: { i in
            i % 2 != 0
        })
    }
    
    func test_assertComplete() {
        // arrange + act
        Observable
            .just(1)
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // assert
        intObserver.assertComplete()
    }
    
    func test_assertNotComplete() {
        // arrange + act
        let subject = PublishSubject<Int>()
        
        subject
            .subscribe(intObserver)
            .disposed(by: bag)
        
        // act
        subject.onNext(9)
        
        // assert
        intObserver.assertNotComplete()
    }
    
    func test_assertNever() {
        // arrange + act
        Observable
            .from([1, 2, 3, 4])
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertNever(19)
    }
}
