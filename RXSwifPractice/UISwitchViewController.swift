//
//  UISwitchViewController.swift
//  RXSwifPractice
//
//  Created by Joy Kim on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class UISwitchViewController: BaseViewController {
    
    let mySwitch = UISwitch()

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwitch()
    }
    
    override func configHierarchy() {
        view.addSubview(mySwitch)
      
    }
    
    override func configLayout() {
        mySwitch.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        

    }
    
    override func configView() {
        view.backgroundColor = .white
        mySwitch.backgroundColor = .red.withAlphaComponent(0.3)
       
    }
    
    func setSwitch() {

        Observable.of(false)
            .bind(to: mySwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
}
