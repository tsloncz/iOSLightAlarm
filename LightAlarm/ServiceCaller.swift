//
//  ServiceCaller.swift
//  LightAlarm
//
//  Created by Tim Sloncz on 1/24/16.
//  Copyright © 2016 Tim Sloncz. All rights reserved.
//

//
//  RESTCallManager.swift
//  DFW Trails
//
//  Created by Tim Sloncz on 12/23/15.
//  Copyright © 2015 Tim Sloncz. All rights reserved.
//

import Foundation

protocol ServiceCallProtocol {
    func updateData(data: NSArray)
}

class ServiceCaller {
    var delegate: ServiceCallProtocol!
    
    init(){}
    
    init(invoker: ServiceCallProtocol) {
        self.delegate = invoker
    }
    
    var responseCompletionHandler = {
        print("response")
    }
    var response: NSArray!
    
    func makeCall(uri: String) -> NSArray {
        
        if let url = NSURL(string: uri) {
            
            let urlRequest = NSURLRequest(URL: url)
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            let task = session.dataTaskWithRequest(urlRequest, completionHandler: {
                (data, response, error) in
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                guard error == nil else {
                    print("error calling GET on /posts/1")
                    print(error)
                    return
                }
                // parse the result as JSON, since that's what the API provides
                var post: NSArray
                do {
                    post = try NSJSONSerialization.JSONObjectWithData(responseData,
                        options: []) as! NSArray
                    self.response = post
                    
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
                
                // Tell invoker that we got data so update
                self.delegate.updateData(self.response)
            })
            task.resume()
        } else {
            print("Error: cannot create URL")
        }
        
        if response != nil {
            return response
        } else {
            return []
        }
    }
    
    func getJson() -> NSDictionary {
        return [:]
    }
}