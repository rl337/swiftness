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

class Instrument<W: Waveform> {
    var waveforms: [W?]
    var dac: AVFoundationDAC
    
    init(dac: AVFoundationDAC, samplerate: Double) {
        self.waveforms = Array<W?>(repeating: nil, count: SoundsMath.notesOnKeyboard)
        for key in 1 ... SoundsMath.notesOnKeyboard {
            let frequency = SoundsMath.noteToFrequency(forNote: key)
            self.waveforms[key-1] = W(sampleRate: samplerate, frequency: frequency, amplitude: 0.8);
        }
        self.dac = dac
    }
    
    func play(note: Int, duration: Double) {
        if note < 1 || note >= SoundsMath.notesOnKeyboard {
            return
        }
        
        if let waveform = self.waveforms[note-1] {
            dac.play(sample: waveform, duration: duration)
        }
    }
    
}
