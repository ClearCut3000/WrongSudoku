//
//  ButtonStyle.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 12.12.2022.
//

import SwiftUI

struct MainGrowingButton: ButtonStyle {

  @Environment(\.isEnabled) var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(!isEnabled ? Color("uncorrectSumColor").opacity(0.3) : (configuration.isPressed ? Color.orange : Color("uncorrectSumColor")) )
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
    }
}
