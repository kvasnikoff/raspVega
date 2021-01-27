//
//  FullScheduleViewController.swift
//  raspVega
//
//  Created by Peter Kvasnikov on 06.12.2020.
//

import UIKit

class FullScheduleViewController: UIViewController {
    
    let raspImage = UIImage(named: "rasp")
    let raspImageView = UIImageView()

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupImage()
    
        
    }
    
    func setupImage(){
        
        raspImageView.image = raspImage
        raspImageView.contentMode = .scaleAspectFit
        
        
        view.addSubview(raspImageView)
        
        raspImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        raspImageView.topAnchor.constraint(equalTo: view.topAnchor),
        raspImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        raspImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        raspImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                        
        ])
        
        
        
        raspImageView.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onClickImageView))
        raspImageView.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(actionPinchGesture))
        raspImageView.addGestureRecognizer(pinchGesture)
        

        
        
    }
    
    
    
    @objc func onClickImageView(recogizer: UIPanGestureRecognizer) {
        let translation = recogizer.translation(in: self.view)
        if let view = recogizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        
        recogizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    @objc func actionPinchGesture(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    
    
    
}

