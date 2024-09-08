import SwiftUI
import Foundation

public struct OBLogTableView: View {
	@State private var logEntries = customLogEntries
	@State private var selected: OBCustomLog.ID?
	@State var sortOrder: [KeyPathComparator<OBCustomLog>] = [
		KeyPathComparator(\.date, order: SortOrder.reverse),
		KeyPathComparator(\.message),
	]

	var table: some View {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		formatter.timeStyle = .medium
		formatter.doesRelativeDateFormatting = true
		return Table(logEntries, selection: $selected, sortOrder: $sortOrder) {
			TableColumn("Time", value: \.date) { logEntry in
				Text(formatter.string(from: logEntry.date))
			} // date column

			TableColumn("Message", value: \.message) { logEntry in
				Text(logEntry.message)
			} // message column

			TableColumn("Priority", value: \.priority.rawValue) { logEntry in
				Text(logEntry.priority.rawValue.capitalized)
			}
		} // Table view
	} // table variable

	var body: some View {
		VStack {
table
				.navigationTitle("Log")
		}
	}
}
