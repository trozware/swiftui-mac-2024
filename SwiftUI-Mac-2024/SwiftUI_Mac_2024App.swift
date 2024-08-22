// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

@main
struct SwiftUI_Mac_2024App: App {
  @AppStorage("showMenuBar") var showMenuBar = true

  @State private var httpSections: [HttpSection] = HttpSection.localData

  var body: some Scene {
    // THIS IS THE DEFAULT AND GIVES A MULTI-WINDOW APP
    WindowGroup {
      ContentView(httpSections: httpSections)
    }
    .commands {
      Menus()
    }

    //    // THIS CREATES A SINGLE WINDOW APP
    //    Window("SwiftUI Mac 2024", id: "main") {
    //      ContentView(httpSections: httpSections)
    //    }
    //    .commands {
    //      Menus()
    //    }

    Settings {
      SettingsView()
    }

    // OPENING SECONDARY WINDOWS
    //
    // Use this method if you want to allow the window to open multiple times
    //    WindowGroup("Samples", id: "ui_samples") {
    //      SamplesView()
    //    }
    //
    // This method will open one window for each different String passed
    //    WindowGroup(for: String.self) { _ in
    //      SamplesView()
    //    }

    // This will only ever open a single window with a palette style
    // It adds Show & Hide options to the View menu with the keyboard shortcut
    UtilityWindow("UI Samples", id: "ui_samples") {
      SamplesView()
    }
    .keyboardShortcut("u")

    // This opens a styled and placed window
    Window("About", id: "about") {
      AboutView()
    }
    .windowResizability(.contentSize)
    .commandsRemoved()
    .defaultWindowPlacement { content, context in
      let displayBounds = context.defaultDisplay.bounds
      let contentSize = content.sizeThatFits(.unspecified)
      let position = CGPoint(
        x: displayBounds.midX - (contentSize.width / 2),
        y: displayBounds.midY - (contentSize.height / 2)
      )
      return WindowPlacement(position, size: contentSize)
    }
    .restorationBehavior(.disabled)
    .windowStyle(.plain)

    // Menu bar component of app
    MenuBarExtra("HTTP Status Code", systemImage: "number.circle", isInserted: $showMenuBar) {
      MenuBarView(httpSections: $httpSections)
    }
  }
}
