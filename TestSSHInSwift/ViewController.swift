//
//  ViewController.swift
//  TestSSHInSwift
//
//  Created by Solan Manivannan on 28/04/2018.
//  Copyright © 2018 Solan Manivannan. All rights reserved.
//

import UIKit
import NMSSH

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        let session = NMSSHSession(host: "", andUsername: "solan1803")
        session?.connect()
        if (session?.isConnected)! {
            print("Session connected")
            session?.authenticate(byPassword: "")
            if (session?.isAuthorized)! {
                print("Authentication succeeded")
                do {
                    var response = try session?.channel.execute("ls")
                    if let r = response {
                        print("List of Files: ")
                        print(r)
                    }
                    // Create test.java file
                    print("Creating test.java file")
                    response = try session?.channel.execute("echo \"public class test { \n public static void main(String[] args) { \n System.out.println(\\\"Hello World, from Azure\\\"); \n } \n }\" > test.java")
                    if let r = response {
                        print("Creating test.java")
                        print(r)
                    }
                    // Compile test.java
                    print("Compiling test.java")
                    var err : NSError?
                    response = session?.channel.execute("javac test.java", error: &err, timeout: 10)
                    if let error = err {
                        print("Error: \n \(error.localizedDescription)")
                    }
                    if let r = response {
                        print(r)
                    }
                    // Run test.java
                    response = try session?.channel.execute("java test")
                    if let r = response {
                        print("Running test.java")
                        print(r)
                    }
                } catch {
                    print(error)
                }
            }
        }
        session?.disconnect()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

