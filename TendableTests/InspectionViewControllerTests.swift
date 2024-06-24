//
//  InspectionViewControllerTests.swift
//  TendableTests
//
//  Created by Choudhary, Mandar on 23/06/24.
//

import XCTest
@testable import Tendable

final class InspectionViewControllerTests: XCTestCase {
    
    var viewController: InspectionViewController = InspectionViewController()
    
    func testAllAnswersCompleted_WhenAllAnswersAreCompleted() {
        // Given
        let question1 = InspectionQuestions(id: nil, name: nil, answerChoices: nil, selectedAnswerChoiceId: 1)
        let question2 = InspectionQuestions(id: nil, name: nil, answerChoices: nil, selectedAnswerChoiceId: 2)
        let category = InspectionCategory(id: nil, name: nil, questions: [question1, question2])
        let survey = InspectionSurvey(id: nil, categories: [category])
        viewController.resultInspection = Inspection(id: nil, inspectionType: nil, area: nil, survey: survey)
        
        // When
        let result = viewController.allAnswersCompleted()
        
        // Then
        XCTAssertTrue(result, "allAnswersCompleted should return true when all questions have selected answers")
    }
    
    func testAllAnswersCompleted_WhenSomeAnswersAreNotCompleted() {
        // Given
        let question1 = InspectionQuestions(id: nil, name: nil, answerChoices: nil, selectedAnswerChoiceId: 1)
        let question2 = InspectionQuestions(id: nil, name: nil, answerChoices: nil, selectedAnswerChoiceId: nil)
        let category = InspectionCategory(id: nil, name: nil, questions: [question1, question2])
        let survey = InspectionSurvey(id: nil, categories: [category])
        viewController.resultInspection = Inspection(id: nil, inspectionType: nil, area: nil, survey: survey)
        
        // When
        let result = viewController.allAnswersCompleted()
        
        // Then
        XCTAssertFalse(result, "allAnswersCompleted should return false when some questions do not have selected answers")
    }
    
    func testAllAnswersCompleted_WhenThereAreNoQuestions() {
        // Given
        let category = InspectionCategory(id: nil, name: nil, questions: nil)
        let survey = InspectionSurvey(id: nil, categories: [category])
        viewController.resultInspection = Inspection(id: nil, inspectionType: nil, area: nil, survey: survey)
        
        // When
        let result = viewController.allAnswersCompleted()
        
        // Then
        XCTAssertTrue(result, "allAnswersCompleted should return true when there are no questions")
    }
    
    func testAllAnswersCompleted_WhenThereAreNoCategories() {
        // Given
        let survey = InspectionSurvey(id: nil, categories: nil)
        viewController.resultInspection = Inspection(id: nil, inspectionType: nil, area: nil, survey: survey)
        
        // When
        let result = viewController.allAnswersCompleted()
        
        // Then
        XCTAssertTrue(result, "allAnswersCompleted should return true when there are no categories")
    }
    
    func testAllAnswersCompleted_WhenResultInspectionIsNil() {
        // Given
        viewController.resultInspection = nil
        
        // When
        let result = viewController.allAnswersCompleted()
        
        // Then
        XCTAssertTrue(result, "allAnswersCompleted should return true when resultInspection is nil")
    }
    
    func testCalculateScore_WhenAllAnswersHaveScores() {
        // Given
        let choice1 = InspectionAnswer(id: 1, name: "Choice 1", score: 5.0)
        let choice2 = InspectionAnswer(id: 2, name: "Choice 2", score: 3.0)
        let question1 = InspectionQuestions(id: 1, name: "Question 1", answerChoices: [choice1, choice2], selectedAnswerChoiceId: 1)
        let question2 = InspectionQuestions(id: 2, name: "Question 2", answerChoices: [choice1, choice2], selectedAnswerChoiceId: 2)
        let category = InspectionCategory(id: 1, name: "Category 1", questions: [question1, question2])
        let survey = InspectionSurvey(id: 1, categories: [category])
        viewController.resultInspection = Inspection(id: 1, inspectionType: nil, area: nil, survey: survey)
        
        // When
        let result = viewController.calculateScore()
        
        // Then
        XCTAssertEqual(result, 8.0, "calculateScore should return the sum of the selected answer choices' scores")
    }
    
