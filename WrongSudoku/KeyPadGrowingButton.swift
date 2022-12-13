//
//  KeyPadGrowingButton.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 13.12.2022.
//

import SwiftUI

struct KeypadGrowingButton: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(Color("textColor"))
      .scaleEffect(configuration.isPressed ? 1.5 : 1)
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
}
