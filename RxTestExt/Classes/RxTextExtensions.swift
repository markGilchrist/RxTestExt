import RxTest
import XCTest

extension TestableObserver {

    // MARK: Value assertions
    
    /// The asserts that no elements were emitted
    /// // arrange + act
    ///    Observable
    ///    .empty()
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertNoValues()
    ///
    public func assertNoValues(_ file: StaticString = #file, line: UInt = #line) {
        XCTAssert(0 == valueCount, _: "The observer did have values" ,file: file, line: line)
    }

    /// This asserts that the number of elements observed is the same as the expecteed nunber supplied
    /// // arrange + act
    ///    Observable
    ///    .from([1, 2, 3, 4])
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertValueCount(4)
    /// - Parameters:
    ///   - count: The expected number of elements
    
    public func assertValueCount(_ count: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssert(count == valueCount, _: "The number of elements [\(valueCount)] did not match the expected count [\(count)]", file: file, line: line)
    }
    
    /// This asserts that the number of elements that match a given predicate is as expected
    ///
    /// - Parameters:
    ///   - expectedCount: The expected number of elements that match the predicate
    ///   - predicate: The filtering predicate
    ///
    ///    // arrange + act
    ///    Observable
    ///    .from([1, 2, 3])
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertElementCount(1, predicate: { $0 % 2 == 0 })
    
    public func assertElementCount(_ expectedCount: Int, predicate: (Element) -> Bool, file: StaticString = #file, line: UInt = #line) {
        let actualCount = elements.filter(predicate).count
        XCTAssert(actualCount == expectedCount, _: "The actual count was [\(actualCount)] not [\(expectedCount)]" , file: file, line: line )
    }
    
    /// This asserts that a given closure at a given index is true
    ///
    ///    // arrange + act
    ///    Observable
    ///    .just(1)
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertThatAt(0, predicate: { i in
    ///    i % 2 != 0
    ///    })
    /// - Parameters:
    ///   - index: The index of the element you wish to test
    ///   - predicate: The closure you expect to return true
    public func assertThatAt(_ index: Int, predicate: @escaping(Element) -> Bool, file: StaticString = #file, line: UInt = #line) {
        if let element = getElementOrFail(index, file: file, line: line) {
            XCTAssertTrue(predicate(element), file: file, line: line)
        }
    }

    /// This asserts that the observable was completed
    ///
    ///    // arrange + act
    ///    Observable
    ///    .just(1)
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // assert
    ///    intObserver.assertComplete()
    public func assertComplete(file: StaticString = #file, line: UInt = #line) {
        XCTAssert(1 <= completions, _ : "error observer was not completed", file: file, line: line )
    }

    /// This asserts that the observable was not completed
    ///
    ///     // arrange + act
    ///    let subject = PublishSubject<Int>()
    ///
    ///    subject
    ///    .subscribe(intObserver)
    ///    .disposed(by: bag)
    ///
    ///    // act
    ///    subject.onNext(9)
    ///
    ///    // assert
    ///    intObserver.assertNotComplete()
    public func assertNotComplete(file: StaticString = #file, line: UInt = #line) {
        XCTAssert(0 == completions, _ : "error observer was completed", file: file, line: line)
    }

    // MARK: internal functions

    internal func getElementOrFail(_ index: Int, file: StaticString, line: UInt ) -> Element? {
        guard index >= 0 && index < elements.count else {
            XCTFail("index out of bounds index ->[\(index)], count -> [\(elements.count)]", file: file, line: line)
            return nil
        }
        return self.elements[index]
    }

    internal func getElementByPrdicateOrFail(_ that: @escaping (Element) -> Bool, file: StaticString, line: UInt) -> Element? {
        let filtered = elements.filter { that($0) }
        guard filtered.count == 1 else {
            XCTFail("the pridicate returns an invalid count -> [\(filtered.count)]", file: file, line: line)
            return nil
        }
        return filtered.first!
    }

    internal func getErrorOrFail( file: StaticString, line: UInt) -> Error? {
        guard errors.count == 1 else {
            let message = errors.count == 0 ? "No errors present" : "More than one Error Present \(errors.count)"
            XCTFail(message, file: file, line: line)
            return nil
        }
        return self.errors[0]
    }
}
