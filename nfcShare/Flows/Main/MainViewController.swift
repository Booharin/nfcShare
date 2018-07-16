//
//  ViewController.swift
//  nfcShare
//
//  Created by Александр Бухарин on 16.07.2018.
//  Copyright © 2018 umbrella. All rights reserved.
//

import UIKit
import CoreNFC

class MainViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    @IBOutlet weak var messageLabel: UILabel!
    var nfcSession: NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func toScan(_ sender: Any) {
        nfcSession = NFCNDEFReaderSession.init(delegate: self,
                                               queue: DispatchQueue.main,
                                               invalidateAfterFirstRead: false)
        nfcSession?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        messages.forEach { message in
            message.records.forEach { record in
                if let string = String(data: record.payload, encoding: .ascii) {
                    print(string)
                    messageLabel.text = string
                }
            }
        }
    }
    
}

