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
    @State private var tasks: [TaskCard] = [
        TaskCard(title: "Membersihkan Kaca", description: "Gunakan kain lap dan cairan pembersih."),
        TaskCard(title: "Mengelap Meja", description: "Gunakan lap basah untuk meja."),
        TaskCard(title: "Membersihkan Lantai", description: "Sapu Lantai")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("This is your task")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            ForEach(tasks.indices, id: \.self) { index in
                let task = tasks[index]
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(task.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(task.isCompleted ? .white : .black)
                    
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(task.isCompleted ? .white : .black)
                    
                }
                .padding()
                .frame(width: 340, height: 100)
                .background(task.isCompleted ? Color.gray.opacity(0.5) : Color.yellow.opacity(1))
                .cornerRadius(15)
                .offset(x: task.offset.width, y: 0)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            tasks[index].offset = value.translation
                        }
                        .onEnded { value in
                            if value.translation.width < -100 {
                                tasks[index].isCompleted = true
                            }
                            tasks[index].offset = .zero
                        }
                )
                .animation(.easeInOut, value: task.offset)
            }
            Spacer()
            HStack(spacing: 20) {
                Button(action: {
                    print("Skip tapped")
                }) {
                    Text("Skip")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color.orange)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                Button(action: {
                    print("Finish tapped. Completed tasks: \(tasks.filter { $0.isCompleted })")
                }) {
                    Text("Finish")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color.orange)
                        .cornerRadius(30)
                        .shadow(radius: 5)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.birumalam))
        // .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CardTaskView()
}
