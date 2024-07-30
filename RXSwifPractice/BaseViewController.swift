//
//  BaseViewController.swift
//  RXSwifPractice
//
//  Created by Joy Kim on 7/30/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configHierarchy()
        configLayout()
        configView()
    }
    
    
    func configHierarchy() {}
    func configLayout() {}
    func configView() {}
}
