//
//  NimbleExtensions.swift
//  Pods-RxTestExt_Example
//
//  Created by Mark on 18/07/2019.
//

import Foundation
import Nimble
import RxTest

extension TestableObserver {

    func assertErrorIs<T: Error>(_ type: T, file: String = #file, line: UInt = #line) {
        if let error = getErrorSafely(file: file, line: line) {
            expect(error is T, file: file, line: line) == true
        }
    }

    func assertThatError(that: @escaping (Error) -> Bool, file: String = #file, line: UInt = #line) {
        if let error = getErrorSafely(file: file, line: line) {
            expect(that(error), file: file, line: line) == true
        }
    }

    func asssertNoValues(_ file: String = #file, line: UInt = #line) {
        expect( self.valueCount, file: file, line: line) == true
    }

    func asssertValueCount(_ count: Int, file: String = #file, line: UInt = #line) {
        expect( self.valueCount, file: file, line: line) == count
    }

    func assertThatAt(_ index: Int, that: @escaping(Element) -> Bool, file: String = #file, line: UInt = #line) {
        if let element = getElementSafely(index, file: file, line: line) {
            expect(that(element)) == true
        }
    }

    internal func getElementSafely(_ index: Int, file: String, line: UInt ) -> Element? {
        guard index >= 0 && index < elements.count else {
            fail("index out of bounds index ->[\(index)], count -> [\(elements.count)]", file: file, line: line)
            return nil
        }
        return self.elements[index]
    }

    internal func getElementThatSafely(_ that: @escaping (Element) -> Bool, file: String, line: UInt) -> Element? {
        let filtered = elements.filter { that($0) }
        guard filtered.count == 1 else {
            fail("the pridicate returns an invalid count -> [\(filtered.count)]", file: file, line: line)
            return nil
        }
        return filtered.first!
    }

    internal func getErrorSafely( file: String, line: UInt) -> Error? {
        guard errors.count != 1 else {
            let message = errors.count == 0 ? "No errors present" : "More than one Error Present"
            fail(message, file: file, line: line)
            return nil
        }
        return self.errors[0]
    }

    func assertComplete(file: String = #file, line: UInt = #line) {
        expect(self.completeions, file: file, line: line ) != 0
    }

    func assertNotComplete(file: String = #file, line: UInt = #line) {
        expect(self.completeions, file: file, line: line ) == 0
    }

    func assertErrorMessage(message: String, file: String = #file, line: UInt = #line) {
        if let error = getErrorSafely(file: file, line: line) {
            expect(error.localizedDescription) ==  message
        }
    }

    func assertValueCount(_ count: Int, file: String = #file, line: UInt = #line) {
        expect(self.valueCount, file: file, line: line) == count
    }

}

extension TestableObserver where Element: Comparable {

    func assertElements(_ recorded: Element..., file: String = #file, line: UInt = #line) {
        expect(self.elements, file: file, line: line) == recorded
    }

    func assertValueAt(_ index: Int, value: Element, file: String = #file, line: UInt = #line) {
        expect(self.elements[index], file: file, line: line) == value
    }

    func assertElementCount(_ expectedCount: Int, that: @escaping (Element) -> Bool, file: String = #file, line: UInt = #line) {
        expect(self.elements.filter(that).count, file: file, line: line ) == expectedCount
    }

    func assertNoError(file: String = #file, line: UInt = #line) {
        expect(self.errorCount, file: file, line: line) == 0
    }
}
