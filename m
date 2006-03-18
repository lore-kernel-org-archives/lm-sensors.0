From: harald.dunkel@t-online.de (Harald Dunkel)
Date: Sat, 18 Mar 2006 05:14:47 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <441B9747.3020408@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <44144A01.2050207@t-online.de>
In-Reply-To: <44144A01.2050207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Sorry for the late response. See below.

Jean Delvare wrote:
> Hallo Harald,
> 
> 
> I don't see the version of lm_sensors in your second report, I'll
> assume 2.10.0.
> 

Yes, it is.

> I'm surprised that the thermal sensor types changed from "diode" to
> "thermistor". These settings are not supposed to change on their own.
> Did you change anything in your configuration file? It probably doesn't
> matter much here, as these inputs seem to be unused, but I'm curious.
> 

No, I did not change this file. Currently sensors replies "diode"
again.

> The output of sensors-detect is interesting:
> 
> 
>>Next adapter: SMBus I801 adapter at 5000
>>(...)
>>Client found at address 0x2d
> 
> (All Failed)
> 
>>Client found at address 0x2f
> 
> (All Failed)
> 
> These are typical addresses for hardware monitoring chips, so I start
> suspecting that one of these is your real fans + temperatures sensor
> chip, either a recent or rare type which we don't know about yet.
> 
> Please provide the output of the following commands (which will dump the
> contents of these chips for further analysis) as root:
> 
> modprobe i2c-dev
> i2cdump 0 0x2d b
> i2cdump 0 0x2f b
> 

No problem, see below. Please mail if more information is needed.


Many thanx in advance

Harri
=====================================
{root at bugs:harri 1001} modprobe i2c-dev
{root at bugs:harri 1001} i2cdump 0 0x2d b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2d, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 07 00 40 5a ff ff ff ff ff ff ff ff ff ff ff    ??. at Z...........
10: c5 72 7e 85 25 22 01 df 0f fe 00 00 1c 80 ad 07    ?r~?%"????..????
20: ff 00 ff 00 ff 00 ff 00 4b 4b 4b 4b 3c 37 00 ff    ........KKKK<7..
30: 00 b0 b0 00 00 00 30 ff ff ff ff ff ff ff ff ff    .??...0.........
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff 04 10 20 19 34 ff    ..........?? ?4.
60: bb 0a 90 00 01 00 00 0f ff 55 64 46 64 46 ff ff    ???.?..?.UdFdF..
70: 02 ab ff ff 00 00 ff ff ff ff ff ff ff ff ff ff    ??..............
80: 0f ff ff ff 00 00 ff ff ff ff ff ff ff ff ff ff    ?...............
90: 00 00 0d ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
a0: 46 3c 32 28 ff d9 b2 99 80 ff ff ff ff ff ff ff    F<2(.????.......
b0: 46 3c 32 28 ff d9 b2 99 80 ff ff ff ff ff ff ff    F<2(.????.......
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: 00 00 00 00 00 00 39 38 01 45 00 ff ff ff ff 27    ......98?E.....'
{root at bugs:harri 1002} i2cdump 0 0x2f b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2f, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff 03 07 f0 22 08 ff ff ff ff ff ff ff ff ff ff    .???"?..........
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff 03 02 12 19 34 ff    ..........????4.
60: ff ff ff ff ff ff ff ff ff ff a0 a0 ff ff ff ff    ..........??....
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: 00 80 ff ff ff ff ff ff ff ff ff ff ff ff ff 5e    .?.............^
{root at bugs:harri 1003} sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.37 V  (min =  +1.94 V, max =  +1.94 V)       ALARM
+12V:     +12.22 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.18 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.91 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -12.11 V  (min = -13.18 V, max = -10.80 V)
V5SB:      +5.05 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.09 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min =  664 RPM, div = 8)              ALARM
CPU Fan:     0 RPM  (min =  664 RPM, div = 8)              ALARM
fan3:        0 RPM  (min =  664 RPM, div = 8)              ALARM
M/B Temp:     +6 C  (high =   -87 C, hyst =  +125 C)   sensor = diode
CPU Temp:   -7.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
temp3:      +7.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode           (beep)
alarms:
beep_enable:
          Sound alarm enabled

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 258 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060318/05a8f955/signature.bin
