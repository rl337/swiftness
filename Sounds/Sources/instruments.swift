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

protocol AudioSampled {
    var sampleRate: Double { get }

    func value(atSample sample: Double) -> Double
} 

class Sampled: AudioSampled {
    var sampleRate: Double

    init(sampleRate rate: Double) {
        self.sampleRate = rate
    }

    func value(atSample sample: Double) -> Double {
        preconditionFailure("This method must be overridden")
    }

}

class RadiansSampled: Sampled {

    override func value(atSample sample: Double) -> Double {
        // Convert sample parameter into time (seconds)
        let timeDomain = sample.truncatingRemainder(dividingBy: sampleRate) / sampleRate

        // Convert time into radians
        let functionDomain = 2 * Double.pi * timeDomain

        return valueAtRadian(atRadian: functionDomain)
    }

    func valueAtRadian(atRadian radian: Double) -> Double {
        preconditionFailure("This method must be overridden")
    }

}

class SineSampled: RadiansSampled {
    var frequency: Double

    init(sampleRate rate: Double, baseFrequency frequency: Double) {
        self.frequency = frequency
        super.init(sampleRate: rate)
    }

    override func valueAtRadian(atRadian radian: Double) -> Double {
        return sin(self.frequency * radian)
    }

}
