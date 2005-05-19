From: Claus.Rosenberger@rocnet.de (Claus Rosenberger)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: sensors with K7S5A
Message-Id: <4014.10.20.10.15.1045656611.squirrel@deathstar.of.rocnet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <34986.10.20.2.100.1045593851.squirrel@deathstar.of.rocnet.de>
In-Reply-To: <34986.10.20.2.100.1045593851.squirrel@deathstar.of.rocnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ok. i changed something but without result. here are some infos :


**** lsmod
Module                  Size  Used by    Not tainted
i2c-isa                 1252   0  (unused)
it87                    6848   0  (unused)
i2c-dev                 4064   0  (unused)
loop                    8656   0  (autoclean)
i2c-proc                6624   0  [it87]
i2c-core               14944   0  [i2c-isa it87 i2c-dev i2c-proc]
nfsd                   68416   8  (autoclean)
lockd                  48832   1  (autoclean) [nfsd]
sunrpc                 60724   1  (autoclean) [nfsd lockd]

**** /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0290-0297 : it87
03c0-03df : vga+
0cf8-0cff : PCI conf1
d400-d47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  d400-d47f : 00:11.0
d800-d80f : 3ware Inc 3ware 7000-series ATA-RAID
  d800-d80f : 3ware Storage Controller
dc00-dcff : Adaptec AHA-2940U/UW/D / AIC-7881U
ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]


**** isadump 0x290 0x291
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
10: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
20: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
30: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
40: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
50: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
60: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
70: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
80: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
90: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
a0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
b0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
c0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
d0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
e0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
f0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11


**** dmesg
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
it87.o version 2.7.0 (20021208)
i2c-isa.o version 2.7.0 (20021208)
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)



**** sensors -v
sensors version 2.7.0


**** result of sensors
No sensors found!


Any ideas ?


> try loading i2c-isa.
> Don't load i2c-sis5595.
>
> Claus Rosenberger wrote:
>> Hi,
>>
>> i try to use lm_sensors with my K7S5A Mainboard.
>>
>> sensors-detect reports following result :
>>
>> Use driver `i2c-sis645' for device 00:00.0: Silicon Integrated Systems
>> SIS735 Use driver `i2c-sis5595' for device 00:02.0: Silicon Integrated
>> Systems SIS5595
>> Use driver `i2c-matroxfb' for device 01:00.0: MGA G200 AGP
>>
>> While loading this drivers i get failures because no devices deteced.
>>
>> In the mainboard list you linked too my mainbard has the SIS950
>> chipset which is in driver it87 included.
>>
>> Loading this drivers is ok but sensors reports "No sensors found!"
>>
>> What to do now ??
>>
>> Thanks,
>>    Claus
>>
>>


