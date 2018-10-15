//
//  AuthorizationCommand.swift
//  Instagram
//
//  Created by Тигран on 10/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

protocol AuthorizationCommand {
	func execute()
}

class Login: AuthorizationCommand {
	func execute() {
		UIApplication.topViewController?.present(UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
	}
}

class Logout: AuthorizationCommand {
	func execute() {
		Credential.token = nil
		UIApplication.topViewController?.present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.authVCId), animated: true, completion: nil)
	}
}
