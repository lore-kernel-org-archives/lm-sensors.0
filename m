From: Harry G McGavran Jr <w5pny@arrl.net>
Date: Thu, 14 Apr 2011 15:19:29 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110414151929.C79821A9866@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Apr 2011 09:57:23 +0200 Jean Delvare wrote:
> 
> Will be difficult to find a developer motivated to write a driver for 2
> users of 2006 hardware, I'm afraid. Do you have anything to offer in
> return? I have a wishlist:
>   http://khali.linux-fr.org/wishlist.html

I looked at your wishlist, and at the moment, I've only got
one or two short RJ45 cables and possiblye and HDMI cable,
but I'd have to check if its male/male.  Might be able to
come up with more from your list at a later time.

> 
> Meanwhile I've added detection support to sensors-detect:
>   http://khali.linux-fr.org/devel/misc/sensors-detect
> If you could test and report, that would be great. Proper detection of
> the chip may bring more user requests to support the chip (although the
> old age of the chip makes this event rather unlikely.)

 # sensors-detect revision 5960 (2011-04-14 09:20:09 +0200)
 # System: Dell Inc. Precision WorkStation 670
 # Board: Dell Inc. 0XC837

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): 
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     Yes
Found `SMSC EMC2700LPC Super IO'                            
    (no information available)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no): 
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): 
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): 
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801EB ICH5

Next adapter: NVIDIA i2c adapter  (i2c-0)
Do you want to scan it? (YES/no/selectively): 
Next adapter: NVIDIA i2c adapter  (i2c-1)
Do you want to scan it? (YES/no/selectively): 
Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Next adapter: SMBus I801 adapter at e8a0 (i2c-3)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x2e
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM85'...                No
Probing for `National Semiconductor LM96000 or PC8374L'...  No
Probing for `Analog Devices ADM1027'...                     No
Probing for `Analog Devices ADT7460 or ADT7463'...          No
Probing for `SMSC EMC6D100 or EMC6D101'...                  No
Probing for `SMSC EMC6D102'...                              No
Probing for `SMSC EMC6D103'...                              No
Probing for `SMSC EMC6D103S'...                             No
Probing for `SMSC EMC6W201'...                              No
Probing for `Winbond WPCD377I'...                           No
Probing for `Analog Devices ADT7467 or ADT7468'...          No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Analog Devices ADT7473'...                     No
Probing for `Analog Devices ADT7475'...                     No
Probing for `Analog Devices ADT7476'...                     No
Probing for `Analog Devices ADT7490'...                     No
Probing for `Andigilog aSC7611'...                          No
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `Analog Devices ADM1024'...                     No
Probing for `National Semiconductor LM93'...                No
Probing for `National Semiconductor LM94'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83791D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Nuvoton W83795G/ADG'...                        No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Winbond W83L785TS-S'...                        No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Maxim MAX6639'...                              No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `Analog Devices ADM1028'...                     No
Probing for `Texas Instruments THMC51'...                   No
Probing for `ITE IT8712F'...                                No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           No
Probing for `SMSC EMC2103'...                               No
Probing for `Fintek F75373S/SG'...                          No
Probing for `Fintek F75375S/SP'...                          No
Probing for `Fintek F75387SG/RG'...                         No
Probing for `Winbond W83791SD'...                           No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Sorry, no sensors were detected.
Either your system has no sensors, or they are not supported, or
they are connected to an I2C or SMBus adapter that is not
supported. If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.

> 
> A register dump of the chip would be welcome too. You can obtain it by
> loading the i2c-dev kernel driver and running i2cdump (from the
> i2c-tools package):
> 
> # modprobe i2c-dev
> # i2cdump N 0x2e
> 
> where N is the i2c bus number displayed by sensors-detect, and 0x2e the
> actual chip address on that bus (can be one of 0x2c, 0x2d or 0x2e.)
> 

i2cdump 3 0x2e

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 8c a1 c2 c4 c1 00 36 00 00 00 2f 2c 0f 0d ff ff    ?????.6.../,??..
30: c7 09 ff ff ff ff 3f 47 6f 0d 0d 00 00 00 5c b1    ??....?Go??...\?
40: 05 00 00 00 00 00 00 ec 1a 04 7e 98 64 da b3 cd    ?......???~?d???
50: b3 cd b3 cd 64 da 81 58 81 58 81 3c 81 37 81 4b    ????d??X?X?<?7?K
60: 81 50 50 46 50 46 78 69 f0 ff f0 ff 04 3f 00 ff    ?PPFPFxi?.?.??..
70: 00 ff 00 ff 00 ff 00 ff 00 ff ed 1a 04 00 00 00    ..........???...
80: a9 a9 49 99 90 cc ff fa e8 88 3f 47 6f 00 00 00    ??I???.????Go...
90: 40 40 2f 2f 2f 2d 7f 7f 7f 7f 7f 7f 20 0d 0d a4    @@///-?????? ???
a0: 28 69 db 00 04 04 04 04 2f 2f 2f 01 1f 00 62 7f    (i?.????///??.b?
b0: 7f 7f 7f 7f 00 00 00 80 00 00 00 00 00 00 00 00    ????...?........
c0: 00 80 40 00 7f 7f 7f 7f 7f 7f 00 00 00 00 00 00    .?@.??????......
d0: 00 ff ff ff ff ff ff ff ff ff ff 6f ff ff ff ff    ...........o....
e0: 00 08 a0 2a e8 00 40 00 18 00 00 00 00 00 00 00    .??*?.@.?.......
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................



> While the EMC6W201 is a pretty complex chip with many advanced
> features, basic monitoring of voltages, fans and temperatures shouldn't
> be that hard to implement.
> 
> Ric, out of curiosity, are you still interested in EMC6W201 support?
> 
> -- 
> Jean Delvare

Thanks Jean for your reply and a possible glimmer of hope.

If I come up with anything wish-list I'll let you know AND
if you need any more info from my machine, I'll try to
come up with it.

Thanks for your reply!  

	Harry McGavran



-- 

Harry G. McGavran, Jr.

E-mail: w5pny@arrl.net


-- 

Harry G. McGavran, Jr.

E-mail: w5pny@arrl.net




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
