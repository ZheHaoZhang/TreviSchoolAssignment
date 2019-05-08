//
//  InputBoxViewController.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/7.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InputBoxViewController: UIViewController {

    @IBOutlet weak var columnTextField: UITextField!
    @IBOutlet weak var columnValidOutlet: UILabel!
    @IBOutlet weak var rowTextField: UITextField!
    @IBOutlet weak var rowValidOutlet: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var disposeBag = DisposeBag()
    private var viewModel: InputBoxViewModel {
        return InputBoxViewModel.init(columnText: columnTextField.rx, rowText: rowTextField.rx)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRx()
    }
    
    func setupRx() {
        
        viewModel.columnValid
            .bind(to: columnValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.rowValid
            .bind(to: rowValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.everythingValid.subscribe { (event) in
            let nextValue = event.element ?? false
            self.nextButton.isEnabled = nextValue
            self.nextButton.backgroundColor = nextValue ? UIColor.blue : UIColor.darkGray
            }.disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: {
                print("button Tapped")
                self.goToCollectionViewController()
            })
            .disposed(by: disposeBag)
    }

    func goToCollectionViewController() {
        let columnsCount = Int(columnTextField.text!)!
        let rowsCount = Int(rowTextField.text!)!
        let vc = CollectionViewController.simpleCreation(viewModel: CollectionViewModel.init(columnsCount: columnsCount, rowsCount: rowsCount))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
