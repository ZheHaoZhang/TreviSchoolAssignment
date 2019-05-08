//
//  CollectionViewControllerCell.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/8.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class CollectionViewControllerCell: UICollectionViewCell {
   
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var myStackView: UIStackView!
    var disposeBag = DisposeBag()

    func setup(data: ColumnData){
        data.isSelected.subscribe { (event) in
            let nextValue = event.element ?? false
            self.backgroundColor = nextValue ? UIColor.highlightGreen : UIColor.clear
            self.doneButton.backgroundColor = nextValue ? UIColor.highlightGreen : UIColor.clear
            self.doneButton.isEnabled = nextValue
        }.disposed(by: disposeBag)
        
        for row in data.rows {
            let latticeView = LatticeView.init()
            latticeView.view1.backgroundColor = row.color1
            latticeView.view2.backgroundColor = row.color2

            myStackView.insertArrangedSubview(latticeView, at: row.row - 1)
            row.isSelected
                .map({ (isSelected) -> Bool in
                    return !isSelected
                })
                .bind(to: latticeView.titleLabel.rx.isHidden).disposed(by: disposeBag)
        }
    }
    
    deinit {
        print("deinit called")
    }
}
