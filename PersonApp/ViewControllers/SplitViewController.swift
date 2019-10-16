//
//  SplitViewController.swift
//  PersonApp
//
//  Created by Eva on 10/14/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredDisplayMode = .allVisible
        self.preferredPrimaryColumnWidthFraction = 1/5;

    }

}
