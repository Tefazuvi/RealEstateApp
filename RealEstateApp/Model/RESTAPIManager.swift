//
//  RESTAPIManager.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/26/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation
import SwiftyJSON

struct login: Codable{
    var User: String
    var Pass: String
}

class RESTAPIManager: NSObject{
    
    let baseURL = "http://101a212a.ngrok.io/"
    static let sharedInstance = RESTAPIManager()
    static let SaveUserEndPoint = "Login/SaveUser";
    static let GetUserEndPoint = "Login/Authenticate";
    
    func saveUser(user: UserModel, onSuccess: @escaping() -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + RESTAPIManager.SaveUserEndPoint
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        
        //Set content type to application/json
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        //Set method to POST
        request.httpMethod = "POST"
        let jsonData = try! JSONEncoder().encode(user)
        request.httpBody = jsonData
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                onSuccess()
            }
        })
        task.resume()
    }
    
    
    func getUser(email: String,password: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + RESTAPIManager.GetUserEndPoint
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        
        //Set content type to application/json
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        //Set method to POST
        request.httpMethod = "POST"
        let jsonData = try! JSONEncoder().encode(login(
            User: email,
            Pass: password
        ))
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do {
                    let result = try JSON(data: data!)
                    onSuccess(result)
                } catch {
                    onFailure(error)
                }
            }
        })
        task.resume()
    }
}
