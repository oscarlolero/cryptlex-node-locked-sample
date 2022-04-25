//
//  ViewController.swift
//  Node Locked POC
//
//  Created by Oscar Montes Camberos on 4/25/22.
//

import UIKit
import LexActivator

class ViewController: UIViewController {

    @IBOutlet weak var setupLabel: UILabel!
    @IBOutlet weak var lincenseStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup LexActivator
        var status: Int32 = SetProductData("RDQ0NDYzNTE4RTExNjI4NkYzNTIwRUQ1NjlDNDU1NEE=.U7O5nqpbHz97bxPfM3fz7ps1FeNyTkVEDRNIBRo7SqwGkMw2s1nhiUrc/WbYGuM6iA3AShJTsq8nv9kZ6ekvLOGQyFdzRV4Vte0oDx8OeAGBU3/lA4sVlbQBzTa/YLy4s4vALeLF7Dl3knmd3ljdh7YPjQWZLNcdDffAHj7/8jD8/BwZBpwd5txMrG9H8TK0D5rzddessH3yZlZT7cROVD7Y/Hk4+86iFK9riUrSigncPsj58oNOm78Qf1MzOMoPf02xqXjcpY98PMyvGUx2c4rY5ENzU4p6bJUx+jaOfbpykmHRWgtE31IzEQ1wa4PnN1wHkFHx0Onxqy2Ulx3j3dbk7rHz3wx2NWBmq1lONQvZVAJobP1P7IvcOjwailK/uU/qkFx6A65G9BN2j3hawcD0+fdDxpm5sczFVn/uNdtt720+S6gAXFCLE8sW7VU89eM2PyRgxmY9lwN9ev5Fsg2HlC3opbQV/4DqMTQfpMxH0uTBkFi30Lc900g4GAJHjUv/4J+6EJDKoLzFdjQnMgJo6PniV3ObfCzWQPwA+EXKR0tPHfKW/jXpAEZdEfJKrc8yp2BVsMts/THgUFgHh8zTsTpTIywkqjmTKmX8tN1x6BM4N7OsAm0eFI/XcTO7tgSjH7tpdkKUnxAaq4UNIPJkwpzfrzQcJy1etNQJRW7FmG8UfhBzYSm4aC87fs1pu6Lf3Z+yUfki7rt7cpDfVL6ZLSf2aVLQ2VrTSLnKItiZJWEROOzFr9xO1V1IhrF5")
        
        if status != LA_OK.rawValue {
            print("setproductdata error: \(status)")
            return
        }
        
        status = SetProductId("dc955daa-d192-44c6-b0f8-7c5adf5a2b85", LA_USER)
        
        if status != LA_OK.rawValue {
            print("setproductid error: \(status)")
            return
        } else {
            setupLabel.text = "Node Locked lincense has been configured correctly."
        }
        
        //Check license status
        status = IsLicenseGenuine()
        
        switch status {
            case Int32(LA_OK.rawValue):
                lincenseStatusLabel.text = "The license is active."
            case Int32(LA_FAIL.rawValue):
                lincenseStatusLabel.text = "There is no activated license."
            case Int32(LA_SUSPENDED.rawValue):
                lincenseStatusLabel.text = "The license is suspended."
            default:
                lincenseStatusLabel.text = "Error, check log"
                print("error: \(status)")
        }
        
    }

    @IBAction func activateLicenseTap(_ sender: Any) {
        var status: Int32 = 0
        let licenseKey = "BE9BEF-A2AD01-4C2CAE-D5A955-272412-161748"
        
        status = SetLicenseKey(licenseKey)
        
        if status != LA_OK.rawValue {
            print("setlicensekey error: \(status)")
            return
        }
        
        status = ActivateLicense()
        	
        if status == LA_OK.rawValue {
            lincenseStatusLabel.text = "The license is active."
        } else {
            print("activatelicense error: \(status)")
        }
    }
    
    @IBAction func deactivateLicenseTap(_ sender: Any) {
        var status: Int32 = 0
        
        status = DeactivateLicense()
        
        if status == LA_OK.rawValue {
            lincenseStatusLabel.text = "There is no activated license."
            return
        } else {
            print("activatelicense error: \(status)")
        }
        
    }
}

