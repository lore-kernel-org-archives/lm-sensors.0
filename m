From: Lambert Carsten <reply01@lhcarsten.org>
Date: Tue, 15 May 2007 08:19:59 +0000
Subject: Re: [lm-sensors] hwmon/w83627ehf
Message-Id: <200705151020.00008.reply01@lhcarsten.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
In-Reply-To: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Actually I think it is working with the latest lm_sensors (2.10.3). I didn't 
configure anything except uncommenting 'ignore in9' in /etc/sensors.conf as 
advised by the emerge script (gentoo) for the W83627DHG chip. Here is the 
output of sensors after installing and running the init script:

sensors
w83627dhg-isa-0a00
Adapter: ISA adapter
VCore:     +1.26 V  (min =  +0.00 V, max =  +1.74 V)
in1:      +12.30 V  (min =  +1.37 V, max =  +7.55 V) ALARM
AVCC:      +3.26 V  (min =  +1.06 V, max =  +2.18 V) ALARM
3VCC:      +3.26 V  (min =  +1.71 V, max =  +3.74 V)
in4:       +1.58 V  (min =  +1.11 V, max =  +1.04 V) ALARM
in5:       +1.66 V  (min =  +1.52 V, max =  +0.09 V) ALARM
in6:       +4.94 V  (min =  +5.43 V, max =  +1.31 V) ALARM
VSB:       +3.26 V  (min =  +2.58 V, max =  +2.21 V) ALARM
VBAT:      +3.17 V  (min =  +2.22 V, max =  +3.90 V)
Case Fan:    0 RPM  (min =    0 RPM, div = 64) ALARM
CPU Fan:   683 RPM  (min =  664 RPM, div = 8)
Aux Fan:     0 RPM  (min = 1757 RPM, div = 64) ALARM
fan4:        0 RPM  (min = 56250 RPM, div = 8) ALARM
fan5:        0 RPM  (min = 9375 RPM, div = 8) ALARM
Sys Temp:    +45 C  (high =  +115 C, hyst =   +27 C)
CPU Temp:  +24.5 C  (high = +80.0 C, hyst = +75.0 C)
AUX Temp: +121.5 C  (high = +80.0 C, hyst = +75.0 C)   ALARM

The CPU Temp reading seems low but I put the machine to work and the temp went 
up as expected and seems right. The CPU Fan reading I think is corrct too. 
The bios is configured to speed up the fan when the CPU reaches 50 C.
 
Here follows the isadumps you requested in case they are still usefull. It's 
all 'middle clicked' this time so no typo.

isadump -y 0x0A05 0xA05
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f
80: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
90: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
a0: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
b0: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
c0: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
d0: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
e0: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
f0: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f

isadump -y -k 0x87,0x87 0x4e 0x4f 0xb 0x7
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 0b ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: a0 23 ff 00 44 00 40 ff 50 00 00 00 03 21 00 ff
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 0a 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: 81 ff 80 ff 00 01 00 00 ff ff ff ff ff ff ff ff

