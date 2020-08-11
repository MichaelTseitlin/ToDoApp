//
//  String+Extension.swift
//  ToDoApp
//
//  Created by Michael Tseitlin on 07.08.2020.
//  Copyright © 2020 Michael Tseitlin. All rights reserved.
//

import Foundation

extension String {
    var percentEncoded: String {
        let allowedCharaceters = CharacterSet(charactersIn: "±§!@#$%^&*()_+=-[]{}';:\\/.,`~").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharaceters) else {
            fatalError()
        }
        return encodedString
    }
}
