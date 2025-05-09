//
//  ToolPickerView.swift
//  Klincong1
//
//  Created by Shafa Tiara Tsabita Himawan on 09/05/25.
//

import SwiftUI


struct ToolPickerView: View {
    @State private var selectedTools: Set<CleaningTool> = []
    var onToolsSelected: ([CleaningTool]) -> Void = { _ in }

    let dryTools: [CleaningTool] = [
        .init(name: "Broom", imageName: "img_sapu"),
        .init(name: "Dustpan", imageName: "img_pengki"),
        .init(name: "Vacuum", imageName: "img_vakum"),
        .init(name: "Duster", imageName: "img_kemoceng"),
        .init(name: "Cloth", imageName: "img_lap"),
        .init(name: "Trash Bin", imageName: "img_kotaksampah")
    ]

    let wetTools: [CleaningTool] = [
        .init(name: "Mop", imageName: "img_pel"),
        .init(name: "Toilet Brush", imageName: "img_sikat"),
        .init(name: "Sponge", imageName: "img_spons")
    ]

    let solutionTools: [CleaningTool] = [
        .init(name: "All Cleaner", imageName: "s_img_apc"),
        .init(name: "Bathroom Cleaner", imageName: "s_bathroom-cleaner"),
        .init(name: "Dish Soap", imageName: "s_dish-soap"),
        .init(name: "Floor Cleaner", imageName: "s_floor-cleaner"),
        .init(name: "Laundry Detergen", imageName: "s_laundry-detergent")
    ]

    var body: some View {
        ZStack {
            Color("kuneng").ignoresSafeArea()

            VStack(spacing: 0) {
                // 🟡 Header
                ZStack(alignment: .topTrailing) {
                    VStack(alignment: .leading, spacing: 8) {
                        Spacer().frame(height: 60)

                        Text("Tools You've\nGot at Home")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                        Text("Tap to choose!")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.6))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Image("img_okcat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 275, height: 205)
                        .rotationEffect(.degrees(-25))
                        .offset(x: 125, y: -5)
                }
                .frame(maxWidth: .infinity)
                .clipped()

                // 🔽 Scroll + Tool Section
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        toolSection(title: "Dry", tools: dryTools)
                        toolSection(title: "Wet", tools: wetTools)
                        toolSection(title: "Solution", tools: solutionTools)

                        Button(action: {
                            onToolsSelected(Array(selectedTools))
                        }) {
                            Text("Continue")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedTools.isEmpty ? Color.gray : Color.orange)
                                .cornerRadius(20)
                                .padding(.horizontal)
                        }
                        .padding(.top, 32)
                        .padding(.bottom, 30)
                        .disabled(selectedTools.isEmpty)
                    }
                    .padding(.top, 24)
                    .background(Color("biruy"))
                }
            }
        }
    }

    @ViewBuilder
    func toolSection(title: String, tools: [CleaningTool]) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.black)
            .padding(.leading)

        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(tools) { tool in
                    ToolCard(tool: tool, isSelected: selectedTools.contains(tool)) {
                        toggleSelection(tool)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    func toggleSelection(_ tool: CleaningTool) {
        if selectedTools.contains(tool) {
            selectedTools.remove(tool)
        } else {
            selectedTools.insert(tool)
        }
    }
}

struct ToolCard: View {
    let tool: CleaningTool
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 10) {
                Image(tool.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 160, height: 150)
                    .saturation(isSelected ? 1 : 0)
                    .opacity(isSelected ? 1.0 : 0.4)
                    .animation(.easeInOut(duration: 0.3), value: isSelected)

                Text(tool.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(width: 200, height: 215)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 5)
            )
        }
    }
}

#Preview {
    ToolPickerView()
}
