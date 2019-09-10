//
//  TestableObserverExtensions.swift
//  Nimble
//
//  Created by Mark on 22/07/2019.
//

import Foundation
import RxTest

extension TestableObserver {
    
    /// An array of all the elements recored by the observer
    public var elements: [Element] {
        return events.compactMap { $0.value.element }
    }

    /// The Number of elements recorded by the observer
    public var valueCount: Int {
        return elements.count
    }

    /// An array of all the errors recorded by the observer
    public var errors: [Error] {
        return events.compactMap { $0.value.error }
    }

    /// The number of errors recorded by the observer
    public var errorCount: Int {
        return errors.count
    }

    /// The number of completions recorded by the observer
    public var completions: Int {
        return events.filter { $0.value.isCompleted }.count
    }
}
