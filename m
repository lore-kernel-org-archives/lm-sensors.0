From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: RFC testing automatic fan clock divider - results
Message-Id: <1eem519h5an7mbvhid4gpfvusi08jvuv54@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

Exploring new automatic fan clock divider for adm9240, strange things 
appear to happen, so I rather heavily instrumented the code and attach 
an annoted log.  I've nailed the strange behaviour and can explain it.

I may have missed something though, comments appreciated  :o)

test script tries setting fan_min in range 400..20000 up, down, repeat.

http://scatter.mine.nu/lmsensors/adm9240/xz-test-fan-div if you want to know :)

/var/log/debug

Apr 12 12:56:05 peetoo kernel: adm9240 0-002d: adm9240 running, config is 0x01

too slow, set fan_min to 255, no touch divider as measurement calibrator enabled

Apr 12 12:56:09 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 140, val 400, spd 83
Apr 12 12:56:09 peetoo kernel: adm9240 0-002d: auto2: fan 1, div 4, min 255, final
Apr 12 12:56:11 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 255, val 500, spd 82
Apr 12 12:56:11 peetoo kernel: adm9240 0-002d: auto2: fan 1, div 4, min 255, final
Apr 12 12:56:13 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 255, val 600, spd 82
Apr 12 12:56:13 peetoo kernel: adm9240 0-002d: auto2: fan 1, div 4, min 255, final
Apr 12 12:56:15 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 255, val 700, spd 82

measurement calibrator disabled as we within operating range, switch to /8

Apr 12 12:56:15 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 8, min 241
Apr 12 12:56:15 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 8, min 241, final
Apr 12 12:56:15 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 4, new 8, div changed
Apr 12 12:56:17 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 241, val 800, spd 41
Apr 12 12:56:17 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 8, min 210
Apr 12 12:56:17 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 8, min 210, final
Apr 12 12:56:19 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 210, val 1000, spd 41

internal min_fan overrange, step back one divider value

Apr 12 12:56:19 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 4, min 336
Apr 12 12:56:19 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 8, min 168, final
Apr 12 12:56:21 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 168, val 1200, spd 42
Apr 12 12:56:21 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 4, min 280
Apr 12 12:56:21 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 8, min 140, final
Apr 12 12:56:23 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 140, val 1400, spd 41
Apr 12 12:56:23 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 4, min 240
Apr 12 12:56:23 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 8, min 120, final
Apr 12 12:56:25 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 120, val 1700, spd 41
Apr 12 12:56:25 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 4, min 198
Apr 12 12:56:25 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 8, min 99, final
Apr 12 12:56:27 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 99, val 2000, spd 41
Apr 12 12:56:27 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 2, min 336
Apr 12 12:56:27 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 4, min 168, final

change divider again to accommodate fan_min

Apr 12 12:56:27 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 8, new 4, div changed
Apr 12 12:56:29 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 168, val 2400, spd 82
Apr 12 12:56:29 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 2, min 280
Apr 12 12:56:29 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 4, min 140, final
Apr 12 12:56:32 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 140, val 2900, spd 82
Apr 12 12:56:32 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 2, min 232
Apr 12 12:56:32 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 4, min 116, final
Apr 12 12:56:34 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 116, val 3500, spd 83
Apr 12 12:56:34 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 2, min 192
Apr 12 12:56:34 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 4, min 96, final
Apr 12 12:56:36 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 96, val 4200, spd 82
Apr 12 12:56:36 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 320
Apr 12 12:56:36 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 2, min 160, final
Apr 12 12:56:36 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 4, new 2, div changed
Apr 12 12:56:38 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 160, val 5000, spd 164
Apr 12 12:56:38 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 264
Apr 12 12:56:38 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 2, min 132, final
Apr 12 12:56:40 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 132, val 6000, spd 165
Apr 12 12:56:40 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 224
Apr 12 12:56:40 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 2, min 112, final
Apr 12 12:56:42 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 112, val 7200, spd 164
Apr 12 12:56:42 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 184
Apr 12 12:56:42 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 1, min 184, final
Apr 12 12:56:42 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 2, new 1, div changed

at this point we lose fan speed reading as fan_min forces divider, this is 
correct operation as the fan is running slower than the valid fan_min

Apr 12 12:56:44 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 184, val 8600, spd 255
Apr 12 12:56:44 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 152
Apr 12 12:56:44 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 1, min 152, final
Apr 12 12:56:46 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 152, val 10300, spd 255
Apr 12 12:56:46 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 128
Apr 12 12:56:46 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 1, min 128, final
Apr 12 12:56:48 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 128, val 12400, spd 255
Apr 12 12:56:48 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 104
Apr 12 12:56:48 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 1, min 104, final
Apr 12 12:56:50 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 104, val 14900, spd 255

this is new territory, user-space has asked for too high a fan_min...

Apr 12 12:56:50 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0, final

..which enables fan measurement to adjust fan, note though fan_min is displayed 
as 99999 and fan_alarm is still asserted, so logically the driver is maintaining 
alarm state, it ran out of 'headroom' for measurement of fan speed.

Apr 12 12:56:52 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 1, new 2, div changed
Apr 12 12:56:52 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 0, val 17900, spd 255
Apr 12 12:56:52 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 2, min 0, final
Apr 12 12:56:54 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 0, val 20000, spd 164
Apr 12 12:56:54 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 2, min 0, final
Apr 12 12:56:56 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 0, val 16700, spd 165
Apr 12 12:56:56 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 2, min 0, final
Apr 12 12:56:58 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 0, val 13900, spd 165
Apr 12 12:56:58 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 96
Apr 12 12:56:58 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 1, min 96, final
Apr 12 12:56:58 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 2, new 1, div changed

back to valid fan_min, although fan speed is still too slow to measure

Apr 12 12:57:00 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 96, val 11600, spd 255
Apr 12 12:57:00 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 112
Apr 12 12:57:00 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 1, min 112, final
Apr 12 12:57:02 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 112, val 9700, spd 255
Apr 12 12:57:02 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 136
Apr 12 12:57:02 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 1, min 136, final
Apr 12 12:57:05 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 136, val 8100, spd 255
Apr 12 12:57:05 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 160
Apr 12 12:57:05 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 1, min 160, final
Apr 12 12:57:07 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 160, val 6800, spd 255
Apr 12 12:57:07 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 192
Apr 12 12:57:07 peetoo kernel: adm9240 0-002d: auto5: fan 1, div 2, min 96, final
Apr 12 12:57:07 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 1, new 2, div changed

back to 'normal' operation, valid fan_min and can display fan speed

o o o

Queries, comments appreciated.  I'm testing on 2.6.11.7, will soon post 
patch against 2.6.12-rc2-mm3 if no more issues raise their heads, I'll 
leave the instrumentation in for now as this area needs thorough testing.

Cheers,
Grant.
