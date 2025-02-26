//
//  ContentView.swift
//  FlipCardDemo
//
//  Created by Douglas Jasper on 2025-02-26.
//

import SwiftUI

struct ContentView: View {
    @State private var isFlipped = false
    @State private var degrees = 0.0

    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                FrontCard()
                    .opacity(isFlipped ? 0 : 1)
                    .transition(.opacity)
                
                BackCard()
                    .opacity(isFlipped ? 1 : 0)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)) // Fix mirroring issue
                    .transition(.opacity)
            }
            .frame(width: 250, height: 350)
            .rotation3DEffect(
                .degrees(degrees),
                axis: (x: 0, y: 1, z: 0)
            )
            .onTapGesture {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                    degrees += 180
                    isFlipped.toggle()
                }
            }
            
            Spacer()
        }
    }
}

struct FrontCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.blue)
            .overlay(
                Text("Front")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            )
    }
}

struct BackCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.red)
            .overlay(
                Text("Back")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            )
    }
}

#Preview {
    ContentView()
}
