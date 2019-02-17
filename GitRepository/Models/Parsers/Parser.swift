//
//  Parser.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 12/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation

/**
 * The ParserProtocol defines an interface to convert a raw dictionary into a model
 */
protocol ParserProtocol {
    /**
     * Converts raw data into a model
     */
    func parse(rawData: [String : AnyObject]) -> Any?
}
