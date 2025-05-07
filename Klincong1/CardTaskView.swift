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
    let total: Double = 5.0 //harus disesuaikan dengan berapa banyak tasknya
    @State private var progress: Double = 0.0
    
    @State private var tasks: [TaskCard] = [
        TaskCard(title: "Membersihkan Kaca", description: "Gunakan kain lap dan cairan pembersih."),
        TaskCard(title: "Mengelap Meja", description: "Gunakan lap basah untuk meja."),
        TaskCard(title: "Membersihkan Lantai", description: "Sapu Lantai")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Here's your\n cleaning task")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                ProgressView(value: progress, total: total)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(height: 20)
                    .accentColor(.yellow)
                    .padding()
                
                
                // Menampilkan angka di samping progress bar
                Text("\(Int(progress))/\(Int(total))")
                    .font(.headline)
                    .padding()
                
            }
            
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
                    withAnimation {
                        if progress < total {
                            progress += 1
                        }
                    }
                }) {
                    Text("Finish")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color.orange)
                        .cornerRadius(30)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(Color(.birumalam))
        // .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CardTaskView()
}
