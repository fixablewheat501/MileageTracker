import SwiftUI

struct LogView: View {
    @ObservedObject var viewModel: MileageViewModel  // to handle deletion
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mileage Log")
                .font(.title3)
                .bold()
                .foregroundColor(.white)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 15) {
                    ForEach(viewModel.events) { event in
                        NavigationLink(value: event) {
                            HStack {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(event.type.rawValue)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text(event.timestamp, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text(String(format: "%.1f miles", event.milesTraveled))
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(maxHeight: 300)
        }
    }
}
