import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MileageViewModel()
    
    @State private var showOdoPrompt = false
    @State private var isEndingShift = false
    @State private var odoInput = ""
    
    @State private var offShiftStartOdo = ""
    @State private var offShiftEndOdo = ""
    
    @State private var selectedEvent: MileageEvent? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                Text("Mileage Tracker")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Button {
                    isEndingShift = viewModel.isOnShift
                    odoInput = ""
                    showOdoPrompt = true
                } label: {
                    Text(viewModel.isOnShift ? "End Shift" : "Start New Shift")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(viewModel.isOnShift ? Color.red : Color.green)
                        .cornerRadius(15)
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $showOdoPrompt) {
                    OdometerInputView(odoInput: $odoInput, isEndingShift: isEndingShift) { odo in
                        if viewModel.isOnShift {
                            viewModel.endShift(odo: odo)
                        } else {
                            viewModel.startShift(odo: odo)
                        }
                        showOdoPrompt = false
                    }
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Off Shift Mileage")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    
                    HStack {
                        TextField("Starting ODO", text: $offShiftStartOdo)
                            .keyboardType(.decimalPad)
                            .liquidGlassStyle()
                        
                        TextField("Ending ODO", text: $offShiftEndOdo)
                            .keyboardType(.decimalPad)
                            .liquidGlassStyle()
                    }
                    
                    Button {
                        if let start = Double(offShiftStartOdo), let end = Double(offShiftEndOdo), end >= start {
                            viewModel.addOffShiftMiles(startOdo: start, endOdo: end)
                            offShiftStartOdo = ""
                            offShiftEndOdo = ""
                        }
                    } label: {
                        Text("Add Off-Shift Miles")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    
                    Button {
                        viewModel.clearLog()
                    } label: {
                        Text("Clear Log")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(15)
                    }
                    
                    Divider()
                        .background(Color.white.opacity(0.2))
                    
                    LogView(viewModel: viewModel)
                    
                    Spacer()
                }
                .padding()
                .foregroundColor(.white)
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
            .navigationDestination(for: MileageEvent.self) { event in
                MileageEventDetailView(event: event) {
                    viewModel.delete(event: event)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
