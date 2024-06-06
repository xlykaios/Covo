import SwiftData
import Foundation

@Model
class Session {
    @Attribute(.unique)
    var id: UUID
    var date: Date
    var duration: TimeInterval
    var isActive: Bool

    init(date: Date, duration: TimeInterval, isActive: Bool = true) {
        self.id = UUID()
        self.date = date
        self.duration = duration
        self.isActive = isActive
    }
}
