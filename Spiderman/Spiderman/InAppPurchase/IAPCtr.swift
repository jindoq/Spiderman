//
//  IAPCtr.swift
//  BrainTrainer3
//
//  Created by Duy Tu Tran on 6/30/20.
//  Copyright © 2020 BeNguyen. All rights reserved.
//

import UIKit
import StoreKit

open class IAPCtr: SpidermanListView<IAPCell, SKProduct>, UITextFieldDelegate {

    @IBOutlet weak var bgIcon: UIImageView!
    var alert: PMAlertController?
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restore", style: .done, target: self, action: #selector(restoreAction))
        view.addSubviews(table)
        table.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        bgIcon.image = UIImage(named: "bg_iap", in: Bundle(for: IAPCtr.self), compatibleWith: nil)
        
        IAPProducts.store.requestProducts { (success, products) in
            if success, let arr = products {
                self.datasource = arr
            }
        }
    }
    
    @objc open func restoreAction() {
        IAPProducts.store.restorePurchases()
    }
    
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert = PMAlertController(title: "Please Enter your Year of Birth to continue", description: "This information is not stored and is only for age verification", image: nil, style: .alert)
        alert?.addTextField { (tf) in
            tf?.keyboardType = .numberPad
            tf?.becomeFirstResponder()
            tf?.delegate = self
            tf?.placeholder = "e.g. 1993"
            tf?.tag = indexPath.row
        }
        alert?.addAction(PMAlertAction(title: "Dismiss", style: .default))
        present(alert!, animated: true, completion: nil)
    }
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if text.count >= 4 {
            let year = Calendar.current.component(.year, from: Date())
            if year - (Int(text) ?? 0) >= 18 {
                IAPProducts.store.buyProduct(datasource[textField.tag])
                alert?.dismiss(animated: true, completion: nil)
            } else {
                alert?.textFields[0].text = ""
                return false
            }
        }
        return true
    }
}

open class IAPCell: SpidermanListCell<SKProduct> {
    open lazy var titleLbl: UILabel = {
        let lbl = UIMaker.makeTitleLbl()
        return lbl
    }()
    
    open lazy var contentLbl: UILabel = {
        let lbl = UIMaker.makeContentLbl()
        return lbl
    }()
    
    open lazy var icon: UIImageView = {
        let ic = UIImageView()
        ic.contentMode = .scaleAspectFit
        ic.image = UIImage(named: "ic_buy", in: Bundle(for: IAPCtr.self), compatibleWith: nil)
        return ic
    }()
    
    open override func setupView() {
        super.setupView()
        let view = UIView()
        view.backgroundColor = .white
        view.createShadow()
        addSubviews(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.top.trailing.equalToSuperview().inset(20)
            maker.bottom.equalToSuperview()
        }
        
        view.addSubviews(titleLbl, contentLbl, icon)
        titleLbl.snp.makeConstraints { (maker) in
            maker.leading.top.equalToSuperview().inset(padding)
            maker.trailing.equalTo(icon.snp.leading).inset(-padding)
        }
        contentLbl.snp.makeConstraints { (maker) in
            maker.leading.bottom.trailing.equalToSuperview().inset(padding)
            maker.top.equalTo(icon.snp.bottom).inset(-12)
        }
        icon.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(padding)
            maker.centerY.equalTo(titleLbl.snp.centerY)
            maker.height.equalTo(50)
            maker.width.equalTo(50*2.5)
        }
    }
    
    open override func configCell(_ data: SKProduct) {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = data.priceLocale
        contentLbl.text = data.localizedDescription
        
        titleLbl.text = "\(data.localizedTitle)\n\(currencyFormatter.string(from: NSNumber(value: data.price.floatValue)) ?? "")"
    }
}
