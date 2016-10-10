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

import Darwin
import AVFoundation

let sampleRate = 44100
let seconds = 5

// freq in hz
let freq = 440.0  // A440

let totalSamples = sampleRate * seconds

let dac = AVFoundationDAC()

do {
    try dac.start()
    dac.play(sample: SineSampled(sampleRate: Double(sampleRate), baseFrequency: freq), duration: 1.0)
    dac.stop()
} catch {

}

