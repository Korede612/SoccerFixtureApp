//
//  Extensions+Controller.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 21/02/2025.
//

import UIKit

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - CGFloat(Double(message.count) * 4), y: self.view.frame.size.height * 0.5, width: CGFloat(message.count * 8), height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut) {
            toastLabel.alpha = 0.0
        } completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
    
    
    func showAlert(title: String, message: String, positive: String, negavite: String? = nil, completion: (() -> Void)? = nil, cancel: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: positive, style: .default, handler: { action in
            if completion != nil {
                completion!()
            }
        }))
        if negavite != nil && !negavite!.isEmpty {
            alert.addAction(UIAlertAction(title: negavite, style: .default, handler: { action in
                if cancel != nil {
                    cancel!()
                }
            }))
        }
        self.present(alert, animated: true)
        return alert
    }
}

extension UICollectionView {
    
    class func genericCollectionView(direction: UICollectionView.ScrollDirection) -> UICollectionView {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        collectionLayout.minimumInteritemSpacing = 10.0
        collectionLayout.minimumLineSpacing = 10.0
        collectionLayout.scrollDirection = direction
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }
}

extension UIView {
    
    class func bgView() -> UIView {
        let view = UIView()
        
        return view
    }
    
    class func customShadowView() -> UIView {
        let view = UIView()
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false

        return view
    }
}

extension UIView{
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        width: CGFloat = 0,
        height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerAnchor(axis: UIAxis? = nil,
                      on view: UIView,
                         height: NSLayoutDimension? = nil,
                         heightMultiplier: CGFloat = 1,
                      width: NSLayoutDimension? = nil,
                         widthMultiplier: CGFloat = 1) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .both:
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        case .horizontal:
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        case .vertical:
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        default:
            break
        }
        if let height = height {
            self.heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.topAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.trailingAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.bottomAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.leadingAnchor
    }
    
}

extension UILabel {
    
    class func textLabel(fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        return label
    }
    
    class func headerTextLabel(fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .justified
        label.font = .boldSystemFont(ofSize: fontSize)
        label.numberOfLines = 0
        return label
    }
    
    class func infoLabel(text: String, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        return label
    }
}
