//
//  ColumnData.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/8.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit
import RxSwift

class ColumnData {
    var column: Int = 0
    var rows: [RowData] = []
    let isSelected = BehaviorSubject(value: false)

    init(column: Int) {
        self.column = column
    }
}
class RowData {
    var row: Int = 0
    var titel = "random"
    var color1 = UIColor.lightGray
    var color2 = UIColor.darkGray
    let isSelected = BehaviorSubject(value: false)

    init(row: Int) {
        self.row = row
        self.color1 = LatticeLightColors[(row-1)%3]
        self.color2 = LatticeColors[(row-1)%3]
    }
}




