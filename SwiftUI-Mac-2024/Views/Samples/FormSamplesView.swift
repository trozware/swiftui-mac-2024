// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct FormSamplesView: View {
  @State private var email = ""
  @State private var password = ""
  @State private var selectedDate = Date()
  @State private var pickChoice = SymbolMod.bounceMod
  @State private var showEffect = false
  @State private var multiColor = true
  @State private var selectedColor = Color.blue
  @State private var mixColor = Color.blue
  @State private var mixPercent = 0.0

  @FocusState private var emailFieldHasFocus: Bool

  var body: some View {
    VStack {
      GroupBox {
        Form {
          TextField("Enter your email address:", text: $email)
            .focused($emailFieldHasFocus)

          SecureField(
            "Enter your password:",
            text: $password,
            prompt: Text("Enter your password securely.")
          )

          DatePicker("Enter your birthday:", selection: $selectedDate, displayedComponents: [.date])
            .padding(.bottom)

          Form {
            Toggle("Multicolor mode:", isOn: $multiColor)


            Picker("Select a Symbol Effect:", selection: $pickChoice) {
              Text("Bounce").tag(SymbolMod.bounceMod)
              Text("Wiggle").tag(SymbolMod.wiggleMod)
              Text("Rotate").tag(SymbolMod.rotateMod)
              Text("Breathe").tag(SymbolMod.breatheMod)
              Text("Pulse").tag(SymbolMod.pulseMod)
              Text("Variable Color").tag(SymbolMod.variableColorMod)
            }
            .pickerStyle(.menu)

            HStack {
              Image(systemName: "rainbow")
                .font(.system(size: 50))
                .symbolRenderingMode(multiColor ? .multicolor : .monochrome)
                .symbolEffect(.bounce, value: showEffect && pickChoice == .bounceMod)
                .symbolEffect(.wiggle, value: showEffect && pickChoice == .wiggleMod)
                .symbolEffect(.rotate, value: showEffect && pickChoice == .rotateMod)
                .symbolEffect(.breathe, value: showEffect && pickChoice == .breatheMod)
                .symbolEffect(.pulse, value: showEffect && pickChoice == .pulseMod)
                .symbolEffect(.variableColor, value: showEffect && pickChoice == .variableColorMod)

              Spacer()

              Button("Show Effect") {
                showEffect.toggle()
              }
            }
          }
          .toggleStyle(.switch)
          .formStyle(.grouped)

          HStack {
            VStack(alignment: .trailing) {
              ColorPicker(selection: $selectedColor, supportsOpacity: true) {
                Text("Choose a color:")
              }
              ColorPicker(selection: $mixColor, supportsOpacity: false) {
                Text("Mix with:")
              }

              Slider(value: $mixPercent, in: 0 ... 1) {
                Text("Mix percent:")
              }
            }
            .frame(height: 50)

            Spacer(minLength: 50)

            Capsule()
              .fill(
                selectedColor
                  .mix(with: mixColor, by: mixPercent)
                  .gradient
              )
              .frame(maxWidth: .infinity)
              .frame(height: 50)
              .shadow(radius: 5)
          }
          .padding(.top)
        }
        .formStyle(.columns)
        .textFieldStyle(.roundedBorder)
        .padding()


        Spacer()
      }
      .padding()
      .onAppear {
        emailFieldHasFocus = true
      }
    }
  }
}

#Preview {
  @Previewable @State var pickChoice = SymbolMod.bounceMod
  FormSamplesView()
    .frame(height: 500)
}

enum SymbolMod: Int {
  case bounceMod
  case wiggleMod
  case rotateMod
  case breatheMod
  case pulseMod
  case variableColorMod
}
