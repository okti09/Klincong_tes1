import Foundation

struct TaskItem: Hashable, Equatable, Identifiable {
    let id = UUID()
    var description: String
}

struct TaskGroup: Hashable, Equatable {
    var tasks: [TaskItem]
}
