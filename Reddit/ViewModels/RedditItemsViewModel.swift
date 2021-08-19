//
//  RedditItemsViewModel.swift
//  Reddit
//
//  Created by Rajesh Bandarupalli on 08/18/21.
//

import Foundation

class RedditItemsViewModel {
    
    var apiHelper:ServicesProtocol = APIHelper.shared
    var childrenArr:[Child] = [Child]()
    var redditModel:RedditModel!{
        didSet {
            if let children = redditModel.data?.children {
                appendChildrensToArray(children: children)
            }
        }
    }
    
    convenience init(redditModel:RedditModel) {
        self.init()
        
        setRedditModel(newValue: redditModel)
    }
    func setRedditModel(newValue:RedditModel) {
        self.redditModel = newValue
    }
    func appendChildrensToArray(children:[Child]) {
        childrenArr.append(contentsOf: children)
    }
    
    var afterIndex:String {
        if let after = redditModel.data?.after, after.count > 0 {
            return after
        }
        return ""
    }
    
    func retriveItemsFromServer(after:String? = "", completion: @escaping() -> Void)
    {
        let endPoint = after?.count == 0 ? EndPoint() : EndPoint(urlParameters: ["after":after!])
        
        apiHelper.retrieveItems(endPoint: endPoint) { (model, erroe) in
            if let redditModel = model {
                self.redditModel = redditModel
                completion()
                DispatchQueue.main.async {
                    hideIndicator()
                }
            }
        }
    }
}
