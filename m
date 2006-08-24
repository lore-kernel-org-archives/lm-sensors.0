From: prakash@punnoor.de (Prakash Punnoor)
Date: Thu, 24 Aug 2006 15:33:08 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <200608241733.08609.prakash@punnoor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Donnerstag 24 August 2006 17:09 schrieb Jean Delvare:
> You have a recent ITE Super-I/O, IT8716F, which isn't supported yet.
> But you are lucky, I have been working on this in the last two weeks.
> You can get a kernel patch here:
> http://jdelvare.pck.nerim.net/sensors/hwmon-it8716f-it8718f-v2-2.6.18.patch
>
> And user-space support is available in the latest SVN snapshot of
> lm_sensors:
> http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4108-20060824.tar
>.bz2
>
> Please report your results!

Hi, thx for your prompt reply. Yes I have partial success! :-)

Issues:

1) sensor-detect tells me to inster k8temp, but I can't find it in kernel 
tree.

2) Some values are probably wrong:
it8716-isa-0290
Adapter: ISA adapter
VCore:     +1.04 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
VDDR:      +3.12 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
+3.3V:     +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
+5V:       +4.84 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
+12V:     +11.46 V  (min = +16.32 V, max = +16.32 V)   ALARM
in5:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
in6:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
5VSB:      +4.70 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
VBat:      +2.86 V
fan1:     1363 RPM  (min = 6490 RPM)                   ALARM
fan2:        0 RPM  (min = 6490 RPM)                   ALARM
fan3:     1566 RPM  (min =    0 RPM)
temp1:       +26?C  (low  =    -1?C, high =    -1?C)   sensor = diode
temp2:       +38?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
temp3:       +25?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
vid:       +0.00 V


I am missing my 3.3V readings ;-) I am also pretty sure that VCore is wrong:

I set them to:
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x11
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x13
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x1b

If I am not mistaken, vid 0x11 is 1.2V and 0x1b is 0.9V. (Does anybody know 
how to calc from hex to vcore?) But sensors shows me 1.04 at 2GHz and 0.8 at 
1GHz. Or do you think the mainboard's volt regulator is that much off?

I have to check fan speed with what the bios reports, but it looks sensible.

Anyways, I am happy that I can finally read out some data. :-))

(Please still cc to me, as I am not subscribed.)

Many thx and cheers,
-- 
(?=                 =?)
//\ Prakash Punnoor /\\
V_/                 \_V
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060824/82bc2d05/attachment.bin 
