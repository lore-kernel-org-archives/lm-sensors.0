From: gene.heskett@verizon.net (Gene Heskett)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <200308030533.01615.gene.heskett@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday 03 August 2003 04:56, Jean Delvare wrote:
>> I see.  I think.  So to build against the kernel being built, I
>> would make this line read
>> LINUX :=/usr/src/linux
>> since this link will be valid for the kernel being built.
>
>You got it.
>
>> Then I ran sensors-detect,  Everything worked except it detected
>> an lm75 instead of an adm1021 for the temp stuffs.  As I already
>> had an old line to bring it in with an option adm1021 line in
>> modules.conf so it would ignore one potential address, canceling
>> the lm75 and re-enabling the adm1021 modload in rc.local made
>> everything work again.
>
>I guess your ADM1021 is in fact a MAX1617, which is hard to detect,
> as the LM75 is. However, we have been improving detection for the
> lm75 and the adm1021 families, so I'd expect that thing will be
> better with lm_sensors-2.8.0. BTW, I'm a bit astonished that a
> non-LM75 chip could ever be detected as a LM75 with the detection
> procedure we use. What is possible is that you have both an LM75
> and an adm1021-like chipset. Most motherboards that use a LM75 use
> it as a secondary chip, and have another chip as their primari
> monitoring chip.

I think I've seen a reference to that MAX1617, but no idea where now.
The lm75 output was of course 0C.
[root@coyote root]# lsmod.old
WARNING: lsmod.old: I am not the old version!
Module                  Size  Used by
qcamvc_usb              4252  0 (autoclean) (unused)
qcamvc                 13528  0 [qcamvc_usb]
videodev                6208  1 (autoclean) [qcamvc]
nvidia               1624576  11 (autoclean)
via8233                 8800  2
pnp                    49620  2 [via8233]
ac97                   16384  2 [via8233]
soundbase             567520  2 [via8233 pnp ac97]
sndshield              10636  0 [via8233 pnp ac97 soundbase]
eeprom                  3508  0
adm1021                 5624  0 (unused)
i2c-viapro              3760  0 (unused)
w83781d                19312  0
i2c-proc                6992  0 [eeprom adm1021 w83781d]
i2c-isa                 1096  0 (unused)
i2c-core               14472  0 [eeprom adm1021 i2c-viapro w83781d 
i2c-proc i2c-isa]

>Anyway, please let us know how it goes with 2.8.0.
>
>> But, I think I've got some hardware problems, and suspect they are
>> only going to be cured by replacing my athlon cpu with a barton
>> cored unit, this DX-1600 has been running at 170F or more, .100
>> volts low on its core vcc for going on 3 years now, and several of
>> my reboots hung either at the post stage just before the memory
>> scan, and once it spontainously rebooted when the viapro module
>> was modprobed.  Gawd I hate flaky hardware...  I have a friend
>> with a barton cored athlon DX-2400 that rarely exceeds 120F, and
>> then only when doing mpeg2 smunching.
>
>170F is a bit hot for sure, you must have some serious heatsink/fan
>issue. No wonder your system may be a bit unstable. And you really
> need lm_sensors working on such a system ;)

And thats with thermaltake's best all copper big fan cooler on it.  
Sensors currently says:
[root@coyote root]# sensors
w83697hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.66 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +3.26 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +4.99 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.39 V  (min = +10.79 V, max = +13.11 V)
-12V:     -12.39 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.36 V  (min =  -5.51 V, max =  -4.51 V)
V5SB:      +5.44 V  (min =  +4.50 V, max =  +5.48 V)
VBat:      +3.21 V  (min =  +2.70 V, max =  +3.29 V)
fan1:     5273 RPM  (min =  187 RPM, div = 32)
fan2:        0 RPM  (min =  187 RPM, div = 32)
temp1:       +69?C  (limit =  +60?C)                       sensor = 
thermistor   ALARM
temp2:    +208.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 
thermistor
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-1-50
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       256

eeprom-i2c-1-51
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       256
---
There is no temp2 thermistor on this board.

and
---
[root@coyote root]# lsmod.old
WARNING: lsmod.old: I am not the old version!
Module                  Size  Used by
qcamvc_usb              4252  0 (autoclean) (unused)
qcamvc                 13528  0 [qcamvc_usb]
videodev                6208  1 (autoclean) [qcamvc]
nvidia               1624576  11 (autoclean)
via8233                 8800  2
pnp                    49620  2 [via8233]
ac97                   16384  2 [via8233]
soundbase             567520  2 [via8233 pnp ac97]
sndshield              10636  0 [via8233 pnp ac97 soundbase]
eeprom                  3508  0
adm1021                 5624  0 (unused)
i2c-viapro              3760  0 (unused)
w83781d                19312  0
i2c-proc                6992  0 [eeprom adm1021 w83781d]
i2c-isa                 1096  0 (unused)
i2c-core               14472  0 [eeprom adm1021 i2c-viapro w83781d 
i2c-proc i2c-isa]
---

And I thought I had that warning bs fixed :(


>
>Good luck with your hardware.

-- 
Cheers Jean, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
