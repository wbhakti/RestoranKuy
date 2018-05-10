//
//  String.swift
//  RestoranKuy
//
//  Created by wisnu bhakti on 5/10/18.
//  Copyright © 2018 wisnu bhakti. All rights reserved.
//

import Foundation

extension String{
    var currencyFormatString: String {
        guard !self.isEmpty else {
            return self
        }
        
        let formatter = NumberFormatter.currencyFormatter
        guard let doubleValue = Double(self),
            let result = formatter.string(from: NSNumber(value: doubleValue)) else {
                return ""
        }
        
        return result
    }
    
    var convertDateTime: String {
        guard !self.isEmpty else {
            return self
        }
        
        let date = Date(timeIntervalSince1970: (TimeInterval(self)!))
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        dateFormatter.locale     = Locale(identifier: "id_ID")
        
        return dateFormatter.string(from: date)
    }
    
    var convertTimestamp: String {
        guard !self.isEmpty else {
            return self
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale     = Locale(identifier: "id_ID")
        let date = dateFormatter.date(from: self)
        let dateStamp = Int(date!.timeIntervalSince1970) //convert to int because firebase cannot filter decimal
        
        return String(dateStamp)
    }
}


