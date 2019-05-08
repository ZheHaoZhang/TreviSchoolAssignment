//
//  CollectionViewController.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/7.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    var columnsCount: Int = 0
    var rowsCount: Int = 0
    var selectedIndex: IndexPath?
    
    lazy var itemWidth: CGFloat = {
        let width = Int(view.frame.width) / columnsCount
        return CGFloat(width)
    }()
    lazy var itemHeight: CGFloat = {
        var height = Int(view.frame.height) - Int(navigationController?.navigationBar.frame.height ?? 0)
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let bottomPadding = window?.safeAreaInsets.bottom
            height = height - Int(topPadding ?? 0) - Int(bottomPadding ?? 0)
        }
        return CGFloat(height)
    }()
    
    class func simpleCreation(columnsCount: Int, rowsCount: Int) -> CollectionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        vc.columnsCount = columnsCount
        vc.rowsCount = rowsCount
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.isScrollEnabled = false
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 0
        layout?.itemSize = CGSize(width: self.itemWidth, height: self.itemHeight)

    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnsCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewControllerCell

        // Configure the cell
    
        return cell
    }
}
