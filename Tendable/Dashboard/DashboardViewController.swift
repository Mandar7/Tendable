//
//  DashboardViewController.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 24/06/24.
//

import UIKit

class DashboardViewController: UIViewController {
    
    let inspectionVC = InspectionViewController()
    let inspectionHistoryVC = InspectionHistoryViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func newInspectionBtnClicked(_ sender: Any) {
        self.navigationController?.pushViewController(inspectionVC, animated: true)
    }
    
    @IBAction func historyBtnClicked(_ sender: Any) {
        let data: [InpectionCoreModel] = DatabaseHelper.sharedInstance.getInspectionsWith(userMailId: "111") ?? []
        print("Data == \(String(describing: data))")
        inspectionHistoryVC.historyData = data
        self.navigationController?.pushViewController(inspectionHistoryVC, animated: true)

    }
}
