//
//  TableViewViewController.swift
//  RXSwifPractice
//
//  Created by Joy Kim on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TableViewViewController: BaseViewController {
    
    let tableView = UITableView()
    let label = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    override func configHierarchy() {
        view.addSubview(tableView)
        view.addSubview(label)
      
    }
    
    override func configLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        label.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaInsets).inset(50)
        }

    }
    
    override func configView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .red.withAlphaComponent(0.3)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        label.backgroundColor = .blue.withAlphaComponent(0.3)
    }
    
    func setTableView() {

        Observable.just(["한식", "일식", "중식"]).bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }.disposed(by: disposeBag)
   
        tableView.rx.modelSelected(String.self)
            .map {data in
                "\(data)를 찾습니다."
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
}

