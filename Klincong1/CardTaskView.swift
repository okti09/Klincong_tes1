//
//  CardTaskView.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 03/05/25.
//

import Foundation
import SwiftUI

struct TaskCard: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var isCompleted: Bool = false
    var offset: CGSize = .zero
}

struct CardTaskView: View {
    let taskGroups: [TaskGroup]
    @State private var currentGroup = 0
    @State private var skipCount = 0
    let maxSkip = 3

    var body: some View {
        VStack {
            Text("YOUR\nCLEANING TASK")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.top, 32)
                .padding(.leading, 16)
            
            ProgressView(value: Double(currentGroup + 1), total: Double(max(taskGroups.count, 1)))
                .accentColor(.orange)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .padding(.horizontal, 24)
                .padding(.top, 8)
            
            Spacer()
            
            if !taskGroups.isEmpty {
                VStack(spacing: 16) {
                    ForEach(taskGroups[currentGroup].tasks) { task in
                        Text(task.description)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.yellow.opacity(0.8))
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 24)
            } else {
                Text("No tasks available.")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    if skipCount < maxSkip && currentGroup < taskGroups.count - 1 {
                        skipCount += 1
                        currentGroup += 1
                    }
                }) {
                    Text("SKIP (\(skipCount)/\(maxSkip))")
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .disabled(skipCount >= maxSkip || currentGroup >= taskGroups.count - 1 || taskGroups.isEmpty)
                
                Spacer()
                
                Button(action: {
                    if currentGroup < taskGroups.count - 1 {
                        currentGroup += 1
                    }
                }) {
                    Text("FINISH")
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .disabled(currentGroup >= taskGroups.count - 1 || taskGroups.isEmpty)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

// Preview hanya untuk Xcode, tidak berpengaruh ke runtime
#Preview {
    let dummyTasks = [
        TaskGroup(tasks: [
            TaskItem(description: "Pick up trash"),
            TaskItem(description: "Wipe table"),
            TaskItem(description: "Sweep floor")
        ])
    ]
    CardTaskView(taskGroups: dummyTasks)
}

