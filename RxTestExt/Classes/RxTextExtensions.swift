

import RxTest
import XCTest

extension TestableObserver {
    var elements: [Element] {
        return events.compactMap { $0.value.element }
    }
    
    var valueCount: Int {
        return events.filter{ $0.value.error == nil }.count
    }
    
    var errorCount: Int {
        return events.filter{ $0.value.error != nil }.count
    }
    
    func asssertValueCount(_ count:Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(count, valueCount, file: file, line: line)
    }
    
    func assertThatAt(_ index: Int, that: @escaping(Element) -> Bool, file: StaticString = #file, line: UInt = #line){
        XCTAssertTrue(that(elements[index]))
    }
}

extension TestableObserver where Element: Comparable {
    
    func assertElements(_ recorded: Element...) {
        XCTAssertEqual(elements, recorded, file: #file, line: #line )
    }
    
    func assertValueAt(_ index: Int, value: Element, file: StaticString = #file, line: UInt = #line){
         XCTAssertEqual(elements[index], value, file: #file, line: #line)
    }
    
    func assertElementCount(_ expectedCount: Int, that: (Element) -> Bool) {
        XCTAssertEqual(elements.filter(that).count, expectedCount, file: #file, line: #line )
    }
    
    func assertNoError() {
        XCTAssertEqual(0, errorCount, file: #file, line: #line )
    }
}
