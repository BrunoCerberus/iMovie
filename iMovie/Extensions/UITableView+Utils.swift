//
//  UITableView+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

public extension UITableView {
    func register(_ cell: UITableViewCell.Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func register(nibName: String, identifier: String? = nil) {
        let nib = UINib(nibName: nibName, bundle: nil)
        if let identifier = identifier {
            register(nib, forCellReuseIdentifier: identifier)
        } else {
            register(nib, forCellReuseIdentifier: nibName)
        }
    }

    func registerHeaderFooter(_ reusableView: UITableViewHeaderFooterView.Type) {
        let nib = UINib(nibName: reusableView.identifier, bundle: nil)

        register(nib, forHeaderFooterViewReuseIdentifier: reusableView.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(of class: T.Type,
                                                 for indexPath: IndexPath,
                                                 configure: @escaping ((T) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        if let typedCell = cell as? T {
            configure(typedCell)
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(of class: T.Type) -> T? {
        let view = dequeueReusableHeaderFooterView(withIdentifier: T.identifier)
        if let typedView = view as? T {
            return typedView
        }
        return nil
    }
    
    func genericDequeueReusableCell(of identifier: String,
                                    for indexPath: IndexPath,
                                    configure: @escaping ((UITableViewCell) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configure(cell)
        return cell
    }
    
    func setHeightTableHeaderView(height: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let headerView = self?.tableHeaderView else { return }
            var newFrame = headerView.frame
            newFrame.size.height = height
            
            UIView.animate(withDuration: 0.1) {
                self?.beginUpdates()
                headerView.frame = newFrame
                self?.endUpdates()
            }
        }
    }
    
    func setHeightTableFooterView(height: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let footerView = self?.tableFooterView else { return }
            var newFrame = footerView.frame
            newFrame.size.height = height
            
            UIView.animate(withDuration: 0.1) {
                self?.beginUpdates()
                footerView.frame = newFrame
                self?.endUpdates()
            }
        }
    }
    
    func shareImage(withFooterCell: Bool = false) -> UIImage? {
        let numberOfSections = self.numberOfSections
        guard numberOfSections > 0, self.numberOfRows(inSection: 0) > 0 else {
            return nil
        }
        
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        
        var height: CGFloat = 0.0
        for section in 0..<numberOfSections {
            var numberOfRows: Int = 0
            if withFooterCell {
                numberOfRows = self.numberOfRows(inSection: section)
            } else {
                numberOfRows = (self.numberOfRows(inSection: section) - 1)
            }
            
            var cellHeight: CGFloat = 0.0
            for row in 0..<numberOfRows {
                let indexPath = IndexPath(row: row, section: section)
                guard let cell = self.cellForRow(at: indexPath) else { continue }
                cellHeight = cell.frame.size.height
            }
            height += cellHeight * CGFloat(self.numberOfRows(inSection: section))
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.contentSize.width, height: height), false, UIScreen.main.scale)
        
        for section in 0..<numberOfSections {
            var numberOfRows: Int = 0
            if withFooterCell {
                numberOfRows = self.numberOfRows(inSection: section)
            } else {
                numberOfRows = (self.numberOfRows(inSection: section) - 1)
            }
            
            for row in 0..<numberOfRows {
                let indexPath = IndexPath(row: row, section: section)
                guard let cell = self.cellForRow(at: indexPath) else { continue }
                cell.contentView.drawHierarchy(in: cell.frame, afterScreenUpdates: true)
                
                if row < self.numberOfRows(inSection: section) - 1 {
                    self.scrollToRow(at: IndexPath(row: row+1, section: section), at: .bottom, animated: false)
                }
            }
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
            completion()
        })
    }
}
