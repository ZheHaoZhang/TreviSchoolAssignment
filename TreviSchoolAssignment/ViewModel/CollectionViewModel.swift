//
//  CollectionViewModel.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/8.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionViewModel {
    
    public let columnDatasSubjects = BehaviorRelay<[ColumnData]>(value: [])
    private var timer: DispatchSourceTimer!
    private let columnsCount: Int
    private let rowsCount: Int
    private var highlightSubject: (x: Int, y: Int)?{
        willSet{
            guard let highlight = highlightSubject else { return }
            self.setHighlight(x: highlight.x, y: highlight.y, isHighlight: false)
        }
        didSet{
            guard let highlight = highlightSubject else { return }
            self.setHighlight(x: highlight.x, y: highlight.y, isHighlight: true)
        }
    }
    
    private var columnDatas: [ColumnData] = [] {
        didSet{
            columnDatasSubjects.accept(columnDatas)
        }
    }
    
    init(columnsCount: Int, rowsCount: Int) {
        self.columnsCount = columnsCount
        self.rowsCount = rowsCount
        self.createＣolumnData()
        self.runRandom(interval: .milliseconds(10000)) //Q3 Random 開始
    }
    
    deinit {
        print("deinit called")
    }
    
    private func createＣolumnData()  {
        self.columnDatas = (1 ... columnsCount).map({ (i) -> ColumnData in
            let column = ColumnData.init(column: i)
            column.rows = (1...rowsCount).map({ (i) -> RowData in
                let rowData = RowData.init(row: i)
                return rowData
            })
            return column
        })
    }
    
    private func runRandom(interval: DispatchTimeInterval)  {
        self.timer = Utils.makeTimerSource(interval: interval) {[weak self] in
            self?.highlightSubject = self?.getHighlightPosition()
        }
    }
    
    private func getHighlightPosition() -> (x: Int, y: Int) {
        let highlightColumnNumber = Int.random(in: 1...columnsCount)
        let highlightRowNumber = Int.random(in: 1...rowsCount)
        return (highlightColumnNumber, highlightRowNumber)
    }
    
    private func setHighlight(x: Int, y: Int, isHighlight: Bool)  {
        let x = x-1, y = y-1
        columnDatas[x].isSelected.onNext(isHighlight)
        columnDatas[x].rows[y].isSelected.onNext(isHighlight)
    }
}

extension CollectionViewModel {
    
    func stopRandom() {
        self.timer.cancel()
    }
    
    func removeHighlightAction() {
        self.highlightSubject = nil
    }
}
