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

class AVFoundationDAC {
    var audioEngine: AVAudioEngine
    var audioPlayer: AVAudioPlayerNode
    var audioFormat: AVAudioFormat

    init() {
        self.audioEngine = AVAudioEngine()
        self.audioPlayer = AVAudioPlayerNode()

        self.audioEngine.attach(audioPlayer)
        self.audioFormat = self.audioPlayer.outputFormat(forBus: 0)
        self.audioEngine.connect(audioPlayer, to: audioEngine.mainMixerNode, format: audioFormat)
    }

    func start() throws {
        try self.audioEngine.start()
    }

    func play(sample: AudioSampled, duration: Double) {
        let totalSamples = Int(Double(self.audioFormat.sampleRate) * duration)
        let buffer = AVAudioPCMBuffer(pcmFormat: audioPlayer.outputFormat(forBus:0), frameCapacity: AVAudioFrameCount(totalSamples))
        buffer.frameLength = UInt32(totalSamples)

        for sampleIndex in 0..<totalSamples {
            let channelCount = Int(audioEngine.mainMixerNode.outputFormat(forBus:0).channelCount) 
            if let floatChannelsData = buffer.floatChannelData {
                for channel in 0..<channelCount {
                    let floatChannelData = floatChannelsData[Int(channel)]
                    floatChannelData[sampleIndex] = Float(sample.value(atSample: Double(sampleIndex)))
                }
            } 
        }

        audioPlayer.play()
        audioPlayer.scheduleBuffer(buffer, at: nil, options: AVAudioPlayerNodeBufferOptions.interrupts, completionHandler: nil)
        sleep(UInt32(duration))
    } 

    func stop() {
        audioEngine.stop()
    }

}

