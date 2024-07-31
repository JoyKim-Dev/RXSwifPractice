//
//  BasicOperatorViewController.swift
//  RXSwifPractice
//
//  Created by Joy Kim on 7/30/24.
//

import UIKit
import RxSwift


final class BasicOperatorViewController:BaseViewController {
    
    let justItem = [1,2,3,4,5]
    let ofItemA = [1,2,3,4,5]
    let ofItemB = [1,2,3,4,5,6,7,8,9,10]
    let fromItem = ["a", "b", "c"]
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observableJust()
        observableOf()
        observableFrom()
        observableRepeat()
    }
    
    func observableJust() {
        
        Observable.just(justItem)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just completed")
            } onDisposed: {
                print("just disposed")
            }
            .disposed(by: disposeBag)

    }
    func observableOf() {
        
        Observable.of(ofItemA, ofItemB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of completed")
            } onDisposed: {
                print("of disposed")
            }
            .disposed(by: disposeBag)
    }
    func observableFrom() {
        
        Observable.from(fromItem)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from completed")
            } onDisposed: {
                print("from disposed")
            }
            .disposed(by: disposeBag)
    }
    func observableRepeat() {
        
        Observable.repeatElement(fromItem)
            .take(3)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat completed")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)
    }

    
}
