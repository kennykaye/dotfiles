#!/usr/bin/env sh

RESULT=$(swift - << 'EOF'
import Foundation
import EventKit

func truncate(_ s: String, _ max: Int) -> String {
  guard s.count > max else { return s }
  return String(s.prefix(max)) + "…"
}

func isVideoCall(_ event: EKEvent) -> Bool {
  let fields = [event.url?.absoluteString, event.notes, event.location, event.title]
  let text = fields.compactMap { $0 }.joined(separator: " ").lowercased()
  return text.contains("zoom") || text.contains("meet.google")
}

func isAccepted(_ event: EKEvent) -> Bool {
  guard let attendees = event.attendees, !attendees.isEmpty else { return true }
  return attendees.first(where: { $0.isCurrentUser })?.participantStatus == .accepted
}

let store = EKEventStore()
let semaphore = DispatchSemaphore(value: 0)

store.requestFullAccessToEvents { granted, _ in
  guard granted else { semaphore.signal(); return }

  let now = Date()
  let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
  let pred = store.predicateForEvents(withStart: now - 3600, end: tomorrow, calendars: nil)
  let events = store.events(matching: pred)
    .filter { isVideoCall($0) && isAccepted($0) }
    .sorted { $0.startDate < $1.startDate }

  // Check for an active meeting first
  if let active = events.first(where: { $0.startDate <= now && $0.endDate > now }) {
    let mins = Int(active.endDate.timeIntervalSince(now) / 60)
    let title = truncate(active.title ?? "Meeting", 25)
    print("active|\(title) · \(mins)m left")
    semaphore.signal()
    return
  }

  // Otherwise show next upcoming Zoom meeting if within 2 hours
  if let next = events.first(where: { $0.startDate > now }) {
    let mins = Int(next.startDate.timeIntervalSince(now) / 60)
    guard mins <= 120 else { semaphore.signal(); return }
    let title = truncate(next.title ?? "Meeting", 25)
    let timeStr = mins < 60 ? "in \(mins)m" : "in \(mins / 60)h \(mins % 60)m"
    print("upcoming|\(title) · \(timeStr)")
  }

  semaphore.signal()
}
semaphore.wait()
EOF
)

if [ -z "$RESULT" ]; then
  sketchybar --set "$NAME" label="" background.drawing=off
else
  LABEL="${RESULT#*|}"
  sketchybar --set "$NAME" label="$LABEL" background.drawing=on
fi
