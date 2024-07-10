//
//  InspectionHistoryViewController.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 04/07/24.
//

import UIKit

class InspectionHistoryViewController: UIViewController {

    @IBOutlet var historyTblView: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    var historyData: [InpectionCoreModel] = []
    let inspectionVC = InspectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.historyTblView.reloadData()
        historyTblView.isHidden = historyData.isEmpty
        noDataLbl.isHidden = !historyData.isEmpty
    }
    
    // MARK: Setup Methods
    func initialSetup() {
        historyTblView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")
    }
}

extension InspectionHistoryViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        let history = historyData[indexPath.row]
        cell.idLabel.text = "Inspection ID: \(String(history.id))"
        cell.typeLabel.text = "Inspection Type: \(history.inspectionType?.name ?? "")"
        cell.areaLabel.text = "Inspection Area: \(history.inspectionArea?.name ?? "")"
        cell.scoreLabel.text = "Inspection Score: \(String(history.id))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = historyData[indexPath.row]
        let inspection = DatabaseHelper.sharedInstance.getInspectionFromInspectionModel(model: history)
        inspectionVC.isForHistory = true
        inspectionVC.inspection = inspection
        inspectionVC.resultInspection = inspection
        self.navigationController?.pushViewController(inspectionVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
