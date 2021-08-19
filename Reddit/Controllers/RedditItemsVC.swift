//
//  RedditItemsVC.swift
//  Reddit
//
//  Created by Rajesh Bandarupalli on 08/18/21.
//

import UIKit
import MBProgressHUD

class RedditItemsVC: UIViewController {

    var viewModel:RedditItemsViewModel?
    
    var redditView:RedditItemsView {
        return self.view as! RedditItemsView
    }
    convenience init(vm: RedditItemsViewModel) {
        self.init()
        self.viewModel = vm
    }
    override func loadView() {
        self.view = RedditItemsView(viewModel: self.viewModel!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reddit Items"
        loadItemsFromServer()
    }
    func loadItemsFromServer() {
        showIndicator()
        
        viewModel?.retriveItemsFromServer(completion: {
            DispatchQueue.main.async {
                self.redditView.tableview.reloadData()
                hideIndicator()
            }
        })
    }
    
}
