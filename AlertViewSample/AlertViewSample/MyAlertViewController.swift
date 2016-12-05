//
//  MyAlertViewController.swift
//  AlertViewSample
//
//  Created by naoko kubo on 2016/12/04.
//  Copyright © 2016年 Interrypt LLC. All rights reserved.
//

import UIKit

class MyAlertViewController: UIViewController,UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleText:String = ""
    var messageText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        titleLabel.text = titleText
        messageLabel.text = messageText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil:String?, bundle ninBundleOrNil:Bundle? ){
        super.init(nibName:nibNameOrNil,bundle:ninBundleOrNil)
        self.transitioningDelegate = self
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom
        
    }

    convenience init(title:String,desc:String){
        self.init(nibName:"MyAlertViewController",bundle:nil)
        titleText = title
        messageText = desc
    }
    
    required init?(coder aDecider: NSCoder){
        fatalError("init error")
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertAnimation(show:true)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertAnimation(show:false)
    }
    
    @IBAction func cancelClicked(){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func okClicked(){
        dismiss(animated: true, completion: nil)
    }
}


class AlertAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    
    let show: Bool
    
    init(show: Bool) {
        self.show = show
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if (show) {
            return 0.45
        } else {
            return 0.25
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if (show) {
            self.presentAnimateTransition(transitionContext: transitionContext)
        } else {
            self.dismissAnimateTransition(transitionContext: transitionContext)
        }
    }
    
    func presentAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let alertVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! MyAlertViewController
        alertVC.view.frame = UIScreen.main.bounds
        let containerView = transitionContext.containerView
        alertVC.alertView.alpha = 0.0
        alertVC.alertView.center = alertVC.view.center
        alertVC.alertView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        containerView.addSubview(alertVC.view)
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                                    alertVC.view.alpha = 1.0
                                    alertVC.alertView.alpha = 1.0
                                    alertVC.alertView.transform = CGAffineTransform.init(scaleX: 1.05, y:1.05)
        },
                                   completion: { finished in
                                    UIView.animate(withDuration:0.2,
                                                    animations: {
                                                    alertVC.alertView.transform = CGAffineTransform.identity
                                    },
                                                    completion: { finished in
                                                            if (finished) {
                                                                    transitionContext.completeTransition(true)
                                                            }
                                    })
        })
    }
    func dismissAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let alertVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! MyAlertViewController
        
        UIView.animate(withDuration:self.transitionDuration(using: transitionContext),
                                   animations: {
                                    alertVC.view.alpha = 0.0
                                    alertVC.alertView.alpha = 0.0
                                    alertVC.alertView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        },
                                   completion: { finished in
                                    transitionContext.completeTransition(true)
        })
    }
}

