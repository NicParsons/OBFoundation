import Foundation
import Combine
import os
import OSLog

class OBLog {
    var logger: Logger = Logger(subsystem: "app.openbooks.TributeCalculator", category: "general")
    
    func log(_ message: String) {
        self.logger.log("\(message)")
		self.customLog(message)
    } // end func

	func log(_ error: Error) {
		print(error)
		self.logger.error("\(error.localizedDescription)")
		self.customLog(error.localizedDescription)
	} // end func

    func debug(_ message: String) {
        self.logger.debug("\(message)")
		self.customLog(message)
    } // end func

    func info(_ message: String) {
        self.logger.info("\(message)")
		self.customLog(message)
    } // end func

    func error(_ message: String) {
        self.logger.error("\(message)")
		self.customLog(message)
    } // end func

	func error(_ error: OBError) {
		print(error)
		self.logger.error("\(error.description)")
		self.customLog(error.description)
	} // end func

    func fault(_ message: String) {
        self.logger.fault("\(message)")
		self.customLog(message)
    } // end func

	func customLog(_ message: String) {
		customLogEntries.append(OBCustomLog(message: message))
		self.logger.log("Just posted a custom OB log with the following message: \(message)")
	}
} // end class

var customLogEntries: [OBCustomLog] = []
var currentOBErrorNotification: OBErrorNotification?

//  OBLog.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 25/12/2021.\
