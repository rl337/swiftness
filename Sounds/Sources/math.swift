/*
 Copyright 2016 Richard R Lee Jr
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */


import Foundation


/**
 This class contains mostly convenience static methods for performing math that isn't 
 built into the language or isn't immediately supplied by the class libraries.
 */
class SoundsMath {
    static let noteForA440 = 49
    static let notesOnKeyboard = 88
    static let hzA440 = 440.0
    static let sampleRateCDQuality = 44100.0

    static let doubleDeltaEpsilon = 1.0e-100
    
    static func noteToFrequency(forNote note: Int) -> Double {
        assert(note > 0 && note <= notesOnKeyboard, "Note \(note) must fall between the range of 1 and \(notesOnKeyboard) inclusive")
        let position = Double(note - noteForA440)
        let exponent = position / 12.0
        return pow(2.0, exponent) * hzA440
    }
    
    static func round(value: Double, toDecimalPlace digits: Int) -> Double {
        let scaling = value * pow(10.0, Double(digits))
        let scaled = value * scaling
        let rounded = Foundation.round(scaled)
        return rounded / scaling
    }
    
    static func areDoublesEqual(_ a: Double, _ b: Double, epsilon: Double) -> Bool {
        let delta = abs(a - b)
        if delta > epsilon {
            return false
        }
        return true
    }
    
    static func areDoublesEqual(_ a: Double, _ b: Double) -> Bool {
        return areDoublesEqual(a, b, epsilon: doubleDeltaEpsilon)
    }
    
}
