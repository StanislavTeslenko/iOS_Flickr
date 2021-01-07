//
//  TableViewController.swift
//  iOS_Flickr
//
//  Created by Stanislav Teslenko on 13.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewController: UITableViewController {
    
    var cameras: [Camera] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SmallTableViewCell", bundle: nil), forCellReuseIdentifier: "SmallCell")
        tableView.register(UINib(nibName: "LargeTableViewCell", bundle: nil), forCellReuseIdentifier: "LargeCell")
        
        searchBar.delegate = self
        
        sendRequest(for: "apple")
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.tableFooterView = UIView()
        
    }
    
    private func sendRequest(for brand: String) {
        
        NetworkManager.sendRequest(for: brand) { (cameras) in
            self.cameras = cameras?.cameras?.camera ?? []
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cameras.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let camera = cameras[indexPath.row]
        let imageUrl: URL?
        
        if camera.details != nil {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LargeCell", for: indexPath) as! LargeTableViewCell
            
            if let imageString = camera.images?.large {
                imageUrl = URL(string: imageString)}
            else if let imageString = camera.images?.small {
                imageUrl = URL(string: imageString)
            } else {
                imageUrl = nil
            }
            
            cell.titleLabel?.text = camera.name
            
            cell.megapixelsLabel.text = camera.details?.megapixels != nil ? (camera.details?.megapixels)! + " Mp" : "n/a"
            cell.screensizeLabel.text = camera.details?.screenSize != nil ? (camera.details?.screenSize)! + " ''" : "n/a"
            cell.memorytypeLabel.text = camera.details?.memoryType != nil ? (camera.details?.memoryType)! : "n/a"
            
            cell.photo?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "camera_placeholder"))
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallCell", for: indexPath) as! SmallTableViewCell
            
            if let imageString = camera.images?.small {
                imageUrl = URL(string: imageString)
            } else {
                imageUrl = nil
            }
            
            cell.titleLabel?.text = camera.name
            
            cell.photo?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "camera_placeholder"))
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.deselectRow(at: indexPath, animated: false)
        return nil
    }
}

extension TableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        sendRequest(for: searchBar.text!)
        searchBar.resignFirstResponder()
    }
}
