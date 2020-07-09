//
//  LoadingIndicatorViewController.swift
//  TwitterAPIApp
//
//  Created by Fabian Schneider on 09.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import UIKit

class LoadingIndicatorViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white:0, alpha: 0.5)
        
        //blocks automatic constraint loading
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        //create manual constraints to center
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    }

}
