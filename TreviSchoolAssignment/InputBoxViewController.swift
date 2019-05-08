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
    lazy var columnValid: Observable<Bool> = {
        return columnTextField.rx.text.orEmpty
            .map { Int($0) ?? 0 > 0}
            .share(replay: 1)
    }()
    lazy var rowValid: Observable<Bool> = {
        return rowTextField.rx.text.orEmpty
            .map { Int($0) ?? 0 > 0}
            .share(replay: 1)
    }()
    lazy var everythingValid = Observable.combineLatest(columnValid, rowValid) {$0 && $1}.share(replay: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRx()
    }
    func setupRx() {
        
        columnValid
            .bind(to: columnValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        rowValid
            .bind(to: rowValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid.subscribe { (event) in
            let nextValue = event.element ?? false
            self.nextButton.isEnabled = nextValue
            self.nextButton.backgroundColor = nextValue ? UIColor.blue : UIColor.darkGray
            }.disposed(by: disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