Here is the 'header' of lm_sensors-2.10.3 and relevant(?) output of the 
sensors-detect script:
# sensors-detect revision 4348 (2007-03-18 02:45:21 -0700)
...
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627DHG Super IO Sensors'                  Success!
    (address 0xa00, driver `w83627ehf')
...

Here is the dmesg output after running /etc/init.d/lm_sensors (gentoo):
...
i2c_adapter i2c-2: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-3: SMBus Quick command not supported, can't probe for chips
w83627ehf: unsupported chip ID: 0xffff

Thanks for the good work,

Lambert


On Monday 14 May 2007 21:54, you wrote:
> Hi Lambert,
>
> Please CC the list too.
>
> Lambert Carsten wrote:
> > Client found at address 0x2f
> > Probing for `National Semiconductor LM78'...                No
> > Probing for `National Semiconductor LM78-J'...              No
> > Probing for `National Semiconductor LM79'...                No
> > Probing for `National Semiconductor LM80'...                No
> > Probing for `Analog Devices ADT7470'...                     No
> > Probing for `Winbond W83781D'...                            No
> > Probing for `Winbond W83782D'...                            No
> > Probing for `Winbond W83792D'...                            No
> > Probing for `Winbond W83793R/G'...                          No
> > Probing for `Winbond W83791SD'...                           No
> > Probing for `Winbond W83627HF'...                           No
> > Probing for `Winbond W83627EHF'...                          No
> > Probing for `Winbond W83627DHG'...                          No
> > Probing for `Asus AS99127F (rev.1)'...                      No
> > Probing for `Asus AS99127F (rev.2)'...                      No
> > Probing for `Asus ASB100 Bach'...                           No
> > Probing for `Analog Devices ADM9240'...                     No
> > Probing for `Dallas Semiconductor DS1780'...                No
> > Probing for `National Semiconductor LM81'...                No
> > Probing for `Analog Devices ADM1029'...                     No
> > Probing for `ITE IT8712F'...                                No
> > Probing for `Fintek custom power control IC'...             No
> > Probing for `Winbond W83791D'...                            No
> > Client found at address 0x30
> > Client found at address 0x32
> > Client found at address 0x44
> > Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> > Client found at address 0x50
> > Handled by driver `eeprom' (already loaded), chip type `eeprom'
> > Client found at address 0x52
> > Handled by driver `eeprom' (already loaded), chip type `eeprom'
> > Client found at address 0x69
> > Client found at address 0x6a
> >
> > Found `Winbond W83627DHG Super IO Sensors'                  Success!
> >     (address 0xa00, driver `w83627ehf')
> >
> > Now follows a summary of the probes I have just done.
> > Just press ENTER to continue:
> >
> > Driver `eeprom' (should be inserted):
> >   Detects correctly:
> >   * Bus `SMBus I801 adapter at 0400'
> >     Busdriver `i2c-i801', I2C address 0x50
> >     Chip `eeprom' (confidence: 6)
> >   * Bus `SMBus I801 adapter at 0400'
> >     Busdriver `i2c-i801', I2C address 0x52
> >     Chip `eeprom' (confidence: 6)
> >
> >   EEPROMs are *NOT* sensors! They are data storage chips commonly
> >   found on memory modules (SPD), in monitors (EDID), or in some
> >   laptops, for example.
> >
> > Driver `w83627ehf' (should be inserted):
> >   Detects correctly:
> >   * ISA bus address 0x0a00 (Busdriver `i2c-isa')
> >     Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
> > Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify other
> > file name?
> >   (yes/NO/s):
> >
> > ######################
> > isadump -y 0x0A05 0xA05
> > ######################
>
> So there is some chip I think you did:
> isadump -y 0x0A05 0xA06
>
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: 04 ff 04 60 14 00 37 10 01 50 01 50 3c 10 02 02
> > 10: 04 ff ff 00 00 01 01 3c 43 17 00 00 ff ff ff d7
> > 20: a5 e8 cc cc c5 cf c2 31 ff c2 ff da 00 04 10 10
> > 30: 12 ca 3b 02 a2 08 a8 21 90 13 0a 06 fe 00 01 ff
> > 40: 01 00 10 ff ff ff 07 e5 2d 00 00 84 18 95 00 a3
> > 50: ff ff 00 ff ff ff 80 80 c1 7f ff ff 19 a5 00 05
> > 60: 04 ff 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 80: 04 ff 04 60 14 00 37 10 01 50 01 50 3c 10 02 02
> > 90: 04 ff ff 00 00 01 01 3c 43 17 00 00 ff ff ff d7
> > a0: a5 e8 cc cc c5 cf c2 31 ff c2 ff da 00 04 10 10
> > b0: 12 ca 3b 02 a2 08 a8 21 90 13 0a 06 fe 00 01 ff
> > c0: 01 00 10 ff ff ff 07 e5 2d 00 00 84 18 95 00 a3
> > d0: ff ff 00 ff ff ff 80 80 c1 7f ff ff 19 a5 00 05
> > e0: 04 ff 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >
> > ######################
> > isadump -y -k 0x87,0x87 0x2e 0x2f 0xb 0x7
> > ######################
> >
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
> Maybe it lives on 0x4e/0x4f ? Could you please try the latest
> sensors-detect (check our devices page how to get it) and try with:
> isadump -y -k 0x87,0x87 0x4e 0x4f 0xb 0x7
>
> Thanks,
>
> Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
