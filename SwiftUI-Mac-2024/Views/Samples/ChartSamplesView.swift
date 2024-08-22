// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI
import Charts

enum ChartType: String, CaseIterable {
  case bar = "Bar"
  case pie = "Pie"
  case line = "Line"
}

struct ChartSamplesView: View {
  @State private var chartData: [ChartPoint] = ChartPoint.chartPoints
  @State private var chartType: ChartType = .bar
  @State private var showFileExporter = false

  var body: some View {
    VStack {
      chartView

      HStack {
        Picker("Chart Type:", selection: $chartType) {
          ForEach(ChartType.allCases, id: \.self) { type in
            Text(type.rawValue).tag(type)
          }
        }
        .pickerStyle(.segmented)
        .padding()

        Button("Save Chart as Image") {
          showFileExporter = true
        }
      }
      .padding(.horizontal)
    }
    .animation(.easeInOut, value: chartType)
    .fileExporter(
      isPresented: $showFileExporter,
      item: exportImageData,
      defaultFilename: exportFileName) { result in
        switch result {
          case .success(let url):
            print("Exported successfully", url)
          case .failure(let error):
            print("Export failed: \(error)")
        }
      } onCancellation: {
        print("Cancelled")
    }
  }

  var chartView: some View {
    Group {
      Text(chartType == .line ? "Sine Waves" : "Status codes by category")
        .font(.title3)
        .bold()
        .padding()

      HStack {
        if chartType == .bar {
          Text("Count")
            .bold()
            .rotationEffect(.degrees(270))
        }

        selectedChart
          .chartForegroundStyleScale([
            "1xx": .green,
            "2xx": .purple,
            "3xx": .blue,
            "4xx": .yellow,
            "5xx": .red
          ])
          .chartLegend(chartType != .pie ? .hidden : .visible)
          .padding(.trailing)
      }

      if chartType == .bar {
        Text("Category")
          .bold()
      }
    }
  }

  @ViewBuilder var selectedChart: some View {
    switch chartType {
      case .bar:
        barChart
      case .pie:
        pieChart
      case .line:
        lineChart
    }
  }

  var barChart: some View {
    Chart {
      ForEach(chartData) { point in
        BarMark(
          x: .value("Category", point.category),
          y: .value("Count", point.count)
        )
        .foregroundStyle(by: .value( "Color", point.category))
      }

      RuleMark(
        y: .value("Threshold", 8)
      )
      .foregroundStyle(.gray)
    }
  }

  var pieChart: some View {
    Chart {
      ForEach(chartData) { point in
        SectorMark(
          angle: .value("Count", point.count),
          angularInset: 2
        )
        .cornerRadius(3)
        .foregroundStyle(by: .value( "Color", point.category))
        .annotation(position: .overlay) {
          if point.count > 3 {
            Text("\(point.category.prefix(1))x:\n\(point.count)")
              .font(.headline)
              .foregroundStyle(.white)
              .shadow(radius: 1)
          } else {
            Text("")
          }
        }
      }
    }
  }

  var lineChart: some View {
    Chart {
      LinePlot(x: "x", y: "y") { y in
        sin(y)
      }
      .foregroundStyle(.blue)

      LinePlot(x: "x", y: "y") { y in
        sin(y + 30)
      }
      .foregroundStyle(.red)

      LinePlot(x: "x", y: "y") { y in
        sin(y + 60)
      }
      .foregroundStyle(.green)

      LinePlot(x: "x", y: "y") { y in
        sin(y + 90)
      }
      .foregroundStyle(.orange)
    }
    .chartXScale(domain: 0 ... 30)
    .padding(.leading)
  }

  var exportImageData: Data? {
    let view = chartView
      .padding()
      .frame(width: 1200, height: 800)

    let renderer = ImageRenderer(content: view)
    if let exportImage = renderer.nsImage {
      let imageRepresentation = NSBitmapImageRep(data: exportImage.tiffRepresentation!)
      let jpgData = imageRepresentation?.representation(using: .jpeg, properties: [:])
      return jpgData
    }
    return nil
  }

  var exportFileName: String {
    switch chartType {
      case .bar:
        "Bar chart.jpg"
      case .pie:
        "Pie chart.jpg"
      case .line:
        "Line Chart.jpg"
    }
  }
}

#Preview {
  ChartSamplesView()
}
