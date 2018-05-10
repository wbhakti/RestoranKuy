//
//  HomeViewModel.swift
//  RestoranKuy
//
//  Created by wisnu bhakti on 5/10/18.
//  Copyright © 2018 wisnu bhakti. All rights reserved.
//

import Foundation

protocol ResponseGetAllTransactionDelegate {
    func Success(_ transactions: [Transaction])
    func Error(_ error: Error)
}

final class HomeViewModel{
    
    var network = NetworkService()
    var delegete : ResponseGetAllTransactionDelegate?
    
    func getAllTransaction(){
        network.getAllTransaction(success: {(transactions) in
            self.delegete?.Success(transactions)
        }, failure: {(error) in
            self.delegete?.Error(error)
        })
    }

}
