//
//  AuthorizationService.swift
//  Instagram
//
//  Created by Тигран on 10/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

public class AuthorizationService {
	private let loginCommand: AuthorizationCommand
	private let logoutCommand: AuthorizationCommand
	
	init() {
		loginCommand = Login()
		logoutCommand = Logout()
	}
	
	public func login() {
		loginCommand.execute()
	}
	
	public func logout() {
		logoutCommand.execute()
	}
}
