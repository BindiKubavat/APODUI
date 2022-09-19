//
//  APODVC.swift
//  APODUI
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import UIKit

class APODVC: UIViewController {
    
    @IBOutlet var topView: UIView!
    @IBOutlet var calendarView: UIView!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
     @IBOutlet weak var swipeButton: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var infoText: UITextView!
    @IBOutlet weak var imageApod: UIImageView!
    @IBOutlet weak var activityView: UIVisualEffectView!
    
    var viewModel: APODViewModel?
    var gradient: CAGradientLayer!
    var swipeUpGesture : UISwipeGestureRecognizer?
    var swipeDownGesture : UISwipeGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = APODViewModel.init(delegate: self)
    }
    
    @IBAction func calenderDoneClicked(_ sender: Any) {
        let date = datePicker.date
        print("Picker ======")
        print(date)
        viewModel?.calendarDoneClicked(date: date)
    }
    
    func setSwipeGestureToCalendar() {
        setUpGesture()
        setDownGesture()
    }
    
    func setUpGesture() {
        swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeUpGesture?.direction = .up
        if let gesture = swipeUpGesture {
                   swipeButton.addGestureRecognizer(gesture)
         }
    }
    
    func setDownGesture() {
        swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
            swipeDownGesture?.direction = .down
             if let gesture = swipeDownGesture {
                              swipeButton.addGestureRecognizer(gesture)
                    }
    }
    
    @objc func swipeAction(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            viewModel?.swipeUpClicked()
        case .down:
            viewModel?.swipeDownClicked()
        default:
            break
        }
    }
    func animateView(isHiden: Bool, multiplier: CGFloat) {
        
        UIView.transition(with: self.calendarView, duration: 0.33,
                          options: [.transitionFlipFromTop, .transitionFlipFromLeft],
          animations: {
            self.calendarView.alpha = isHiden ? 0 : 1
          },
          completion: { _ in
            self.calendarView.isHidden =  isHiden
            self.calendarHeightConstraint.constant = self.view.frame.size.height*multiplier
          }
        )
    }
    
    func addGradientToText(){
        gradient = CAGradientLayer()
        gradient.frame = infoText.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.gray.cgColor,UIColor.clear.cgColor]
        gradient.locations = [0,0.5, 1]
        infoText.layer.mask = gradient
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//        gradient.frame = infoText.bounds
    }
}

extension APODVC: APODViewModelDelegate {
    func showIndicator(shouldShow: Bool) {
        self.activityView.isHidden = !shouldShow
    }
    
    func showError(er: String) {
        
    }
    
    func setData(ImageData: Data?, details: String, date: String) {
        infoText.text = details
        if let dataVal = ImageData {
            imageApod.image = UIImage.init(data: dataVal)
        }
    }
    
    func hideShowBottomView(isHidden: Bool, multiplier: CGFloat) {
        self.animateView(isHiden: isHidden, multiplier: multiplier)
    }
    
    func initialiseViews() {
        setSwipeGestureToCalendar()
        setDatePicker()
//        addGradientToText()
    }
}