    func testCalculateScore_WhenSomeAnswersHaveNoScores() {
        // Given
        let choice1 = InspectionAnswer(id: 1, name: "Choice 1", score: 5.0)
        let choice2 = InspectionAnswer(id: 2, name: "Choice 2", score: nil)
        let question1 = InspectionQuestions(id: 1, name: "Question 1", answerChoices: [choice1, choice2], selectedAnswerChoiceId: 1)
        let question2 = InspectionQuestions(id: 2, name: "Question 2", answerChoices: [choice1, choice2], selectedAnswerChoiceId: 2)
        let category = InspectionCategory(id: 1, name: "Category 1", questions: [question1, question2])
        let survey = InspectionSurvey(id: 1, categories: [category])
        viewController.resultInspection = Inspection(id: 1, inspectionType: nil, area: nil, survey: survey)
        
        // When
        let result = viewController.calculateScore()
        
        // Then
        XCTAssertEqual(result, 5.0, "calculateScore should correctly sum the scores even if some scores are nil")
    }
    
    func testCalculateScore_WhenNoAnswerChoices() {
        // Given
        let question1 = InspectionQuestions(id: 1, name: "Question 1", answerChoices: nil, selectedAnswerChoiceId: 1)
        let question2 = InspectionQuestions(id: 2, name: "Question 2", answerChoices: nil, selectedAnswerChoiceId: 2)
        let category = InspectionCategory(id: 1, name: "Category 1", questions: [question1, question2])
        let survey = InspectionSurvey(id: 1, categories: [category])
        viewController.resultInspection = Inspection(id: 1, inspectionType: nil, area: nil, survey: survey)
        
        // When
        let result = viewController.calculateScore()
        
        // Then
        XCTAssertEqual(result, 0.0, "calculateScore should return 0 if there are no answer choices")
    }
    
    func testCalculateScore_WhenNoQuestions() {
        // Given
        let category = InspectionCategory(id: 1, name: "Category 1", questions: nil)
        let survey = InspectionSurvey(id: 1, categories: [category])
        viewController.resultInspection = Inspection(id: 1, inspectionType: nil, area: nil, survey: survey)
        
        // When
        let result = viewController.calculateScore()
        
        // Then
        XCTAssertEqual(result, 0.0, "calculateScore should return 0 if there are no questions")
    }
    
    func testCalculateScore_WhenNoCategories() {
        // Given
        let survey = InspectionSurvey(id: 1, categories: nil)
        viewController.resultInspection = Inspection(id: 1, inspectionType: nil, area: nil, survey: survey)
        
        // When
        let result = viewController.calculateScore()
        
        // Then
        XCTAssertEqual(result, 0.0, "calculateScore should return 0 if there are no categories")
    }
    
    func testCalculateScore_WhenResultInspectionIsNil() {
        // Given
        viewController.resultInspection = nil
        
        // When
        let result = viewController.calculateScore()
        
        // Then
        XCTAssertEqual(result, 0.0, "calculateScore should return 0 if resultInspection is nil")
    }
    
    func testGetAnwerFromChoices_WhenAllChoicesHaveNames() {
        // Given
        let choice1 = InspectionAnswer(id: 1, name: "Choice 1", score: 5.0)
        let choice2 = InspectionAnswer(id: 2, name: "Choice 2", score: 3.0)
        let choices = [choice1, choice2]
        
        // When
        let result = viewController.getAnwerFromChoices(choices: choices)
        
        // Then
        XCTAssertEqual(result, ["Choice 1", "Choice 2"], "getAnwerFromChoices should return an array of choice names")
    }
    
    func testGetAnwerFromChoices_WhenSomeChoicesHaveNilNames() {
        // Given
        let choice1 = InspectionAnswer(id: 1, name: "Choice 1", score: 5.0)
        let choice2 = InspectionAnswer(id: 2, name: nil, score: 3.0)
        let choices = [choice1, choice2]
        
        // When
        let result = viewController.getAnwerFromChoices(choices: choices)
        
        // Then
        XCTAssertEqual(result, ["Choice 1", ""], "getAnwerFromChoices should return an empty string for choices with nil names")
    }
    
    func testGetAnwerFromChoices_WhenAllChoicesHaveNilNames() {
        // Given
        let choice1 = InspectionAnswer(id: 1, name: nil, score: 5.0)
        let choice2 = InspectionAnswer(id: 2, name: nil, score: 3.0)
        let choices = [choice1, choice2]
        
        // When
        let result = viewController.getAnwerFromChoices(choices: choices)
        
        // Then
        XCTAssertEqual(result, ["", ""], "getAnwerFromChoices should return an array of empty strings when all choice names are nil")
    }
    
    func testGetAnwerFromChoices_WhenNoChoices() {
        // Given
        let choices: [InspectionAnswer] = []
        
        // When
        let result = viewController.getAnwerFromChoices(choices: choices)
        
        // Then
        XCTAssertEqual(result, [], "getAnwerFromChoices should return an empty array when there are no choices")
    }
}
