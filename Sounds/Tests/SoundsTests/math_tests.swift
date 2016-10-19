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



import XCTest
@testable import Sounds

struct SoundMathNoteToFrequencyTestData {
    var name: String
    var note: Int
    var frequency: Double
}

struct SoundMathRoundTestData {
    var name: String
    var original: Double
    var rounded: Double
}

let testCasesForSoundMathNoteToFrequency: [SoundMathNoteToFrequencyTestData] = [
    SoundMathNoteToFrequencyTestData(name: "A0 (01)", note: 1, frequency: 27.5000),
    SoundMathNoteToFrequencyTestData(name: "A4 (49)", note: 49, frequency: 440.0),
    SoundMathNoteToFrequencyTestData(name: "B4 (51)", note: 51, frequency: 493.883),
    SoundMathNoteToFrequencyTestData(name: "C5 (52)", note: 52, frequency: 523.251),
    SoundMathNoteToFrequencyTestData(name: "D5 (54)", note: 54, frequency: 587.330),
    SoundMathNoteToFrequencyTestData(name: "E5 (56)", note: 56, frequency: 659.255),
    SoundMathNoteToFrequencyTestData(name: "F5 (57)", note: 57, frequency: 698.456),
    SoundMathNoteToFrequencyTestData(name: "G5 (59)", note: 59, frequency: 783.991),
    SoundMathNoteToFrequencyTestData(name: "A5 (61)", note: 61, frequency: 880.000),
    SoundMathNoteToFrequencyTestData(name: "C8 (88)", note: 88, frequency: 4186.01)
]

let testCasesForSoundMathRound: [SoundMathRoundTestData] = [
    SoundMathRoundTestData(name: "Rounding down to whole number", original: 3.4, rounded: 3.0),
    SoundMathRoundTestData(name: "Rounding up to whole number", original: 3.6, rounded: 4.0),
]

class SoundMathTests: XCTestCase {
    
    func testNoteToFrequency() {
        for testcase in testCasesForSoundMathNoteToFrequency {
            // In this test, we're only checking out to the 3rd decimal place
            let actual = Sounds.SoundsMath.noteToFrequency(forNote: testcase.note)
            let delta = abs(testcase.frequency - actual)
            XCTAssert(delta < 0.001, "Frequency for note \(testcase.name) was: \(actual) expected: \(testcase.frequency)")
        }
    }
    
    func testSoundMathRound() {
        for testcase in testCasesForSoundMathRound {
            // In this test, we're only checking out to the 3rd decimal place
            let actual = Sounds.SoundsMath.round(value: testcase.original, toDecimalPlace: 0)
            let delta = abs(testcase.rounded - actual)
            XCTAssert(delta < Sounds.SoundsMath.doubleDeltaEpsilon, "Frequency for note \(testcase.name) was: \(actual) expected: \(testcase.rounded)")
        }
    }
    
}
