//
//  ContentView.swift
//  FakeMonkeytypeUI
//
//  Created by Yvonne An on 3/5/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import SceneKit

struct ContentView: View {
    @State private var showWelcomeScreen = true
    @State private var showInspoScreen = false

    var body: some View {
        ZStack {
            Model3D(named: "Scene", bundle: .main)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all) // Fill the entire screen with Model3D

            if showWelcomeScreen {
                WelcomeScreen()
                    .onAppear {
                        // After 4 seconds, transition to the second screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation {
                                showWelcomeScreen = false
                                showInspoScreen = true
                            }
                        }
                    }
            } else if showInspoScreen {
                InspoScreen()
                    .onAppear {
                        // After 5 seconds, transition to the typing test view
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                            showInspoScreen = false
                        }
                    }
            } else {
                TypingTestView()
            }
        }
    }
}

struct WelcomeScreen: View {
    @State private var opacity: Double = 1.0 // Add a state property to control opacity
    
    var body: some View {
        VStack(spacing: 6) {
            Text("Yvonne's VisionOS App Project 1")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .opacity(1.0) // Use the opacity state property
            Text("Visiontype")
                .foregroundColor(.white)
                .font(.system(size: 70, weight: .semibold))
                .opacity(1.0) // Use the opacity state property
        }
        .onAppear {
            // Fade out animation after 2 seconds delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    opacity = 0.0 // Update the opacity state property
                }
            }
        }
    }
}

struct InspoScreen: View {
    @State private var opacity: Double = 1.0 // Add a state property to control opacity
    
    var body: some View {
        VStack {
            Text("I'm an avid Monkeytype user. I use it every day to improve my typing skills.")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
                .opacity(opacity) // Use the opacity state property
            Text("This was an inspiration for this project. Enjoy!")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
                .opacity(opacity) // Use the opacity state property
            Text("Enjoy!")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
                .opacity(opacity) // Use the opacity state property
        }
        .onAppear {
            // Fade out animation after 2 seconds delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    opacity = 0.0 // Update the opacity state property
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
