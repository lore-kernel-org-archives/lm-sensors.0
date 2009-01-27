From: Vincent Danjean <vdanjean.ml@free.fr>
Date: Tue, 27 Jan 2009 11:48:55 +0000
Subject: Re: [lm-sensors] VRM 11.0 needed for it8718 chip
Message-Id: <497EF4A7.8000806@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <495FD5F5.70103@free.fr>
In-Reply-To: <495FD5F5.70103@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Salut Vincent,
> 
> Désolé pour cette réponse un peu tardive.

Pas de problème !

  I just quickly tell you the requested info.
I will fill the wiki with my config later.

> On Sat, 03 Jan 2009 22:17:41 +0100, Vincent Danjean wrote:
>>   Hi,
>>
>>   I'm trying to use lm-sensors with a Gigabyte EG45M-DS2H motherboard
>> and a Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz (from /proc/cpuinfo)
>>   sensor-detect asks me to load it87 and coretemp modules
>>
>>   I'm using Debian lenny versions of lm-sensors: 1:3.0.2-1+b2
>> (ie 3.0.2 upstream)
>>
>>   My chips is a it8718F. When loading my modules, I get:
>> [   15.646427] it87: Found IT8718F chip at 0x290, revision 5
>> [   15.646427] it87: in3 is VCC (+5V)
>> [   15.654427] coretemp coretemp.0: Using relative temperature scale!
>> [   15.654427] coretemp coretemp.1: Using relative temperature scale!
>> [   15.654427] coretemp coretemp.2: Using relative temperature scale!
>> [   15.654427] coretemp coretemp.3: Using relative temperature scale!
>>
>>   The default configuration file did have have anything for a it8718.
>> I wrote a section based on the one found here:
>> http://www.lm-sensors.org/wiki/Configurations/Gigabyte/G33-DS3R
>> I had to change low/over to min/max and to comment out "set sensor3 0"
>>
>> I also add a problem with in0_(min|max): vid was not valid and cpu0_vid
>> was always 0. At first, I put a explicit value here. Then, I read
>> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/vid
>> (pointed by your FAQ)
>> It tells:
>> 109     The following chip drivers support only VRM 8.2 and cannot be changed:
>> 110 	
>> 111 	        adm1024, it87, mtp008, adm9240, gl520sm, lm78
>> 112 	
>> 113 	If you have a board with one of these chips which needs advanced
>> 114 	VRM support please email us.
> 
> You are quoting an old version of this document, which only applies to
> the Linux 2.4 drivers. In Linux 2.6, all the drivers pick the right VRM
> value based on the CPU model. Some drivers let the user change the
> value after that, some don't (the it87 driver does.)
> 
>> So, I'm emailing you. Indeed, my /sys/class/hwmon/hwmon0/device/vrm had
>> by default a value of 110. The intel website has a document for VRM 11.0.
> 
> We already have support for VRM 11.0 (since kernel 2.6.18.)
> 
>> If I put the value 100 in /sys/class/hwmon/hwmon0/device/vrm, then
>> I got a non zero value for cpu0_vid (the value seems non absurd, ie
>> sensors reports 1.063V for cpu_vid0)
> 
> I seem to remember that VRM 11 has a VRM 10 compatibility mode. It
> didn't make much sense to me and we didn't implement that, but maybe
> that's what your system does. It would be interesting to see the raw VID
> code. Please provide the output of:
> 
> isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7

aya:/home/vdanjean# isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 7 using bank register 0x07.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 87 18 05 00 00 01 3b 3f 01 88 01 00 01 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
c0: 00 3b 3f 01 08 00 00 00 00 00 38 00 00 08 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7e
f0: 10 40 00 00 00 00 08 00 00 00 00 00 7f 00 00 00
aya:/home/vdanjean#

>> Note that "set vrm 100" in my it8718 section is refused by "sensors -s":
>> # sensors -s
>> Error: Line 1429: Unknown feature name
>> it8718-isa-0290: No such subfeature known
> 
> Since lm-sensors 3.0.0, libsensors no longer knows about VRM, because
> the kernel is supposed to handle it automatically.
> 
>>   If you need more information, please, ask me (but I'm not subscribed to
>> this ML, so CC me)
>>
>>
>>   Last remark: lm-sensors seems to work with my config but I'm not sure
>> that the CPU temp is correctly computed. I've:
>> NBr Temp:    +37.0°C  (low  = +10.0°C, high = +50.0°C)  sensor = transistor
>> CPU Temp:    +21.0°C  (low  = +10.0°C, high = +60.0°C)  sensor = thermal diode
>> and then
>> Core 0:      +31.0°C  (high = +82.0°C, crit = +100.0°C)
>> Core 1:      +32.0°C  (high = +82.0°C, crit = +100.0°C)
>> Core 2:      +28.0°C  (high = +82.0°C, crit = +100.0°C)
>> Core 3:      +31.0°C  (high = +82.0°C, crit = +100.0°C)
> 
> The values returned by the coretemp driver seem reasonable. The CPU
> temperature value returned by the on-board sensor chip is suspiciously
> low, probably it needs an offset of some sort.
> 
> If you have come up with a configuration file which works for your
> board, please contribute it and we'll add it to the wiki.
> 


-- 
Vincent Danjean                 Adresse: Laboratoire d'Informatique de Grenoble
Téléphone:  +33 4 76 61 20 11            ENSIMAG - antenne de Montbonnot
Fax:        +33 4 76 61 20 99            ZIRST 51, avenue Jean Kuntzmann
Email: Vincent.Danjean@imag.fr           38330 Montbonnot Saint Martin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
