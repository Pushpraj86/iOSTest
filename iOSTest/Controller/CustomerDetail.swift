//
//  CustomerDetail.swift
//  iOSTest
//
//  Created by Apple on 07/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class CustomerDetail: UIViewController {
    
    var CustomerEmail: String = ""
    var  Databalance: String = ""
    var  price: String = ""
    var  name: String = ""
    var  expirydate: String = ""

    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDatabalance: UILabel!
        @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblExpirydate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)

        // Do any additional setup after loading the view.
         print(CustomerEmail)
        self.title = "Customer Details"
        
        lblEmail.text =  "Customer Eamil: \(CustomerEmail) "
       lblDatabalance.text =  "Data Balance: \(Databalance) "

        lblName.text =  "Customer Name: \(name) "
        lblPrice.text = "Product Price: \(price) "
        lblExpirydate.text = "ExpiryDate: \(expirydate) "
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
