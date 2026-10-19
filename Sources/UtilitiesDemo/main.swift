import Foundation
import OrbitDockUtilities

let instant = Date(timeIntervalSince1970: 1767225600)
for raw in ["UTC", "UTC+05:45", "America/New_York", "UTC+14:01"] {
    guard let zone = ClockTimeZone.parse(raw) else {
        print("Rejected invalid time zone: \(raw)")
        continue
    }
    let caption = ClockZoneCaption.text(["showTimezone": "true", "timezone": raw], date: instant)
    print("\(raw) => \(zone.storedValue) | \(caption)")
}
var tracker = BadgeTracker()
let fixture = "/Applications/Demo.app"
let baseline = tracker.apply([fixture: "2"], complete: true, activePaths: [fixture])
let attention = tracker.apply([fixture: "3"], complete: true, activePaths: [fixture])
print("Initial baseline alerts: \(baseline.count); subsequent increase alerts: \(attention.count)")
