//
//  EndPoint.swift
//  Reddit
//
//  Created by Rajesh Bandarupalli on 08/18/21.
//

import Foundation
enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
}

class EndPoint {
    var path:String = ""
    var urlParameters:[String:Any]
    var method: HTTPMethod = HTTPMethod.get

    init(path:String? = "", urlParameters:[String:Any]? = [:], method:HTTPMethod? = .get) {
        self.path = path!
        self.urlParameters = urlParameters!
        self.method = method!
    }
    
}
