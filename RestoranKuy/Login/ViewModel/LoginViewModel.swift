//
//  LoginViewModel.swift
//  RestoranKuy
//
//  Created by wisnu bhakti on 5/10/18.
//  Copyright © 2018 wisnu bhakti. All rights reserved.
//

import Foundation

protocol LoginDelegate {
    func loginResponse(_ data: NSObject?, _ error: Error?)
}

final class LoginViewModel {
    
    var network = NetworkService()
    var delegate : LoginDelegate?
    
    func login(email: String, password: String){
        network.login(email: email, password: password, success: { data in
            self.delegate?.loginResponse(data, nil)
        }, failure: {error in
            self.delegate?.loginResponse(nil ,error)
        })
    }
    
    
}
