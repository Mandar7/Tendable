//
//  QuestionAnswerCell.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 16/06/24.
//

import UIKit

// MARK: QuestionAnswerCellDelegate Protocol
protocol QuestionAnswerCellDelegate: AnyObject {
    func didSelectAnswer(_ answer: String, forQuestionAt indexPath: IndexPath)
}

class QuestionAnswerCell: UITableViewCell {

    // Constants / Variables
    let questionLabel = UILabel()
    var answerButtons: [UIButton] = []
    weak var delegate: QuestionAnswerCellDelegate?
    var questionIndexPath: IndexPath?
    var selectedAnswer: String?

    // MARK: Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: Setup Methods
    private func setupViews() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionLabel)

        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
    }

    // MARK: Configure Methods
    func configure(question: String, answers: [String], selectedAnswer: String?, indexPath: IndexPath) {
        questionLabel.text = question
        questionIndexPath = indexPath
        self.selectedAnswer = selectedAnswer

        // Remove old buttons
        for button in answerButtons {
            button.removeFromSuperview()
        }
        answerButtons.removeAll()

        // Create new buttons
        var previousButton: UIButton? = nil
        for answer in answers {
            let button = UIButton(type: .system)
            button.setTitle(answer, for: .normal)
            button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)
            answerButtons.append(button)

            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])

            if let previousButton = previousButton {
                button.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 8).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8).isActive = true
            }
            previousButton = button
            
            // Highlight the selected answer
            if answer == selectedAnswer {
                button.backgroundColor = UIColor.systemBlue
                button.setTitleColor(UIColor.white, for: .normal)
            } else {
                button.backgroundColor = UIColor.clear
                button.setTitleColor(UIColor.systemBlue, for: .normal)
            }
        }

        if let lastButton = answerButtons.last {
            lastButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        }
    }

    @objc private func answerButtonTapped(_ sender: UIButton) {
        guard let answer = sender.titleLabel?.text, let indexPath = questionIndexPath else {
            return
        }
        selectedAnswer = answer
        delegate?.didSelectAnswer(answer, forQuestionAt: indexPath)
        // Update button appearances
        for button in answerButtons {
            if button == sender {
                button.backgroundColor = UIColor.systemBlue
                button.setTitleColor(UIColor.white, for: .normal)
            } else {
                button.backgroundColor = UIColor.clear
                button.setTitleColor(UIColor.systemBlue, for: .normal)
            }
        }
    }
}

