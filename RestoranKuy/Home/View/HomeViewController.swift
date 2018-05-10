//
//  HomeViewController.swift
//  RestoranKuy
//
//  Created by wisnu bhakti on 5/10/18.
//  Copyright © 2018 wisnu bhakti. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController,ResponseGetAllTransactionDelegate {
    
    var homeViewModel = HomeViewModel()
    var transactions  = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogout))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Report", style: .plain, target: self, action: #selector(showReport))
        
        homeViewModel.delegete = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserLogin()
    }
    
    
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
        } catch let logoutErr {
            print(logoutErr)
        }
        
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    
    @objc func showReport
        (){
        let reportController = ReportViewController()
        navigationController?.pushViewController(reportController, animated: true)
    }
    
    private func checkUserLogin(){
        if Auth.auth().currentUser?.uid == nil {
            handleLogout()
        }else{
            homeViewModel.getAllTransaction()
        }
    }
    
    
    // response get all transaction
    func Success(_ transactions: [Transaction]) {
        print("transactions : ",transactions)
        
        self.transactions = transactions
        self.tableView.reloadData()
    }
    
    func Error(_ error: Error) {
        print(error)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TransactionViewCell", owner: self, options: nil)?.first as! TransactionViewCell
        
        cell.transDateLBL.text  = transactions[indexPath.row].trans_date?.convertDateTime
        cell.ageLBL.text        = String(describing: transactions[indexPath.row].age!)
        cell.amountLBL.text     = transactions[indexPath.row].trans_amount?.currencyFormatString
        cell.genderLBL.text     = transactions[indexPath.row].gender
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

