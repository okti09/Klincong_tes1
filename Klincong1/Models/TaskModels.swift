import Foundation

struct TaskItem: Identifiable, Codable, Hashable, Equatable {
    let id = UUID()
    let description: String
}

struct TaskGroup: Identifiable, Codable, Hashable, Equatable {
    let id = UUID()
    let tasks: [TaskItem]
}