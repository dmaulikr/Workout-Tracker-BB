//
//  StoreTVC.swift
//  90 DWT BB
//
//  Created by Grant, Jared on 6/23/16.
//  Copyright © 2016 Grant, Jared. All rights reserved.
//

import UIKit

class StoreTVC: UITableViewController {
    
    var products = [SKProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Store"
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(StoreTVC.reload), for: .valueChanged)
        
        let restoreButton = UIBarButtonItem(title: "Restore", style: .plain, target: self, action: #selector(StoreTVC.restoreTapped(_:)))
        navigationItem.rightBarButtonItem = restoreButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(StoreTVC.handlePurchaseNotification(_:)),
                                                         name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification),
                                                         object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reload()
    }
    
    func reload() {
        
        products = []
        
        //tableView.reloadData()
        
        Products.store.requestProducts{success, products in
            if success {
                self.products = products!
                
                self.tableView.reloadData()
            }
            
            self.refreshControl?.endRefreshing()
        }
    }
    
    func restoreTapped(_ sender: AnyObject) {
        Products.store.restorePurchases()
    }
    
    func handlePurchaseNotification(_ notification: Notification) {
        guard let productID = notification.object as? String else { return }
        
        for (index, product) in products.enumerated() {
            guard product.productIdentifier == productID else { continue }
            
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
    }
}

// MARK: - UITableViewDataSource

extension StoreTVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
        
        cell.product = product
        cell.buyButtonHandler = { product in
            Products.store.buyProduct(product)
        }
        
        return cell
    }
}

