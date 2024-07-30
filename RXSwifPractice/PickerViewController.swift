//
//  PickerViewController.swift
//  RXSwifPractice
//
//  Created by Joy Kim on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PickerViewController: BaseViewController {
    
    let pickerView = UIPickerView()
    let label = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPickerView()
    }
    
    override func configHierarchy() {
        view.addSubview(pickerView)
        view.addSubview(label)
    }
    
    override func configLayout() {
        pickerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        label.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaInsets).inset(50)
        }
    }
    
    override func configView() {
        pickerView.backgroundColor = .red.withAlphaComponent(0.3)
        label.backgroundColor = .blue.withAlphaComponent(0.3)
    }
    
    func setPickerView() {

        Observable.just(["한식", "일식", "중식"]).bind(to: pickerView.rx.itemTitles) {_row, element in
            return element
        }.disposed(by: disposeBag)
   
        pickerView.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
}
