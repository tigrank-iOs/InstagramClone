//
//  MediaFactory.swift
//  Instagram
//
//  Created by Тигран on 18/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

public class MediaFactory {
	static func createMediaObject(_ data: [String : Any]) -> MediaProtocol? {
		if data["type"] as! String == "image" {
			return Image(response: data)
		} else if data["type"] as! String == "video" {
			return Video(response: data)
		} else {
			return nil
		}
	}
}
