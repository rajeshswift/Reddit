//
//  RedditItemsView.swift
//  Reddit
//
//  Created by Rajesh Bandarupalli on 08/18/21.
//

import Foundation
import UIKit



class RedditItemsView: UIView {

    var viewModel:RedditItemsViewModel?
    var tableview = UITableView()
    var isServiceCallinProgress = false

    init(viewModel: RedditItemsViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        configureView()
    }
    
    func configureView() {
        self.addSubview(tableview)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 190.0
        tableview.register(ItemsTableViewCell.self, forCellReuseIdentifier: ItemsTableViewCell.identifer)
        tableview.tableFooterView = UIView()
        tableview.anchor(top: self.topAnchor, paddingTop: 0, bottom: self.bottomAnchor, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 0, right: self.trailingAnchor, paddingRight: 0, centerX: nil, centerY: nil, width: 0, height: 0)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RedditItemsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.childrenArr.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: ItemsTableViewCell.identifer) as? ItemsTableViewCell
        itemCell?.configureCell(child: (viewModel?.childrenArr[indexPath.row])!)
        return itemCell ?? UITableViewCell()
    }
}
extension RedditItemsView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if isServiceCallinProgress == false {
                showIndicator()
                isServiceCallinProgress = !isServiceCallinProgress
                print(" you reached end of the table")
                viewModel?.retriveItemsFromServer(after: self.viewModel?.afterIndex ,completion: {
                    self.isServiceCallinProgress = !self.isServiceCallinProgress
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                        hideIndicator()
                    }
                })
            }
            
        }
    }
}
