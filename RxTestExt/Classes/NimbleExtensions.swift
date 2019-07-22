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
    func assertValueCount(_ count:Int, file: String = #file, line: UInt = #line) {
        expect(self.valueCount, file: file, line: line) == count
    }
    
    func assertThatAt(_ index: Int, that: @escaping(Element) -> Bool, file: String = #file, line: UInt = #line){
        
        expect(that(self.elements[index])) == true
    }
}

extension TestableObserver where Element: Comparable {
    
    func assertElements(_ recorded: Element..., file: String = #file, line: UInt = #line) {
        expect(self.elements, file: file, line: line) == recorded
    }
    
    func assertValueAt(_ index: Int, value: Element, file: String = #file, line: UInt = #line){
        expect(self.elements[index],  file: #file, line: #line) == value
    }
    
    func assertElementCount(_ expectedCount: Int, that: @escaping (Element) -> Bool, file: String = #file, line: UInt = #line) {
        expect(self.elements.filter(that).count, file: #file, line: #line ) == expectedCount
    }
    
    func assertNoError(file: String = #file, line: UInt = #line) {
        expect(self.errorCount, file: file, line: line) == 0
    }
}
