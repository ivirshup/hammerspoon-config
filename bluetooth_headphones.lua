-- This file makes it so when my bluetooth headphones connect, they default to 
-- using the built in mic, and have balanced output

function bluetooth_headphones_callback(arg)
    bose_in = hs.audiodevice.findInputByName("Bose NC 700 HP")
    if bose_in then
        if hs.audiodevice.defaultInputDevice() == bose_in then
            builtin = hs.audiodevice.findDeviceByName("MacBook Pro Microphone")
            builtin:setDefaultInputDevice()
        end
    end
    bose_out = hs.audiodevice.findOutputByName("Bose NC 700 HP")
    bose_out:setBalance(0.5)
end

function register_audio_callback()
    if hs.audiodevice.watcher.isRunning() then
        hs.audiodevice.watcher.stop()
    end
    hs.audiodevice.watcher.setCallback(bluetooth_headphones_callback)
    hs.audiodevice.watcher.start()
end

register_audio_callback()