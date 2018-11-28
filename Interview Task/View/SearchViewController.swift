//
//  SearchViewController.swift
//  Interview Task
//
//  Created by Apple on 11/26/18.
//  Copyright © 2018 Dtech. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var searchVM = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  

}

extension SearchViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.getResultCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = searchVM.getResultIndex(index: indexPath.row)
        let cell:SearchTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "UserCell") as! SearchTableViewCell
        cell.selectionStyle = .none
        cell.lbl_name.text = person.name
        cell.lbl_email.text = person.email
        cell.img_avatar.image = UIImage(named: "avatar")
        self.searchVM.getImage(completion: { errorMessage , Data , image in
            
            if errorMessage != nil {
                
            }else if image != nil{
                DispatchQueue.main.async {
                    cell.img_avatar.image = image
                }
            }else{
                
                if let image = UIImage(data: Data!) {
                    DispatchQueue.main.async {
                        cell.img_avatar.image = image
                    }
                }
            }
            
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let person = searchVM.getResultIndex(index: indexPath.row)
        
       // let controller : DetailViewController = DetailViewController(data: self.searchVM.resturnFirstPersonData())
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        controller.detailVM.setPersonData(data: person)
        
        
        self.show(controller, sender: self)
        
        
        
    }
    
    
}
extension SearchViewController:UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        if let searchString =  self.searchBar.text {
            self.searchVM.updateSearchData(string: searchString)
            self.searchVM.getSearchResultFromServer(completion: { [weak self] errorMessage in
                
                if let message = errorMessage {
                    
                    self?.tableView.reloadData()
                    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    
                    self?.present(alert, animated: true, completion: nil)
                    
                    
                }else{
                    self?.tableView.reloadData()
                }
                
            })
        }
        self.searchBar.resignFirstResponder()
        
    }
    
}
