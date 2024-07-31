//
//  SimpleValidation.swift
//  RXSwifPractice
//
//  Created by Joy Kim on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


final class SimpleValidation:BaseViewController {
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    let usernameLabel = UILabel()
    let usernameTF = UITextField()
    let usernameStatus = UILabel()
    
    let passwordLabel = UILabel()
    let passwordTF = UITextField()
    let passwordStatus = UILabel()
    
    let doneButton = UIButton()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    validation()
        
    }
    
    override func configHierarchy() {
        view.addSubview(usernameLabel)
        view.addSubview(usernameTF)
        view.addSubview(usernameStatus)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTF)
        view.addSubview(passwordStatus)
        view.addSubview(doneButton)
        
    }
    
    override func configLayout() {
        
        usernameLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        usernameTF.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        usernameStatus.snp.makeConstraints { make in
            make.top.equalTo(usernameTF.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameStatus.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        passwordTF.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        passwordStatus.snp.makeConstraints { make in
            make.top.equalTo(passwordTF.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(passwordStatus.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
        }
        
    }
    
    override func configView() {
        usernameLabel.text = "Username"
        passwordLabel.text = "Password"
        usernameTF.borderStyle = .roundedRect
        passwordTF.borderStyle = .roundedRect
        usernameStatus.textColor = .red
        passwordStatus.textColor = .red
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = .green.withAlphaComponent(0.3)
        doneButton.setTitleColor(.black, for: .normal)
        
    }
    
    private func validation() {
        usernameStatus.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordStatus.text = "Password has to be at least \(minimalPasswordLength) characters"

        let usernameValid = usernameTF.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1)

        let passwordValid = passwordTF.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)

        usernameValid
            .bind(to: passwordTF.rx.isEnabled)
            .disposed(by: disposeBag)

        usernameValid
            .bind(to: usernameStatus.rx.isHidden)
            .disposed(by: disposeBag)

        passwordValid
            .bind(to: passwordStatus.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: doneButton.rx.isEnabled)
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }

    func showAlert() {
        let alert = UIAlertController(
            title: "제출완료",
            message: "가입 승인 대기중",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
