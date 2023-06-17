//
//  LoaderStateModifier.swift
//  Spin
//
//  Created by Олег Еременко on 23.05.2023.
//

import SwiftUI

struct LoaderStateModifier: ViewModifier {
    let isLoading: Bool

    func body(content: Content) -> some View {
        content
            .opacity(isLoading ? 0.5 : 1)
            .overlay {
                ProgressView()
                    .opacity(isLoading ? 1 : 0)
            }
            .animation(.default, value: isLoading)
    }
}

extension View {
    func applyLoadingModifier(isLoading: Bool) -> some View {
        modifier(LoaderStateModifier(isLoading: isLoading))
    }
}

struct LoaderStateModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Демо состояния загрузки")
            .modifier(LoaderStateModifier(isLoading: true))
    }
}
