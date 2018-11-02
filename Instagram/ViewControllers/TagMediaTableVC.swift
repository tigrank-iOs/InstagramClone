//
//  TagMediaTableVC.swift
//  Instagram
//
//  Created by Тигран on 16/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

class TagMediaTableVC: UITableViewController {

	var media: [MediaProtocol] = []
	var tag: Tag!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "#" + tag.name
		loadMedia()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.mediaCellId, for: indexPath) as! MediaCell
		let cellSetuper = CellBuilder(with: cell, media: media[indexPath.row])
		return cellSetuper.getCell()
    }
	
	private func loadMedia() {
		APIManager.shared.getMedia(for: tag) { (newMedia) in
			if let newMedia = newMedia {
				self.media = newMedia
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}

}
