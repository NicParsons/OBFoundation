import Foundation

public extension Calendar {
	public func firstOfJuly() -> Date? {
		var components = DateComponents()
		components.second = 0
		components.minute = 0
		components.hour = 0
		components.day = 1
		components.month = 7
		let calendar = Calendar.current
		let today = Date.now
		let date = calendar.dateComponents([.year, .month], from: today)
		if let theYear = date.year, let theMonth = date.month {
			components.year = theMonth < 7 ? theYear - 1 : theYear
		} else {
			return nil
		}
		return calendar.date(from: components)
	}

	func thirtyJune() -> Date? {
		var components = DateComponents()
		components.second = 0
		components.minute = 0
		components.hour = 0
		components.day = 1
		components.month = 6
		let calendar = Calendar.current
		let today = Date.now
		let date = calendar.dateComponents([.year, .month], from: today)
		if let theYear = date.year, let theMonth = date.month {
			components.year = theMonth > 6 ? theYear + 1 : theYear
		} else {
			return nil
		}
		return calendar.date(from: components)
	}
}
