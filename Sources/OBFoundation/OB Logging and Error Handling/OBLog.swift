import Foundation
import Combine
import os
import OSLog

public class OBLog {
    public var logger: Logger

    public func log(_ message: String) {
        self.logger.log("\(message)")
		self.customLog(message)
    } // end func

	public func log(_ error: Error) {
		print(error)
		self.logger.error("\(error.localizedDescription)")
		self.customLog(error.localizedDescription)
	} // end func

    public func debug(_ message: String) {
        self.logger.debug("\(message)")
		self.customLog(message)
    } // end func

    public func info(_ message: String) {
        self.logger.info("\(message)")
		self.customLog(message)
    } // end func

    public func error(_ message: String) {
        self.logger.error("\(message)")
		self.customLog(message)
    } // end func

	public func error(_ error: OBError) {
		print(error)
		self.logger.error("\(error.description)")
		self.customLog(error.description)
	} // end func

    public func fault(_ message: String) {
        self.logger.fault("\(message)")
		self.customLog(message)
    } // end func

	public func customLog(_ message: String) {
		customLogEntries.append(OBCustomLog(message: message))
		self.logger.log("Just posted a custom OB log with the following message: \(message)")
	}

	public init(_ appName: String = "", domain: String = "app.openbooks") {
		let subsystemString = domain.adding(appName)
		logger = Logger(subsystem: subsystemString, category: "general")
	} // init
} // end class

public var customLogEntries: [OBCustomLog] = []
public var currentOBErrorNotification: OBErrorNotification?
