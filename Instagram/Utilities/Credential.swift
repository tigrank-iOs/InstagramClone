//
//  Credential.swift
//  Instagram
//
//  Created by Тигран on 13/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

protocol CredentialProtocol {
	static var userIsAuthorized: Bool { get }
	static var token: String? { get set }
}

public class Credential: CredentialProtocol {
	public static let shared = Credential()
	
	private init() { }
	
	static var userIsAuthorized: Bool {
		if token != nil {
			return true
		}
		return false
	}
	
	static var token: String? {
		get {
			return UserDefaults.standard.value(forKey: "token") as? String
		}
		set {
			UserDefaults.standard.set(newValue, forKey: "token")
		}
	}
}
