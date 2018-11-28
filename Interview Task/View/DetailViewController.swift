//
//  DetailViewController.swift
//  Interview Task
//
//  Created by Apple on 11/27/18.
//  Copyright © 2018 Dtech. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_profilePic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var detailVM = DetailModelView()
    
    
    
    
//    convenience init() {
//        self.init(data: nil)
//    }
    
    init(data: SearchResult) {
        self.detailVM.setPersonData(data: data)
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        self.detailVM.getFollowersFromServer(completion: { [weak self] errorMessage in

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
        
        // Do any additional setup after loading the view.
    }
    
    func setData(){
        
        self.lbl_name.text = self.detailVM.getPersonName()
        self.lbl_email.text = self.detailVM.getPersonEmail()
        
        self.detailVM.getImage(parameter:self.detailVM.getPersonImage(),completion: { errorMessage , Data , image in
            
            if errorMessage != nil {
                
            }else if image != nil{
                DispatchQueue.main.async {
                    self.img_profilePic.image = image
                }
            }else{
                
                if let image = UIImage(data: Data!) {
                    DispatchQueue.main.async {
                       self.img_profilePic.image = image
                    }
                }
            }
            
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailVM.getFollowersCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.detailVM.returnFollower(index: indexPath.row)
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FollowerData") as! FollowerTableViewCell
        
        cell.lbl_name.text = data.name
        cell.img_Follower.image = UIImage(named: "avatar")
        self.detailVM.getImage(index:indexPath.row,completion: { errorMessage , Data , image in
            
            if errorMessage != nil {
                
            }else if image != nil {
                DispatchQueue.main.async {
                    cell.img_Follower.image = image
                }
            }else{
                
                if let image = UIImage(data: Data!) {
                    DispatchQueue.main.async {
                        cell.img_Follower.image = image
                    }
                }
            }
            
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Followers"
    }
}
