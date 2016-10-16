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

protocol Sampled {
    var sampleRate: Double { get }
    
    func value(atSample sample: Double) -> Double
}

protocol Cyclic {
    var frequency: Double { get }
    
}

protocol Volume {
    var amplitude: Double { get }
    
}

class Waveform: Cyclic, Sampled, Volume {
    var sampleRate: Double
    var frequency: Double
    var amplitude: Double
    
    required init(sampleRate rate: Double, frequency: Double, amplitude: Double) {
        self.sampleRate = rate
        self.frequency = frequency
        self.amplitude = amplitude
    }
    
    func value(atSample sample: Double) -> Double {
        return self.amplitude * self.waveform(atDomainValue: sample * frequency)
    }
    
    func waveform(atDomainValue domain: Double) -> Double {
        preconditionFailure("This method must be overridden")
    }
    
}

class RadiansWaveform: Waveform {
    
    override func value(atSample sample: Double) -> Double {
        // Convert sample parameter into time (seconds)
        let timeDomain = sample.truncatingRemainder(dividingBy: sampleRate) / sampleRate
        
        // Convert time into radians scaled by frequency
        let radianDomain = self.frequency * 2 * Double.pi * timeDomain
        
        return valueAtRadian(atRadian: radianDomain)
    }
    
    func valueAtRadian(atRadian radian: Double) -> Double {
        preconditionFailure("This method must be overridden")
    }
    
}


class SineSampled: RadiansWaveform {

    override func valueAtRadian(atRadian radian: Double) -> Double {
        return sin(radian)
    }
    
}

class SquareSampled: RadiansWaveform {
    
    override func valueAtRadian(atRadian radian: Double) -> Double {
        
        var normalizedRadian = radian
        while normalizedRadian < 0 {
            normalizedRadian = normalizedRadian + 2 * Double.pi
        }
        
        normalizedRadian = normalizedRadian.truncatingRemainder(dividingBy: 2.0 * Double.pi)

        if normalizedRadian >= 0 && normalizedRadian < Double.pi {
            return 1.0
        }
        return -1.0
    }
    
}

class SawtoothSampled: RadiansWaveform {
    
    override func valueAtRadian(atRadian radian: Double) -> Double {
        let twoPi = 2 * Double.pi
        var normalizedRadian = radian
        while normalizedRadian < 0 {
            normalizedRadian = normalizedRadian + twoPi
        }
        
        normalizedRadian = normalizedRadian.truncatingRemainder(dividingBy: twoPi)
        
        return 2.0 * ( normalizedRadian / twoPi) - 1.0
    }
    
}



