//
//  ViewController.swift
//  LanguageManger
//
//  Created by Mohamed on 5/05/17.
//  Copyright © 2017 mohamedz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var frenchButton: UIButton!
    @IBOutlet weak var spanishButton: UIButton!
    @IBOutlet weak var labelUpdate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = LanguageManager.sharedInstance
        self.initView()
        self.labelUpdate.text = NSLocalizedString("hello", comment: "")
        NotificationCenter.default.addObserver(self, selector: #selector(self.languageDidChangeNotification(_:)), name: Notification.Name("LANGUAGE_DID_CHANGE"), object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func changeButtonBackround(_ button: UIButton){
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.reloadInputViews()
    }
    
    fileprivate func initView(){
        englishButton.layer.borderColor = UIColor.white.cgColor
        englishButton.layer.backgroundColor = UIColor.black.cgColor
        englishButton.titleLabel?.text = "en"
        englishButton.titleLabel?.textColor = UIColor.white
        
        frenchButton.layer.borderColor = UIColor.white.cgColor
        frenchButton.titleLabel?.text = "fr"
        frenchButton.layer.backgroundColor = UIColor.black.cgColor
        frenchButton.titleLabel?.textColor = UIColor.white

        spanishButton.layer.borderColor = UIColor.white.cgColor
        spanishButton.titleLabel?.text = "es"
        spanishButton.layer.backgroundColor = UIColor.black.cgColor
        spanishButton.titleLabel?.textColor = UIColor.white

    }
    
    
    //MARK: Languages functions
    
    func languageDidChangeNotification(_ notification:Notification){
        changeLanguage()
    }
    
    func changeLanguage(){
        self.labelUpdate.text = NSLocalizedString("hello", comment: "")
    }
    
    func setupLanguage(){
        initView()
         switch LanguageManager.sharedInstance.currentLanguage {
        case "en" :
            self.changeButtonBackround(englishButton)
        case "fr":
            self.changeButtonBackround(frenchButton)
        case "es":
            self.changeButtonBackround(spanishButton)
        default : break
        }
     }
    
    
    @IBAction func switchLanguage(_ sender: UIButton) {
        var localeString:String?
        initView()
         switch sender {
        case englishButton:
            localeString = "en"
            self.changeButtonBackround(englishButton)
        case frenchButton:
            localeString = "fr"
            self.changeButtonBackround(frenchButton)
            
        case spanishButton:
            localeString = "es"
            self.changeButtonBackround(spanishButton)
            
        default: localeString = nil
        }
        
        if let localeString = localeString {
            NotificationCenter.default.post(name: Notification.Name("LANGUAGE_WILL_CHANGE"), object: localeString)
        }
    }

}

