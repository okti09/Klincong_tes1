import SwiftUI

struct RootView: View {
    @State private var showLanding = true
    @State private var showToolPicker = false
    @State private var showCleaningTools = false
    @State private var showCamera = false
    @State private var showTasks = false
    @State private var selectedTools: [CleaningTool] = []
    @State private var taskGroups: [TaskGroup] = []

    var body: some View {
        if showLanding {
            LandingPageView {
                withAnimation {
                    showLanding = false
                    showToolPicker = true
                }
            }
        } else if showToolPicker {
            ToolPickerView(onToolsSelected: { tools in
                selectedTools = tools
                withAnimation {
                    showToolPicker = false
                    showCleaningTools = true
                }
            })
        } else if showCleaningTools {
            CleaningToolsView(tools: selectedTools) {
                withAnimation {
                    showCleaningTools = false
                    showCamera = true
                }
            }
        } else if showCamera {
            CameraContentView(selectedTools: selectedTools.map { $0.name }) { groups in
                taskGroups = groups
                withAnimation {
                    showCamera = false
                    showTasks = true
                }
            }
        } else if showTasks {
            CardTaskView(taskGroups: taskGroups)
        }
    }
}
