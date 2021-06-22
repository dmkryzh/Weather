//
//  GenericExtentions.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//


import Foundation
import UIKit
import CoreData

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}

extension UITextField {
    func addInternalPaddings(left: CGFloat, right: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: left, height: self.frame.height))
        self.rightView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: right, height: self.frame.height))
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension NSMutableAttributedString {
    func trunc(length: Int, trailing: String = "…") -> NSMutableAttributedString {
        return (self.string.count > length ? NSMutableAttributedString(string: self.string.prefix(length - 3) + trailing) : self)
    }
}  

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.locale = Locale(identifier: "ru_RU")
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

extension UIPageViewController {

    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
    }

    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
    }
}





