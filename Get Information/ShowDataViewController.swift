//
//  ShowDataViewController.swift
//  Get Information
//
//  Created by Shakhawat Hossain Shakib on 8/12/20.
//

import UIKit

class ShowDataViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    
    var showData: [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        idLbl.text = showData?["id"]
        nameLbl.text = showData?["name"]
        userLbl.text = showData?["username"]
        emailLbl.text = showData?["email"]
        addressLbl.text = showData?["address"]!
        phoneLbl.text = showData?["phone"]
        websiteLbl.text = showData?["website"]
        companyLbl.text = showData?["company"]
        
    }

}
