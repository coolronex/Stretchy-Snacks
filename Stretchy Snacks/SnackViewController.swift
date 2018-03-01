//
//  SnackViewController.swift
//  Stretchy Snacks
//
//  Created by Aaron Chong on 3/1/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

import UIKit

class SnackViewController: UIViewController, UITableViewDataSource {
    
    

    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var plusButtonOutlet: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var stackView = UIStackView()
    var titleLabel = UILabel()
    var snacksArray = [String]()
    var imageViewArray = [UIImageView]()
    var bottomConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
        let navYConstraint = titleLabel.centerYAnchor.constraint(equalTo: navBar.centerYAnchor)
        navYConstraint.identifier = "navConstraint"
        navYConstraint.isActive = true

        titleLabel.text = "Snacks"
        
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.isHidden = true
        navBar.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -8).isActive = true
        bottomConstraint = stackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -10)
        stackView.topAnchor.constraint(equalTo: navBar.topAnchor, constant: 60).isActive = true
        
        let imageView1 = UIImageView(image: #imageLiteral(resourceName: "oreos"))
        let imageView2 = UIImageView(image: #imageLiteral(resourceName: "pizza_pockets"))
        let imageView3 = UIImageView(image: #imageLiteral(resourceName: "pop_tarts"))
        let imageView4 = UIImageView(image: #imageLiteral(resourceName: "popsicle"))
        let imageView5 = UIImageView(image: #imageLiteral(resourceName: "ramen"))
        
        imageViewArray = [imageView1, imageView2, imageView3, imageView4, imageView5]
        
        for imageView in imageViewArray {
            
            stackView.addArrangedSubview(imageView)
            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.addGestureRecognizer(tapGesture)
        }
        
    }
    
    
    // MARK: Private Functions
    
    @IBAction private func plusIconPressed(_ sender: UIButton) {
        
        switch plusButtonOutlet.transform {
        case CGAffineTransform(rotationAngle: CGFloat.pi / 4.0):
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                
                self.heightConstraint.constant = 66
                self.plusButtonRotateToOriginalState(button: self.plusButtonOutlet)
                self.stackView.isHidden = true
                self.bottomConstraint.isActive = false
                
                
                for constraint in self.navBar.constraints {
                    if constraint.identifier == "navConstraint" {
                        
                        constraint.constant = 0
                    }
                }

                self.view.layoutIfNeeded()
                
            }, completion: nil)
            
        default:
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                
                self.heightConstraint.constant = 200
                
                self.bottomConstraint.isActive = true

                self.plusButtonRotate45Degrees(button: self.plusButtonOutlet)
                self.stackView.isHidden = false
                
                for constraint in self.navBar.constraints {
                    if constraint.identifier == "navConstraint" {
                        
                        constraint.constant -= 60
                    }
                }
                self.view.layoutIfNeeded()
                
            }, completion: nil)
        }
    }
    
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        tableView.beginUpdates()
        
        switch tappedImage {
        case imageViewArray[0]:
            snacksArray.insert("Oreos", at: 0)
        case imageViewArray[1]:
            snacksArray.insert("Pizza Pockets", at: 0)
        case imageViewArray[2]:
            snacksArray.insert("Pop Tarts", at: 0)
        case imageViewArray[3]:
            snacksArray.insert("Popsicle", at: 0)
        default:
            snacksArray.insert("Ramen", at: 0)
        }
        let newIndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        
        tableView.endUpdates()
    }
    
    private func plusButtonRotate45Degrees(button: UIButton) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4.0)
        }, completion: nil)
    }
   
    private func plusButtonRotateToOriginalState(button: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            button.transform = CGAffineTransform(rotationAngle: 0)
        }, completion: nil)
        
    }
    
    // MARK: TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let snacks = snacksArray[indexPath.row]
        
        cell.textLabel!.text = snacks
        
        return cell
    }
    


}
