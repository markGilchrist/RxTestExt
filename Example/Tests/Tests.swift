import XCTest
import RxTestExt
import RxTest
@testable import RxSwift

class Tests: XCTestCase {
    var testScheduler: TestScheduler!
    var intObserver: TestableObserver<Int>!
    var bag: DisposeBag!

    enum TestError: LocalizedError {
        case nullPointerException

        var errorDescription: String? {
            return "example Message"
        }
    }

    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        intObserver = testScheduler.createObserver(Int.self)
        bag = DisposeBag()
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
            if let _ = e as? TestError, case _ = TestError.nullPointerException {
                return true
            }
            return false
        })
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

    func test_assertErrorMessage() {
        // arrange + act
        Observable
            .error(TestError.nullPointerException)
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertErrorMessage(message: "example Message")
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

    func test_assertValues() {
        // arrange + act
        Observable
            .just(1)
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertValues(1)
    }

    func test_assertThat() {
        // arrange + act
        Observable
            .just(1)
            .subscribe(intObserver)
            .disposed(by: bag)

        // assert
        intObserver.assertThatAt(0, that: { i in
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
}
