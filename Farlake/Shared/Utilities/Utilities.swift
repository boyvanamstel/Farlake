//
//  Utilities.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

/// Initializes object and applies updates in a closure.
/// - Parameters:
///   - item: The item to modify.
///   - update: Closure that updates the item.
/// - Throws: Any throwable errors.
/// - Returns: The instantiated object with the updates applied.
func with<T>(_ item: T, update: (inout T) throws -> Void) rethrows -> T {
    var this = item
    try update(&this)
    return this
}
