import Foundation

public struct OBCustomLog: Identifiable, Codable, Hashable {
	public var id = UUID()
	public var date = Date()
	public var message: String
	public var priority: LogType = .debug

	public enum LogType: String, Hashable, CaseIterable, Codable {
case debug, error
	}
}

//  OBCustomLog.swift
//  Created by Nicholas Parsons on 3/4/2022
