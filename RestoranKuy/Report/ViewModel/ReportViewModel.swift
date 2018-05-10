//
//  ReportViewModel.swift
//  RestoranKuy
//
//  Created by wisnu bhakti on 5/11/18.
//  Copyright © 2018 wisnu bhakti. All rights reserved.
//

import Foundation

protocol ResponseFilterTransactionDelegate {
    func Success(_ report: Report )
    func Error(_ error: Error)
}

final class ReportViewModel{
    
    var network = NetworkService()
    var delegete : ResponseFilterTransactionDelegate?
    
    func filterTransactionTransaction(startDate: String, endDate: String){
        network.filterTransaction(startDate: startDate, endDate: endDate, success: {(transactions) in
            
            
            var report = Report()
            
            if (transactions.count > 0){
                let female = transactions.filter({$0.gender == "female" })
                let male   = transactions.filter({$0.gender == "male" })
                var ageCount: Int = 0
                
                for trans in transactions {
                    ageCount += trans.age!
                }
                
                report.female = female.count
                report.male   = male.count
                report.age    = Double(ageCount / transactions.count)
            }

                
            self.delegete?.Success(report)
            
        }, failure: {(error) in
            self.delegete?.Error(error)
        })
    }
    
}
