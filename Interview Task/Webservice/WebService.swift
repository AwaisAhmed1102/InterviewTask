//
//  WebService.swift
//  Interview Task
//
//  Created by Apple on 11/27/18.
//  Copyright © 2018 Dtech. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:Any]

class WebService{
    
    
    //MARK:- get username search result from server
    func getSearch(parameter: String, callback :@escaping (SearchResult) -> ()) {
        
        var result = SearchResult()
        
        let str = Constant.get_user_url + parameter
        var components = URLComponents(string: str)!
        
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! JSONDictionary
                
                if let name = dictionary["name"] as? String  {
                    result.name = name
                }
                if let email = dictionary["email"] as? String{
                    result.email = email
                }
                if let image = dictionary["avatar_url"] as? String {
                    result.imageUrl = image 
                }
                if let followerUrl  = dictionary["followers_url"] as? String {
                    result.FollowerUrl = followerUrl
                    
                }
                
            }
            
            DispatchQueue.main.async {
                callback(result )
            }
            
            }.resume()
        
    }
    
    //MARK:- get followers of user from server
    
    func getfollower(url: String, callback :@escaping ([FollowerModel]) -> ()) {
        
        var result = [FollowerModel]()
        
        
        var components = URLComponents(string: url)!
        
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let array = json as! Array<Any>
                
                for index  in array {
                    let data = index as! JSONDictionary
                    var follower = FollowerModel()
                    
                    if let name = data["login"] as? String {
                            follower.name = name
                    }
                    if let url = data["avatar_url"] as? String {
                        follower.image_url = url
                    }
                    
                    result.append(follower)
                    
                }
                print(array)
                
            }
            
            DispatchQueue.main.async {
                callback(result )
            }
            
            }.resume()
        
    }
    
    
    
    
    
}
