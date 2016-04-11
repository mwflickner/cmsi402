//
//  HelperMethods.swift
//  Desi
//
//  Created by Matthew Flickner on 1/19/16.
//  Copyright © 2016 Desi. All rights reserved.
//

import Foundation
import UIKit

let desiColor = UIColor(netHex:0xF04D4D)

func setErrorColor(textField: UITextField) {
    let errorColor : UIColor = UIColor.redColor()
    textField.layer.borderColor = errorColor.CGColor
    textField.layer.borderWidth = 1.5
}

func setSuccessColor(textField: UITextField) {
    let successColor : UIColor = UIColor( red: 0.3, green: 0.5, blue:0.3, alpha: 1.0 )
    textField.layer.borderColor = successColor.CGColor
    textField.layer.borderWidth = 1.5
}

func removeErrorColor(textField: UITextField) {
    textField.layer.borderColor = nil
    textField.layer.borderWidth = 0
}

func borderTableView(tableView: UITableView) {
    let borderColor: UIColor = UIColor.blackColor()
    tableView.layer.borderColor = borderColor.CGColor
    tableView.layer.borderWidth = 1.5
}

func isValidUsername(testStr: String) -> Bool {
    let usernameRegEx = "^[a-z0-9_-]{4,16}$"
    let usernameTest = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
    return usernameTest.evaluateWithObject(testStr)
}