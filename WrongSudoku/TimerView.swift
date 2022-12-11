//
//  TimerView.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 11.12.2022.
//

import SwiftUI

struct TimerView: View {

//MARK: - View Properties
  var font: Font = .largeTitle
  var weight: Font.Weight = .heavy
  @Binding var value: Int
  @State private var animationRange: [Int] = []

  //MARK: - View Body
    var body: some View {
      HStack(spacing: 0) {
        ForEach(0..<animationRange.count, id: \.self) { index in
          Text("0")
            .font(font)
            .fontWeight(weight)
            .opacity(0)
            .overlay {
              GeometryReader { geo in
                let size = geo.size
                VStack(spacing: 0) {
                  ForEach(0...9, id: \.self) { number in
                    Text("\(number)")
                      .font(font)
                      .fontWeight(weight)
                      .frame(width: size.width,
                             height: size.height,
                             alignment: .center)
                  }
                }
                .offset(y: -CGFloat(animationRange[index]) * size.height)
              }
              .clipped()
            }
        }
      }
      .onAppear {
        animationRange = Array(repeating: 0, count: "\(value)".count)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
          updateText()
        }
      }
      .onChange(of: value) { newValue in
        let extra = "\(value)".count - animationRange.count
        if extra > 0 {
          for _ in 0..<extra {
            withAnimation(.easeInOut(duration: 0.1)) {
              animationRange.append(0)
            }
          }
        } else {
          for _ in 0..<(-extra) {
            withAnimation(.easeInOut(duration: 0.1)) {
              animationRange.removeLast()
            }
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
          updateText()
        }
      }
    }

  func updateText() {
    let stringValue = "\(value)"
    for (index, value) in zip(0..<stringValue.count, stringValue) {
      var fraction = Double(index) * 0.15
      fraction = (fraction > 0.5 ? 0.5 : fraction)
      withAnimation(.interactiveSpring(response: 0.8,
                                       dampingFraction: 1 + fraction,
                                       blendDuration: 1 + fraction)) {
        animationRange[index] = (String(value) as NSString).integerValue
      }
    }
  }
}
