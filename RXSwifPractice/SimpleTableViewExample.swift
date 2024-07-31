//
//  SimpleTableViewExample.swift
//  RXSwifPractice
//
//  Created by Joy Kim on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


final class SimpleTableViewExample: BaseViewController {
    
    let tableView = UITableView()
    let items = Observable.just(
        (0..<20).map { "\($0)" }
    )
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
    
    override func configHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        tableView.backgroundColor = .blue
        configTableView()
    }
    
    private func configTableView() {
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)


        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                DefaultWireframe.presentAlert("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)

    }
    
    
}
