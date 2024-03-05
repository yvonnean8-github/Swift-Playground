//
//  TypingTestView.swift
//  FakeMonkeytypeUI
//
//  Created by Yvonne An on 3/5/24.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent
import SceneKit



/// welcome message first prompted





/// typing test prompt
struct TypingTestView: View {
    @State private var model = TypingTestModel()
    @State private var isTyping: Bool = false

    var body: some View {
        VStack {
            TypedText(testString: model.testString, userInput: $model.userInput)
                .padding()

            TextField("Start typing...", text: $model.userInput, onEditingChanged: { editing in
                if editing {
                    isTyping = true
                    model.startTest()
                } else {
                    isTyping = false
                    model.endTest()
                }
            }, onCommit: {
                isTyping = false
                model.endTest()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            if !isTyping {
                TypingStatsView(model: $model)
            }
        }
    }
}

struct TypedText: View {
    var testString: String
    @Binding var userInput: String

    var body: some View {
        let typedLetters = Array(userInput.prefix(testString.count))
        let remainingLetters = Array(testString.dropFirst(userInput.count))

        return HStack(spacing: 0) {
            ForEach(0..<testString.count, id: \.self) { index in
                let typed = index < typedLetters.count ? String(typedLetters[index]) : ""
                let remaining = index < remainingLetters.count ? String(remainingLetters[index]) : ""
                
                Text(typed)
                    .foregroundColor(typed == String(testString[testString.index(testString.startIndex, offsetBy: index)]) ? Color.green : Color.red)
                Text(remaining)
                    .foregroundColor(Color.white)
            }
        }
    }
}




/// user stats
struct TypingStatsView: View {
    @Binding var model: TypingTestModel // Receive model as binding

    var body: some View {
        let results = model.calculateResults()
        return VStack {
            Text("Words per minute: \(results.wordsPerMinute, specifier: "%.2f")")
                .font(.caption)
            Text("Accuracy: \(results.accuracy, specifier: "%.2f")%")
                .font(.caption)
            Button("Restart Test") {
                model.restartTest()
            }
        }
        .padding()
    }
}






struct TypingTestView_Previews: PreviewProvider {
    static var previews: some View {
        TypingTestView()
    }
}










#Preview(windowStyle: .automatic) {
    TypingTestView()
}
