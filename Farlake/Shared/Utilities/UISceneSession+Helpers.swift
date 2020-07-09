//
//  UISceneSession+Helpers.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

/// A workaround for injecting dependencies into the scene delegates.
extension UISceneSession {
    private struct AssociatedKeys {
        static var servicesProvider = "ServicesProvider"
    }

    weak var servicesProvider: ServicesProvider! {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.servicesProvider) as? ServicesProvider
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.servicesProvider, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
