//
//  UIApplication EXT.swift
//  Instagram
//
//  Created by Тигран on 10/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

extension UIApplication {
	static var topViewController: UIViewController? {
		if var topController = UIApplication.shared.keyWindow?.rootViewController {
			while let presentedVC = topController.presentedViewController {
				topController = presentedVC
			}
			return topController
		}
		return nil
	}
}
