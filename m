From: gene.heskett@verizon.net (Gene Heskett)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <200308031025.46083.gene.heskett@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday 03 August 2003 09:18, Jean Delvare wrote:
>> [root@coyote root]# lsmod.old
>> WARNING: lsmod.old: I am not the old version!
>> Module                  Size  Used by
>> qcamvc_usb              4252  0 (autoclean) (unused)
>> qcamvc                 13528  0 [qcamvc_usb]
>> videodev                6208  1 (autoclean) [qcamvc]
>> nvidia               1624576  11 (autoclean)
>> via8233                 8800  2
>> pnp                    49620  2 [via8233]
>> ac97                   16384  2 [via8233]
>> soundbase             567520  2 [via8233 pnp ac97]
>> sndshield              10636  0 [via8233 pnp ac97 soundbase]
>> eeprom                  3508  0
>> adm1021                 5624  0 (unused)
>> i2c-viapro              3760  0 (unused)
>> w83781d                19312  0
>> i2c-proc                6992  0 [eeprom adm1021 w83781d]
-------------------------------------------^^^^^^^
>> i2c-isa                 1096  0 (unused)
>> i2c-core               14472  0 [eeprom adm1021 i2c-viapro w83781d
>> i2c-proc i2c-isa]
>
>It seems that the adm1021 module isn't used, so you may not load it.

Humm, I wonder where I got that from originally?  rmmod'ing it speeds 
up the report, a lot!  I'll take that puppy out of rc.local and 
modules.conf forthwith.  Thanks for spotting that.

>> And thats with thermaltake's best all copper big fan cooler on it.
>> Sensors currently says:
>> [root@coyote root]# sensors
>> w83697hf-isa-0290
>> Adapter: ISA adapter
>> Algorithm: ISA algorithm
>> VCore:     +1.66 V  (min =  +0.00 V, max =  +0.00 V)
>
>You need to set valid limits in the config file for that
>(/etc/sensors.conf, section w83697hf-*).

Ah, I didn't know that.  The +1.66 is the -.100 in the current bios 
setting, and it did cool it down 5 or so degrees.  It should be 
running 1.75 volts. On inspection I find this:

    set in0_min 1.8 * 0.95
    set in0_max 1.8 * 1.05

I lowered the 1.8 to 1.75 in both lines but that didn't change the 
report.  Is that incorrectly formatted?

>> +3.3V:     +3.26 V  (min =  +2.97 V, max =  +3.63 V)
>> +5V:       +4.99 V  (min =  +4.50 V, max =  +5.48 V)
>> +12V:     +12.39 V  (min = +10.79 V, max = +13.11 V)
>> -12V:     -12.39 V  (min = -13.21 V, max = -10.90 V)
>> -5V:       -5.36 V  (min =  -5.51 V, max =  -4.51 V)
>> V5SB:      +5.44 V  (min =  +4.50 V, max =  +5.48 V)
>> VBat:      +3.21 V  (min =  +2.70 V, max =  +3.29 V)
>
>Voltages are correct, except V5SB which is a bit high.

Whats that feed?  Its not adjustable by any means that I know of, this 
is a Biostar M7VIB board. But I'm thinking about replacing it with an 
M7VIK.

>> fan1:     5273 RPM  (min =  187 RPM, div = 32)
>> fan2:        0 RPM  (min =  187 RPM, div = 32)
>
>Div 32 is very unusual, you'll probably have better precision using
>lower values (4 or 2 should be OK).
>
>> temp1:       +69?C  (limit =  +60?C)                       sensor
>> = thermistor   ALARM
>> temp2:    +208.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor >> thermistor
>
>Temp1 is damn too hot, you *do* have a cooling problem.

Its run that way, including in the little 3 second bios display during 
post, since day one.  And a finger laid on the bottom of the heat 
sink tends to confirm that its very hot.  The breeze off the heat 
sink is at least 120F by itself.

>> There is no temp2 thermistor on this board.
>
>I'd have guessed (your computer would be on fire).

:^)
-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
