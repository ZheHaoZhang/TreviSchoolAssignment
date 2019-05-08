//
//  InputBoxViewModel.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/7.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InputBoxViewModel {

    //Output
    let columnValid: Observable<Bool>
    let rowValid: Observable<Bool>
    let everythingValid: Observable<Bool>
    
    
    init(columnText: Reactive<UITextField>, rowText: Reactive<UITextField>) {
    
        columnValid = columnText.text.orEmpty
            .map { Int($0) ?? 0 > 0}
            .share(replay: 1)
        
        rowValid = rowText.text.orEmpty
            .map { Int($0) ?? 0 > 0}
            .share(replay: 1)
        
        everythingValid = Observable.combineLatest(columnValid, rowValid) {$0 && $1}.share(replay: 1)
    
    }
}
