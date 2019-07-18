

import RxTest
import XCTest

extension TestableObservable where Element: Comparable {
    var elements: [Element] {
        return self.recordedEvents.compactMap { $0.value.element }
    }
    
    var errorCount: Int {
        return self.recordedEvents.filter{ $0.value.error != nil }.count
    }
    
    func assertElements(_ recorded: Element...) {
        XCTAssertEqual(self.elements, recorded, file: #file, line: #line )
    }
    
    func assertElementCount(_ expectedCount: Int, that: (Element) -> Bool) {
        XCTAssertEqual(self.elements.filter(that).count, expectedCount, file: #file, line: #line )
    }
    
    func assertNoError() {
        XCTAssertEqual(0, errorCount, file: #file, line: #line )
    }
}
