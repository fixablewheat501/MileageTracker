import Foundation

enum EventType: String, Codable {
    case onShift = "On Shift"
    case offShift = "Off Shift"
}

struct MileageEvent: Identifiable, Codable, Hashable {
    let id: UUID
    let type: EventType
    let timestamp: Date
    let startOdo: Double
    let endOdo: Double

    var milesTraveled: Double { max(endOdo - startOdo, 0) }
}
