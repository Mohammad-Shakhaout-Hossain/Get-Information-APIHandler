//
//  GetDataViewController.swift
//  Get Information
//
//  Created by Shakhawat Hossain Shakib on 8/12/20.
//

import UIKit

class GetDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var getTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var infoVar: [[String: String]]?
    private var searchedInfoVar: [[String: String]]?
    
    var getInfo: [String: String]?
    
    var errorMessage = ""
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        ApiHandler().getApiInfo(searchTerm: "") { (dataArray) in
            
            self.infoVar = dataArray
            print("successfull: \(dataArray)")
            
            self.getTableView.delegate = self
            self.getTableView.dataSource = self
            self.getTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoVar?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GetDataTableViewCell.reuseIdentifier, for: indexPath) as! GetDataTableViewCell
        
        let userDict = infoVar?[indexPath.row]
        
        cell.nameLbl.text = userDict?["id"]
        cell.emailLbl.text = infoVar?[indexPath.row]["email"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        getInfo = infoVar?[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: self)
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            
            let vc = segue.destination as? ShowDataViewController
            vc?.showData = getInfo
        }
    }
    
    private func infoCatecories(_ data: Data) {
        var response: [[String: Any]]?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]]
            print("response array: \(response)")
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
          }
    }
}
