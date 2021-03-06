//
//  SemanticVersion.swift
//  SemanticVersion
//
//  Created by Steffan Andrews on 2020-06-10.
//  Copyright © 2020 Steffan Andrews. All rights reserved.
//

import Foundation

/// Struct that can parse a basic SemVer version string into its components
/// ie: 1.2.450
public struct SemanticVersion {
	
	/// First number from short version
	public var major: Int?
	
	/// Second number from short version
	public var minor: Int?
	
	/// Third number from short version
	public var build: Int?
	
}

extension SemanticVersion: RawRepresentable {
	
	public var rawValue: String { description }
	
	/// Parses a short version string in the form of X.X.X (major, minor, build #)
	public init?(rawValue: String) {
		
		let components = rawValue
			.split(separator: ".")
			.map { String($0) }
		
		if components.count > 0 { major = Int(components[0]) }
		if components.count > 1 { minor = Int(components[1]) }
		if components.count > 2 { build = Int(components[2]) }
		
	}
	
}

extension SemanticVersion: Equatable {
	
	public static func == (lhs: Self, rhs: Self) -> Bool {
		
		lhs.major == rhs.major
			&& lhs.minor == rhs.minor
			&& lhs.build == rhs.build
		
	}
	
}

extension SemanticVersion: Comparable {
	
	public static func < (lhs: Self, rhs: Self) -> Bool {
		
		lhs.rawValue.compare(rhs.rawValue, options: .numeric)
			== .orderedAscending
		
	}
	
}


extension SemanticVersion: CustomStringConvertible {
	
	public var description: String {
		
		var outputString = ""
		
		if let value = major {
			outputString += "\(value)"
			
			if let value = minor {
				outputString += ".\(value)"
				
				if let value = build {
					outputString += ".\(value)"
					
				}
				
			}
			
		}
		
		return outputString
		
	}
	
}

extension SemanticVersion: Codable {
	
}
