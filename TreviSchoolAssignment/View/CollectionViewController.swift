//
//  CollectionViewController.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/7.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    var disposeBag = DisposeBag()
    var columnsCount: Int = 0
    var rowsCount: Int = 0
    var selectedIndex: IndexPath?
    var viewModel: CollectionViewModel!
    var columnDatas: [ColumnData] = []{
        didSet{
            self.setupCollectionViewFlowLayout()
            self.collectionView.reloadData()
        }
    }

    class func simpleCreation(viewModel: CollectionViewModel) -> CollectionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
      vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.isScrollEnabled = false
        self.setupViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.disposeBag = DisposeBag()
        self.viewModel.stopRandom()
    }

    deinit {
        print("deinit called")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //螢幕旋轉相關
        DispatchQueue.main.async() {
            self.setupCollectionViewFlowLayout()
        }
    }
    
    func setupCollectionViewFlowLayout()  {
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 0
        let itemWidth: CGFloat = {
            let width = Int(view.frame.width) / columnDatas.count
            return CGFloat(width)
        }()
        let itemHeight: CGFloat = {
            var height = Int(view.frame.height) - Int(navigationController?.navigationBar.frame.height ?? 0)
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                let topPadding = window?.safeAreaInsets.top
                let bottomPadding = window?.safeAreaInsets.bottom
                height = height - Int(topPadding ?? 0) - Int(bottomPadding ?? 0)
            }
            return CGFloat(height)
        }()
        layout?.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout?.invalidateLayout()
    }
    func setupViewModel() {
        self.viewModel.columnDatasSubjects.subscribe({ (event) in
            let nextValue = event.element ?? []
            self.columnDatas = nextValue
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnDatas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewControllerCell
        let data = columnDatas[indexPath.row]
        // Configure the cell
        cell.setup(data: data)
        cell.doneButton.addTarget(self, action: #selector(self.btnAction(_:)), for: .touchUpInside)

        return cell
    }
    
    @objc func btnAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: self.collectionView as UIView)
        let indexPath: IndexPath! = self.collectionView.indexPathForItem(at: point)
        print("row is = \(indexPath.row) && section is = \(indexPath.section)")

        self.viewModel.removeHighlightAction()
    }
}
