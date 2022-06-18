import Foundation

struct OBCustomLog: Identifiable, Codable, Hashable {
	var id = UUID()
	var date = Date()
	var message: String
	var priority: LogType = .debug

	enum LogType: String, Hashable, CaseIterable, Codable {
case debug, error
	}
}

//  OBCustomLog.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 3/4/2022
