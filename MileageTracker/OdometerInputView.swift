
import SwiftUI

struct OdometerInputView: View {
    @Binding var odoInput: String
    var isEndingShift: Bool
    var onSave: (Double) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Enter \(isEndingShift ? "Ending" : "Starting") Odometer Reading")
                    .font(.title2)
                    .padding(.bottom, 20)
                
                TextField("Odometer Reading", text: $odoInput)
                    .keyboardType(.decimalPad)
                    .liquidGlassStyle()
                    .padding(.bottom, 30)
                    .multilineTextAlignment(.center)
                
                Button("Save") {
                    if let odo = Double(odoInput) {
                        onSave(odo)
                        dismiss()
                    }
                }
                .liquidGlassStyle()
                .buttonStyle(.plain)
                .disabled(Double(odoInput) == nil)
                
                Spacer()
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
            .foregroundColor(.white)
            .navigationTitle("Odometer Input")
        }
    }
}
