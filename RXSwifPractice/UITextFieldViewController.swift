//
//  UITextFieldViewController.swift
//  RXSwifPractice
//
//  Created by Joy Kim on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class UITextFieldViewController: BaseViewController {
    
    let signName = UITextField()
    let signEmail = UITextField()
    let simpleLabel = UILabel()
    let button = UIButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSign()
    }
    
    override func configHierarchy() {
        view.addSubview(signName)
        view.addSubview(signEmail)
        view.addSubview(button)
        view.addSubview(simpleLabel)
        
    }
    
    override func configLayout() {
        signName.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        signEmail.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(signName.snp.bottom).offset(10)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaInsets).inset(50)
        }
        simpleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(signEmail.snp.bottom).offset(10)
        }
        
    }
    
    override func configView() {
        view.backgroundColor = .white
        signName.backgroundColor = .red.withAlphaComponent(0.3)
        signEmail.backgroundColor = .red.withAlphaComponent(0.3)
        button.backgroundColor = .blue.withAlphaComponent(0.3)
    }
    func showAlert() {
        let alert = UIAlertController(
            title: "제출",
            message: "제출하시겠습니까?",
            preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel) // cancel
       
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
        
    }
    func setSign() {
        
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { value1, value2 in
            return "이름은 \(value1)이고, 이메일은 \(value2)입니다"
        }.bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty.map { $0.count < 4 }
            .bind(to: signEmail.rx.isHidden, button.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty.map { $0.count > 4 }
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        button.rx.tap.subscribe {_ in
            self.showAlert()
        }.disposed(by: disposeBag)
        
    }
}
