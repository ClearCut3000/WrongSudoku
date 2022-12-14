//
//  CellView.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 08.12.2022.
//

import SwiftUI

struct CellView: View {

  let number: Int
  let isSelected: Bool
  var onSelected: () -> Void

  var displayNumber: String {
    if number == 0 {
      return ""
    } else {
      return String(number)
    }
  }

  var body: some View {
    Button(action: onSelected) {
      Text(displayNumber)
        .font(.largeTitle)
        .monospacedDigit()
        .frame(maxWidth: 100, maxHeight: 100)
        .aspectRatio(1, contentMode: .fit)
        .foregroundColor(isSelected ? .white : .black.opacity(0.5))
        .background(isSelected ? Color("selectedColor") : .clear)
        .border(.black.opacity(0.5), width: 5)
        .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
  }
}

struct CellView_Previews: PreviewProvider {
  static var previews: some View {
    CellView(number: 8, isSelected: false) { }
  }
}
