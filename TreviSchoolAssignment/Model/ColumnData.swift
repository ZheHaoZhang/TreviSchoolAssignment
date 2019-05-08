//
//  ColumnData.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/8.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit
import RxSwift

struct ColumnData {
    let column: Int
    let rows: row
    let isSelected: Observable<Bool>
}
struct row {
    let row: Int
    let isSelected: Observable<Bool>

}
