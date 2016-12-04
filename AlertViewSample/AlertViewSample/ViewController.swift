//
//  ViewController.swift
//  AlertViewSample
//
//  Created by naoko kubo on 2016/12/04.
//  Copyright © 2016年 Interrupt LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func type1Clicked(){
        let alertView = MyAlertViewController(title: "type1AlertView", desc: "説明文はここに入れます。")
        present(alertView, animated: true, completion: nil)
    }

    @IBAction func normalClicked(){
        let alert:UIAlertController = UIAlertController(title:"normalAlertView",
                                                        message: "説明文はここに入れます。",
                                                        preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
}

