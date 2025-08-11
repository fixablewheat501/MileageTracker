import Foundation
import Combine

@MainActor
class MileageViewModel: ObservableObject {
    @Published private(set) var events: [MileageEvent] = [] {
        didSet { saveEvents() }
    }
    @Published var isOnShift = false
    
    private var currentShiftStartOdo: Double? = nil
    
    private let saveFileURL: URL = {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent("mileageEvents.json")
    }()
    
    init() {
        loadEvents()
    }
    
    func startShift(odo: Double) {
        currentShiftStartOdo = odo
        isOnShift = true
    }
    
    func endShift(odo: Double) {
        guard let startOdo = currentShiftStartOdo else { return }
        let event = MileageEvent(id: UUID(), type: .onShift, timestamp: Date(), startOdo: startOdo, endOdo: odo)
        events.append(event)
        currentShiftStartOdo = nil
        isOnShift = false
        sortEvents()
    }
    
    func addOffShiftMiles(startOdo: Double, endOdo: Double) {
        let event = MileageEvent(id: UUID(), type: .offShift, timestamp: Date(), startOdo: startOdo, endOdo: endOdo)
        events.append(event)
        sortEvents()
    }
    
    func delete(event: MileageEvent) {
        events.removeAll { $0.id == event.id }
        sortEvents()
    }
    
    func clearLog() {
        events.removeAll()
    }
    
    private func sortEvents() {
        events.sort { $0.timestamp < $1.timestamp }
    }
    
    // Persistence
    private func saveEvents() {
        do {
            let data = try JSONEncoder().encode(events)
            try data.write(to: saveFileURL, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error saving events: \(error)")
        }
    }
    
    private func loadEvents() {
        do {
            let data = try Data(contentsOf: saveFileURL)
            events = try JSONDecoder().decode([MileageEvent].self, from: data)
        } catch {
            print("No saved events found or failed to load: \(error)")
            events = []
        }
    }
}
