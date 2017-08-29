//
//  Car.swift
//  CarsForSale
//
//  Created by Nishant Aggarwal on 8/29/17.
//  Copyright © 2017 Nishant Aggarwal. All rights reserved.
//

import Foundation

class Car: NSObject, NSCoding {
    
    struct Keys {
        static let Make = "make";
        static let Model = "model";
        static let Price = "price";
    }
    
    private var _make = "";
    private var _model = "";
    private var _price = "";
    
    init(make: String, model: String, price: String) {
        self._make = make;
        self._model = model;
        self._price = price;
    }
    
    required init(coder decoder: NSCoder) {
        if let makeObj = decoder.decodeObject(forKey: Keys.Make) as? String {
            _make = makeObj;
        }
        if let modelObj = decoder.decodeObject(forKey: Keys.Model) as? String {
            _model = modelObj;
        }
        if let priceObj = decoder.decodeObject(forKey: Keys.Price) as? String {
            _price = priceObj;
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(_make, forKey: Keys.Make);
        coder.encode(_model, forKey: Keys.Model);
        coder.encode(_price, forKey: Keys.Price);
    }
    
    var Make: String {
        get {
            return _make;
        }
        set {
            _make = newValue;
        }
    }
    
    var Model: String {
        get {
            return _model;
        }
        set {
            _model = newValue;
        }
    }
    
    var Price: String {
        get {
            return _price;
        }
        set {
            _price = newValue;
        }
    }
    
}
