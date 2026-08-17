import Cocoa
import FlutterMacOS
import EventKit

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    CalendarChannel.register(messenger: flutterViewController.engine.binaryMessenger)

    super.awakeFromNib()
  }
}

/// Bridges the device calendar (EventKit) to Flutter over a method channel.
/// Kept in this already-compiled file so no Xcode project changes are needed.
class CalendarChannel {
  static let channelName = "multitudes/calendar"
  private let store = EKEventStore()

  static func register(messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: messenger)
    let instance = CalendarChannel()
    channel.setMethodCallHandler { call, result in
      instance.handle(call, result: result)
    }
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "requestAccess":
      requestAccess(result: result)
    case "listCalendars":
      listCalendars(result: result)
    case "eventsInRange":
      guard let args = call.arguments as? [String: Any],
            let startMs = args["startMs"] as? NSNumber,
            let endMs = args["endMs"] as? NSNumber else {
        result(FlutterError(code: "bad_args",
                            message: "startMs and endMs are required", details: nil))
        return
      }
      fetchEvents(startMs: startMs.doubleValue, endMs: endMs.doubleValue, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func requestAccess(result: @escaping FlutterResult) {
    let done: (Bool, Error?) -> Void = { granted, _ in
      DispatchQueue.main.async { result(granted) }
    }
    if #available(macOS 14.0, *) {
      store.requestFullAccessToEvents(completion: done)
    } else {
      store.requestAccess(to: .event, completion: done)
    }
  }

  private func listCalendars(result: @escaping FlutterResult) {
    let mapped: [[String: Any]] = store.calendars(for: .event).map { c in
      [
        "id": c.calendarIdentifier,
        "title": c.title,
        "account": c.source?.title ?? NSNull(),
        "type": Self.typeName(c.type),
      ]
    }
    result(mapped)
  }

  private static func typeName(_ t: EKCalendarType) -> String {
    switch t {
    case .local: return "local"
    case .calDAV: return "calDAV"
    case .exchange: return "exchange"
    case .subscription: return "subscription"
    case .birthday: return "birthday"
    @unknown default: return "other"
    }
  }

  private func fetchEvents(startMs: Double, endMs: Double, result: @escaping FlutterResult) {
    let start = Date(timeIntervalSince1970: startMs / 1000.0)
    let end = Date(timeIntervalSince1970: endMs / 1000.0)
    let predicate = store.predicateForEvents(withStart: start, end: end, calendars: nil)
    let mapped: [[String: Any]] = store.events(matching: predicate).map { e in
      [
        "id": e.eventIdentifier ?? UUID().uuidString,
        "title": e.title ?? "",
        "notes": e.notes ?? NSNull(),
        "startMs": Int(e.startDate.timeIntervalSince1970 * 1000),
        "endMs": Int(e.endDate.timeIntervalSince1970 * 1000),
        "allDay": e.isAllDay,
        "calendar": e.calendar?.title ?? NSNull(),
        "calendarId": e.calendar?.calendarIdentifier ?? NSNull(),
      ]
    }
    result(mapped)
  }
}
