//
//  TypingTestModel.swift
//  FakeMonkeytypeUI
//
//  Created by Yvonne An on 3/5/24.
//

import Foundation


struct TypingTestModel {
    let testString: String = "The quick brown fox jumps over the lazy dog"
    var userInput: String = ""
    var startTime: Date?
    var endTime: Date?

    mutating func startTest() {
        if startTime == nil {
            startTime = Date()
        }
    }

    mutating func endTest() {
        if userInput == testString {
            endTime = Date()
        }
    }

    mutating func restartTest() {
        userInput = ""
        startTime = nil
        endTime = nil
    }

    func calculateResults() -> (wordsPerMinute: Double, accuracy: Double) {
        guard let start = startTime, let end = endTime else { return (0, 0) }
        let elapsedTime = end.timeIntervalSince(start) / 60
        let wordCount = Double(userInput.split(separator: " ").count)
        let wordsPerMinute = wordCount / elapsedTime

        let enteredText = Array(userInput)
        let correctText = Array(testString)
        let commonCount = zip(enteredText, correctText).filter { $0 == $1 }.count
        let accuracy = (Double(commonCount) / Double(correctText.count)) * 100

        return (wordsPerMinute, accuracy)
    }
}
