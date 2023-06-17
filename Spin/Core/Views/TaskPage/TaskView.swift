//
//  TaskView.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

struct TaskView: View {
    var body: some View {
        HStack {
            Text("Hello, World!")
        }
        .navigationTitle("Таски")
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskView()
        }
    }
}
