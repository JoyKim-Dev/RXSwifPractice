//
//  AddingNumbers.swift
//  RXSwifPractice
//
//  Created by Joy Kim on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AddingNumbers:BaseViewController {
    
    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    let plusImageView = UIImageView()
    let lineView = UIView()
    
    let resultLabel = UILabel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configHierarchy() {
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(resultLabel)
        view.addSubview(plusImageView)
        view.addSubview(lineView)
    }
    
    override func configLayout() {
        number1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
        }
        number2.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(number1.snp.bottom).offset(20)
            make.width.equalTo(200)
        }
        
        number3.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(number2.snp.bottom).offset(20)
            make.width.equalTo(200)
        }
        
        plusImageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.top.equalTo(number2.snp.bottom).offset(20)
            make.trailing.equalTo(number3.snp.leading).offset(-2)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(number3.snp.bottom).offset(20)
            make.width.equalTo(220)
            make.centerX.equalTo(view)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.width.equalTo(220)
        }
    }
    
    override func configView() {
        combineLatest()
        number1.layer.borderWidth = 1
        number1.layer.borderColor = UIColor.lightGray.cgColor
        number1.borderStyle = .roundedRect
        number2.layer.borderWidth = 1
        number2.layer.borderColor = UIColor.lightGray.cgColor
        number2.borderStyle = .roundedRect
        number3.layer.borderWidth = 1
        number3.layer.borderColor = UIColor.lightGray.cgColor
        number3.borderStyle = .roundedRect
        number1.textAlignment = .right
        number2.textAlignment = .right
        number3.textAlignment = .right

        resultLabel.textAlignment = .right
        lineView.backgroundColor = .black
        plusImageView.image = UIImage(systemName: "plus")
        plusImageView.image?.withTintColor(.black)
    }
    
    
    private func combineLatest(){
        
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { text1, text2, text3 in
            return (Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0)
        }
        .map{ $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
}
