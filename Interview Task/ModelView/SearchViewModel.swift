//
//  SearchViewModel.swift
//  Interview Task
//
//  Created by Apple on 11/26/18.
//  Copyright © 2018 Dtech. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel{
    
    private var result = [SearchResult]()
    private var searchData = SearchDataModel()
    
}

extension SearchViewModel {
    
    func getResultCount()->Int{
        return result.count
    }

    func getResultIndex(index:Int)->SearchResult{
        return result[index]
    }
    
    func updateResult(data:SearchResult) {
        
        self.result.removeAll()
        self.result.append(data)
    }
    
    func resturnFirstPersonData()-> SearchResult{
        
        var data =  SearchResult()
        data.name = self.result[0].name
        data.email = self.result[0].email
        data.imageUrl = self.result[0].imageUrl
        data.FollowerUrl = self.result[0].FollowerUrl
        return data
    }
    
    func removeResult(){
        self.result.removeAll()
    }
    
    func updateSearchData(string:String){
        self.searchData.searchData = string
    }
    
    func getSearchData()->String{
        return self.searchData.searchData
    }
    
    func getSearchResultFromServer(completion :@escaping (_ errorString: String?)->Void ){
        
        let param = self.getSearchData()
        
        WebService().getSearch(parameter:param){ [weak self] data in
            print(data)
            if data.name == "" && data.email == "" && data.imageUrl == "" {
                self?.removeResult()
                completion("No User Found")
            }else{
                self?.updateResult(data: data)
                completion(nil)
            }
            
        }
    }
    func getImage(completion :@escaping (_ errorString: String?,_ imageData:Data?,_ image:UIImage?)->Void){
        DispatchQueue.global().async { [weak self] in
            if let urlString = self?.result[0].imageUrl{
                
                
                
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
