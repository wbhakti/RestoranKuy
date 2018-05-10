//
//  ReportViewController.swift
//  RestoranKuy
//
//  Created by wisnu bhakti on 5/10/18.
//  Copyright © 2018 wisnu bhakti. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController,ResponseFilterTransactionDelegate {
    
    @IBOutlet weak var startDateTF: UITextField!
    @IBOutlet weak var endDateTF: UITextField!
    @IBOutlet weak var filterBTN: UIButton!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var femaleCountLBL: UILabel!
    @IBOutlet weak var maleCountLBL: UILabel!
    @IBOutlet weak var ageAverageLBL: UILabel!
    @IBOutlet weak var errorLBL: UILabel!
    
    let datePicker      = UIDatePicker()
    var reportViewModel = ReportViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportViewModel.delegete = self

        showStartDatePicker()
        showEndDatePicker()
        
        filterBTN.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func filterAction(_ sender: Any) {
        guard let startDate = startDateTF.text, let endDate = endDateTF.text else {
            return
        }
        
        if (startDate.count == 0 || endDate.count == 0){
            return
        }
        filterBTN.isEnabled  = false
        errorLBL.text        = ""
        
        reportViewModel.filterTransactionTransaction(startDate: startDate.convertTimestamp, endDate: endDate.convertTimestamp)
    }
    
    
    func showStartDatePicker(){
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton   = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneStartDatePicker))
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        startDateTF.inputAccessoryView  = toolbar
        startDateTF.inputView           = datePicker
        
    }
    
    func showEndDatePicker(){
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton   = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneEndDatePicker))
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        endDateTF.inputAccessoryView  = toolbar
        endDateTF.inputView           = datePicker
        
    }
    
    @objc func doneStartDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        startDateTF.text     = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func doneEndDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        endDateTF.text     = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func Success(_ report: Report) {
        femaleCountLBL.text = String(report.female)
        maleCountLBL.text   = String(report.male)
        ageAverageLBL.text  = String(report.age)
        
        filterBTN.isEnabled  = true
    }
    
    func Error(_ error: Error) {
        errorLBL.text = error.localizedDescription
        print("Error : ", error.localizedDescription)
        
        filterBTN.isEnabled  = true
    }
    
}
