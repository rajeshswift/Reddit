//
//  APIHelperMock.swift
//  Reddit
//
//  Created by Rajesh Bandarupalli on 08/18/21.
//

import Foundation


class APIHelperMock: ServicesProtocol {
    
    public static var shared = APIHelperMock()
    
    private init () {}
    
    func retrieveItems(endPoint: EndPoint, onCompletion: @escaping (RedditModel?, Error?) -> Void) {
        let jsonData = readJSON("RedditItems")
        do {
            let codableModel = try JSONDecoder().decode(RedditModel.self, from: jsonData)
            onCompletion(codableModel,nil)
            print(codableModel.kind)
        } catch let error {
            onCompletion(nil,error)
        }
    }
}
