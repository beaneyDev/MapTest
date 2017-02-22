//
//  SplashViewController.swift
//  MapTest
//
//  Created by Matt Beaney on 27/11/2016.
//  Copyright © 2016 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        spinner.startAnimating()
        on.delay(1.0, task: {
            on.main {
                self.performSegue(withIdentifier: "home", sender: nil)
            }
        })
    }
}
