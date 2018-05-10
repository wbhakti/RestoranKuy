//
//  NetworkService.swift
//  RestoranKuy
//
//  Created by wisnu bhakti on 5/10/18.
//  Copyright © 2018 wisnu bhakti. All rights reserved.
//

import Foundation
import Firebase

final class NetworkService {

    private let ref = Database.database().reference(fromURL: "https://fir-app-2cb8e.firebaseio.com/")
    
    func login(email: String, password: String, success: @escaping((_ data: NSObject) -> Void), failure: @escaping((_ error: Error) -> Void)){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error )in
            guard user != nil else {
                failure(error!)
                return
            }
            
            success(user!)
        })
    }
    
    func getAllTransaction(success : @escaping((_ transactions: [Transaction]) -> Void), failure: @escaping((_ error: Error) -> Void)){
        
        Database.database().reference().child("RestoKuy").child("transactions").queryOrdered(byChild: "trans_date").observeSingleEvent(of: .value, with: {(snapshot) in
            var transactions = [Transaction]()
            
            if let dictionaryOfTrans = snapshot.value as? [String: Any] {
                print("dictionary of transactions : ",dictionaryOfTrans)
                
                for dictionary in dictionaryOfTrans {
                    
                    if let transDict = dictionary.value as? [String: Any]{
                        var transaction = Transaction()
                        transaction.age          = transDict["age"] as? Int
                        transaction.gender       = transDict["gender"] as? String
                        transaction.trans_amount = transDict["trans_amount"] as? String
                        transaction.trans_date   = transDict["trans_date"] as? String
                        transactions.append(transaction)
                    }
                }
            }
            
            success(transactions)
            
        }, withCancel: {(Error) in
            failure(Error)
        })
        
    }

    func filterTransaction(startDate: String,endDate:String,success : @escaping((_ transactions: [Transaction]) -> Void), failure: @escaping((_ error: Error) -> Void)){
        
        Database.database().reference().child("RestoKuy").child("transactions")
            .queryOrdered(byChild: "trans_date")
            .queryStarting(atValue: startDate)
            .queryEnding(atValue: endDate)
            .observeSingleEvent(of: .value, with: {(snapshot) in
        
            var transactions = [Transaction]()
            
            if let dictionaryOfTrans = snapshot.value as? [String: Any] {
                print("dictionary of filter transactions : ",dictionaryOfTrans)
                
                for dictionary in dictionaryOfTrans {
                    
                    if let transDict = dictionary.value as? [String: Any]{
                        var transaction = Transaction()
                        transaction.age          = transDict["age"] as? Int
                        transaction.gender       = transDict["gender"] as? String
                        transaction.trans_amount = transDict["trans_amount"] as? String
                        transaction.trans_date   = transDict["trans_date"] as? String
                        transactions.append(transaction)
                    }
                }
            }
            success(transactions)
            
        }, withCancel: {(Error) in
            failure(Error)
        })
        
    }
    
}
