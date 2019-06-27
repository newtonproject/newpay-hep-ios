// Copyright Newton Foundation. All rights reserved.

import Foundation

struct URLScheme {
    let app: String
    let module: String
    let head: String
    let param: [String:String]
    
    init(
        app: String,
        module: String,
        head: String,
        param: [String:String]
        ){
        self.app = app
        self.module = module
        self.head = head
        self.param = param
    }
}


class QRURLParser {
    
    /// Parse URL
    static func schemeFrom(string:String) -> URLScheme {
        var app = ""
        var head = ""
        var module = ""
        var param = [String:String]()
        var input = string

        if let range = input.range(of: "://") {
            app = String(input[..<range.lowerBound])
            input = String(input[range.upperBound...])
            if let range1 = input.range(of: "/") {
                head = String(input[..<range1.lowerBound])
                input = String(input[range1.upperBound...])
                if let range2 = input.range(of: "?") {
                    module = String(input[..<range2.lowerBound])
                    input = String(input[range2.upperBound...])
                    for pair in input.components(separatedBy: "&") {
                        let key_value = pair.components(separatedBy: "=")
                        if key_value.count == 2 {
                            param[key_value[0]] = key_value[1]
                        }
                        else if key_value.count > 2 {
                            let tempStr = key_value[0] + "="
                            param[key_value[0]] = pair.components(separatedBy: tempStr).last
                        }
                        
                    }
                }
            }

        }

        return URLScheme(app: app, module: module, head: head, param: param)
    }
}
