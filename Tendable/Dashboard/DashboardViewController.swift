//
//  DashboardViewController.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 24/06/24.
//

import UIKit

class DashboardViewController: UIViewController {
    
    let inspectionVC = InspectionViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func newInspectionBtnClicked(_ sender: Any) {
        self.navigationController?.pushViewController(inspectionVC, animated: true)
    }
}
