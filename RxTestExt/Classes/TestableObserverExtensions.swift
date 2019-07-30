//
//  TestableObserverExtensions.swift
//  Nimble
//
//  Created by Mark on 22/07/2019.
//

import Foundation
import RxTest

extension TestableObserver {
    var elements: [Element] {
        return events.compactMap { $0.value.element }
    }

    var valueCount: Int {
        return elements.count
    }

    var errors: [Error] {
        return events.compactMap { $0.value.error }
    }

    var errorCount: Int {
        return errors.count
    }

    var completeions: Int {
        return events.filter { $0.value.isCompleted }.count
    }
}
