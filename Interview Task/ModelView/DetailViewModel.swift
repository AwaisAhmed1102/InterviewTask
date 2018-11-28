//
//  DetailViewModel.swift
//  Interview Task
//
//  Created by Apple on 11/27/18.
//  Copyright © 2018 Dtech. All rights reserved.
//

import Foundation
import UIKit

class DetailModelView {
    
    private var personData = SearchResult()
    private var followers = [FollowerModel]()
    private var searchData = SearchDataModel()
    
   
    
}
extension DetailModelView{
    
    func setPersonData(data:SearchResult){
        self.personData=data
    }
    func getPersonName()->String{
        return self.personData.name
    }
    func getPersonEmail()->String{
        return self.personData.email
    }
    func getPersonImage()->String{
        return self.personData.imageUrl
    }
    func setSearchData(data:String){
        self.searchData.searchData=data
    }
    func getFollowersCount()->Int{
        return self.followers.count
    }
    
    func getFollowerURL()->String{
        return self.personData.FollowerUrl
    }
    func updateResult(data:[FollowerModel]){
        self.followers=data
    }
    func returnFollower(index:Int)-> FollowerModel {
        return self.followers[index]
    }
    
    func getFollowersFromServer(completion :@escaping (_ errorString: String?)->Void ){
        
        let param = self.getFollowerURL()
        
        WebService().getfollower(url:param){ [weak self] data in
            print(data)
            if data == nil {
                completion("No User Found")
            }else{
                self?.updateResult(data: data)
                completion(nil)
            }
            
        }
    }
    
    func getImage(index:Int,completion :@escaping (_ errorString: String?,_ imageData:Data?,_ image:UIImage?)->Void){
        DispatchQueue.global().async { [weak self] in
            if let urlString = self?.followers[index].image_url{
                if let cachedImage = ImageCache.imageCacher.imageCache.object(forKey: urlString as NSString) {
                    completion(nil,nil, cachedImage)
                }else if let data = try? Data(contentsOf: URL(string: urlString)!) ,let image = UIImage(data: data) {
                    ImageCache.imageCacher.imageCache.setObject(image, forKey: urlString as NSString)
                    completion(nil,data,nil)
                }else{
                    completion("No image Found",nil,nil)
                }
                
            }
            
        }
    }
    
    
    func getImage(parameter:String?,completion :@escaping (_ errorString: String?,_ imageData:Data?,_ image:UIImage?)->Void){
        DispatchQueue.global().async {
            if let urlString = parameter {
                
                
                
                if let cachedImage = ImageCache.imageCacher.imageCache.object(forKey: urlString as NSString) {
                    completion(nil,nil, cachedImage)
                }else if let data = try? Data(contentsOf: URL(string: urlString)!),let image = UIImage(data: data) {
                    ImageCache.imageCacher.imageCache.setObject(image, forKey: urlString as NSString)
                    completion(nil,data,nil)
                }else{
                    completion("No image Found",nil,nil)
                }
                
            }
            
        }
    }
}
