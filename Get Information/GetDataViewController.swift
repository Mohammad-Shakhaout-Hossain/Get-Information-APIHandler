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
    var searching = false
    
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
    
    //var searchResult: [String: String]?
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyBoard))
        return recognizer
    }()
    
    @objc func dismissKeyBoard(){
        searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedInfoVar?.count ?? 0
        } else {
            return infoVar?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GetDataTableViewCell.reuseIdentifier, for: indexPath) as! GetDataTableViewCell
        
        let userDict = infoVar?[indexPath.row]
        
        if searching {
            cell.emailLbl.text = searchedInfoVar?[indexPath.row] ["email"]
        } else {
        
        cell.nameLbl.text = userDict?["id"]
        cell.emailLbl.text = infoVar?[indexPath.row]["email"]
        }
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
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
        //getTableView.reloadData()
    }
    
}

extension GetDataViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            searchedInfoVar = infoVar
        } else {
            searchedInfoVar = infoVar?.filter({ (userDict) -> Bool in
                (userDict["name"]?.lowercased().contains(searchText.lowercased()) ?? false) || (userDict["email"]?.lowercased().contains(searchText.lowercased()) ?? false) ||
                    (userDict["username"]?.lowercased().contains(searchText.lowercased()) ?? false)
                    
            })
        }
        searching = true
        getTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        getTableView.reloadData()
    }
}
