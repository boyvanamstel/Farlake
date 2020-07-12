//
//  ResponderChainActions.swift
//  Farlake
//
//  Created by Boy van Amstel on 12/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

@objc protocol NavigationReversableAction: AnyObject {
    func popBack()
}
