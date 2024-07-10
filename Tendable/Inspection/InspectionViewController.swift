//
//  InspectionViewController.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 16/06/24.
//

import UIKit

class InspectionViewController: UIViewController {
    
    // IBOutlets/Constants
    @IBOutlet var inspectionTbl: UITableView!
    @IBOutlet var inspectionName: UILabel!
    @IBOutlet var inspectionArea: UILabel!
    @IBOutlet var submitBtn: UIButton!
    var viewModel = InspectionViewModel()
    var inspection: Inspection?
    var resultInspection: Inspection?
    var selectedAnswers: [IndexPath: String] = [:]
    var isForHistory: Bool = false

    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isForHistory {
            self.submitBtn.isHidden = true
        } else {
            self.fetchNewInspection()
            self.submitBtn.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.inspection = nil
        self.resultInspection = nil
        self.selectedAnswers = [:]
    }
    
    // MARK: Setup Methods
    func initialSetup() {
        inspectionTbl.register(QuestionAnswerCell.self, forCellReuseIdentifier: "QuestionAnswerCell")
    }
    
    // MARK: IBActions
    @IBAction func submitBtnAction(_ sender: Any) {
        if allAnswersCompleted() {
            if let _ = self.resultInspection {
                var finalInspection = InspectionModel()
                finalInspection.inspection = resultInspection
                viewModel.submitInspection(answerInspection: finalInspection) { success, msg in
                    DispatchQueue.main.async {
                        if success {
                            DatabaseHelper.sharedInstance.saveInspection(userMailId: DatabaseHelper.sharedInstance.LOGGED_IN_USER_ID, inspection: self.resultInspection!, score: self.calculateScore())
                            self.presentAlert(title: SUCCESS, message: SUBMIT_SUCCESS_MSG + "Your score is \(self.calculateScore())") {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            }
        } else {
            presentAlert(title: "Alert", message: "Please select all answers before submitting.")
        }
    }

    // MARK: Helper Methods
    func reloadData() {
        self.inspectionName.text = INSPECTION_TYPE + ": " + (self.inspection?.inspectionType?.name ?? "")
        self.inspectionArea.text = INSPECTION_AREA + ": " + (self.inspection?.area?.name ?? "")
        self.inspectionTbl.reloadData()
    }
    
    func allAnswersCompleted() -> Bool {
        var answersCompleted = true
        if let categories = resultInspection?.survey?.categories {
            for category in categories {
                if let questions = category.questions {
                    for question in questions {
                        if question.selectedAnswerChoiceId == nil {
                            answersCompleted = false
                            break
                        }
                    }
                }
            }
        }
        return answersCompleted
    }
    
    func calculateScore() -> Double {
        var score: Double = 0.0
        if let categories = resultInspection?.survey?.categories {
            for category in categories {
                if let questions = category.questions {
                    for question in questions {
                        if let choices = question.answerChoices {
                            for choice in choices {
                                if (question.selectedAnswerChoiceId == choice.id) {
                                    score = score + (choice.score ?? 0)
                                    break
                                }
                            }
                            
                        }
                    }
                }
                
            }
        }
        return score
    }
}

// MARK: API Handlings
extension InspectionViewController {
    
    func fetchNewInspection() {
        viewModel.fetchNewInspection { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let inspection):
                    self?.inspection = inspection.inspection
                    self?.resultInspection = inspection.inspection
                    self?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension InspectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return inspection?.survey?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inspectionCategory = inspection?.survey?.categories?[section]
        return inspectionCategory?.questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionAnswerCell", for: indexPath) as? QuestionAnswerCell else {
            return UITableViewCell()
        }
        let inspectionCategory = inspection?.survey?.categories?[indexPath.section]
        let question = inspectionCategory?.questions?[indexPath.row]
        let answers = getAnwerFromChoices(choices: question?.answerChoices ?? [])
        let selectedAnswer = selectedAnswers[indexPath]
        cell.configure(question: question?.name ?? "", answers: answers, selectedAnswer: selectedAnswer, indexPath: indexPath, tapable: !isForHistory)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getViewForHeaderSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableView Helper
extension InspectionViewController {
    
    func getAnwerFromChoices(choices: [InspectionAnswer]) -> [String] {
        var answers: [String] = []
        for answer in choices {
            answers.append(answer.name ?? "")
        }
        return answers
    }
    
    func getViewForHeaderSection(section: Int) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let inspectionCategory = inspection?.survey?.categories?[section]
        label.text = inspectionCategory?.name
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        return headerView
    }
}

// MARK: - QuestionAnswerCellDelegate
extension InspectionViewController: QuestionAnswerCellDelegate {
    func didSelectAnswer(_ answer: String, forQuestionAt indexPath: IndexPath) {
        print("Selected answer '\(answer)' for question at section \(indexPath.section), row \(indexPath.row)")
        selectedAnswers[indexPath] = answer
        inspectionTbl.reloadRows(at: [indexPath], with: .automatic)

        if let answersChoices = resultInspection?.survey?.categories?[indexPath.section].questions?[indexPath.row].answerChoices {
            for choice in answersChoices {
                if (choice.name == answer) {
                    resultInspection?.survey?.categories?[indexPath.section].questions?[indexPath.row].selectedAnswerChoiceId = choice.id
                }
            }
        }
    }
}
