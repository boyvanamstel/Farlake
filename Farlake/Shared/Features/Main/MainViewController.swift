//
//  ViewController.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func didFinish()
}

// Contains the intial app state.
final class MainViewController: UIViewController {
    weak var delegate: MainViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate?.didFinish()
    }
}
