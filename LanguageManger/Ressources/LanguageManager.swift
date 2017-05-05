//
//  LanguageManager.swift
//  LanguageManger
//
//  Created by Mohamed on 5/05/17.
//  Copyright © 2017 mohamedz. All rights reserved.
//

import Foundation

class LanguageManager{
    
    //MARK: - Singleton
    //////////////////////////////////////////////////////////////////////////
    
    static let sharedInstance = LanguageManager()
    
    //MARK: - Init
    //////////////////////////////////////////////////////////////////////////

    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.languageWillChange(_:)), name: Notification.Name("LANGUAGE_WILL_CHANGE"), object: nil)
        let targetLang = UserDefaults.standard.object(forKey: "selectedLanguage") as? String
        Bundle.setLanguage( (targetLang != nil) ? targetLang : Locale.preferredLanguages[0].substring(to: Locale.preferredLanguages[0].characters.index(Locale.preferredLanguages[0].startIndex, offsetBy: 2) ))
    }
    
    //MARK: - Function
    //////////////////////////////////////////////////////////////////////////
    
    @objc func languageWillChange(_ notification:Notification){
        if let targetLang = notification.object as? String {
            UserDefaults.standard.set(targetLang, forKey: "selectedLanguage")
            Bundle.setLanguage(targetLang)
            NotificationCenter.default.post(name: Notification.Name("LANGUAGE_DID_CHANGE"), object: targetLang)
        }
    }
    
    //MARK: - Language
    var currentLanguage : String {
        return Bundle.getCurrentLanguage()
    }
    
    
}
