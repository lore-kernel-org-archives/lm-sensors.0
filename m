From: andrea.parenti3@tin.it (Andrea Parenti)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: What does this mean?
Message-Id: <3D627ED8.7080802@tin.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

.../lm_sensors-2.6.4/prog/detect/sensors-detect

gives this result:
...
Probing for `Winbond W83697HF'
   Trying address 0x0290... Success!
     (confidence 8, driver `Unwritten (W83697HF)')
...

Does it mean that "there is no driver for the chip "Winbond w83697hf"??
But i read that the driver w83781d should fit.

If I do:

modprobe w83781d

I got "No sensors found!"

This is my "lsmod":

inux:/home/andrea # lsmod
Module                  Size  Used by    Tainted: P
w83781d                16672   0  (unused)
i2c-proc                6016   0  [w83781d]
pppoe                   6752   1  (autoclean)
pppox                   1064   1  (autoclean) [pppoe]
af_packet              11528   1  (autoclean)
ppp_generic            14984   3  (autoclean) [pppoe pppox]
slhc                    4432   0  (autoclean) [ppp_generic]
snd-mixer-oss          11136   1  (autoclean)
agpgart                29664   3  (autoclean)
NVdriver              989760  10  (autoclean)
parport_pc             25448   1  (autoclean)
lp                      5824   0  (autoclean)
parport                21856   1  (autoclean) [parport_pc lp]
snd-seq-midi            4480   0  (autoclean) (unused)
snd-emu10k1-synth       5504   0  (autoclean)
snd-emux-synth         28480   0  (autoclean) [snd-emu10k1-synth]
snd-seq-midi-emul       4560   0  (autoclean) [snd-emux-synth]
snd-seq-virmidi         3720   0  (autoclean) [snd-emux-synth]
snd-seq-oss            24128   0  (autoclean)
snd-seq-midi-event      2664   0  (autoclean) [snd-seq-midi 
snd-seq-virmidi snd-seq-oss]
snd-seq                39596   2  (autoclean) [snd-seq-midi 
snd-emux-synth snd-seq-midi-emul snd-seq-virmidi snd-seq-oss 
snd-seq-midi-event]
snd-emu10k1            62820   1  [snd-emu10k1-synth]
snd-pcm                58528   0  [snd-emu10k1]
snd-timer              11456   0  [snd-seq snd-pcm]
snd-hwdep               4736   0  [snd-emu10k1]
snd-util-mem            1472   0  [snd-emux-synth snd-emu10k1]
snd-rawmidi            13536   0  [snd-seq-midi snd-seq-virmidi snd-emu10k1]
ipv6                  123424  -1  (autoclean)
snd-seq-device          4336   0  [snd-seq-midi snd-emu10k1-synth 
snd-emux-synth snd-seq-oss snd-seq snd-emu10k1 snd-rawmidi]
snd-ac97-codec         24196   0  [snd-emu10k1]
snd                    31720   0  [snd-mixer-oss snd-seq-midi 
snd-emu10k1-synth snd-emux-synth snd-seq-midi-emul snd-seq-virmidi 
snd-seq-oss snd-seq-midi-event snd-seq snd-emu10k1 snd-pcm snd-timer 
snd-hwdep snd-util-mem snd-rawmidi snd-seq-device snd-ac97-codec]
soundcore               3268   7  [snd]
isa-pnp                27816   0  (unused)
joydev                  5728   0  (unused)
evdev                   3904   0  (unused)
mousedev                3872   1
hid                    17824   0  (unused)
input                   3072   0  [joydev evdev mousedev hid]
st                     25844   0  (autoclean) (unused)
sg                     23620   0  (autoclean)
3c59x                  25032   1
ipt_REJECT              2752   1  (autoclean)
ipt_LOG                 3168   1  (autoclean)
iptable_nat            12756   0  (autoclean) (unused)
ip_conntrack           12652   1  (autoclean) [iptable_nat]
iptable_filter          1728   1  (autoclean)
ip_tables              10400   6  [ipt_REJECT ipt_LOG iptable_nat 
iptable_filter]
i2c-isa                 1220   0  (unused)
i2c-core               12320   0  [w83781d i2c-proc i2c-isa]
usb-uhci               20996   0  (unused)
usbcore                55136   1  [hid usb-uhci]
ide-scsi                7648   0
reiserfs              158816   1
linux:/home/andrea # sensors -s
No sensors found!


Any help appreciated!!
Motherboard: Epox 8KHA+
System: SuSE linux 8.0.





