import SwiftUI

struct MileageEventDetailView: View {
    let event: MileageEvent
    var onDelete: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(event.type.rawValue)
                .font(.title)
                .bold()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Timestamp: \(dateFormatter.string(from: event.timestamp))")
                Text("Starting ODO: \(String(format: "%.1f", event.startOdo))")
                Text("Ending ODO: \(String(format: "%.1f", event.endOdo))")
                Text("Miles Traveled: \(String(format: "%.1f", event.milesTraveled))")
            }
            .font(.headline)
            
            Spacer()
            
            Button(role: .destructive) {
                onDelete()    // Remove from list
                dismiss()     // Close detail view
            } label: {
                Text("Delete Entry")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
        }
        .padding()
        .navigationTitle("Entry Details")
        .background(Color.black.ignoresSafeArea())
        .foregroundColor(.white)
    }
}
