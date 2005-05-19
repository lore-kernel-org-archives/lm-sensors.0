From: william.mcclintock@schriever.af.mil (McClintock William J Contr MCOM)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <B8BD20F161298A42A3B513D23A28556701101F3E@fsglenex3.schriever.af.mil>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Output below...?...The WARNING...Should I be concerned?  Reboot?  etc...

[root@workstation1 cvs2]# i2cdump 1 50
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-1, address 0x32, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
[root@workstation1 cvs2]# i2cdump 1 50 c
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-1, address 0x32, mode byte consecutive read
  You have five seconds to reconsider and press CTRL-C!

Segmentation fault
[root@workstation1 cvs2]#


-----Original Message-----
From: Mark Studebaker [mailto:mds@paradyne.com]
Sent: Wednesday, November 26, 2003 2:10 PM
To: McClintock William J Contr MCOM
Cc: 'sensors@Stimpy.netroedge.com'; frdurso@yahoo.com.br
Subject: Re: unknown eeprom type (65) [ticket #1449]


for the i2cdump test please replace '0' with '1' since
your eeproms are now on bus 1.
thanks

McClintock William J Contr MCOM wrote:

> Output from todays CVS below...Not sure if I should have expected results
or
> what...Attached from modprobes through partial lsmod.
> 
> [root@workstation1 cvs2]# modprobe i2c-isa
> [root@workstation1 cvs2]# modprobe eeprom
> [root@workstation1 cvs2]# modprobe i2c-nforce2
> [root@workstation1 cvs2]# modprobe w83781d
> [root@workstation1 cvs2]# sensors
> eeprom-i2c-1-50
> Adapter: SMBus nForce2 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Unknown EEPROM type (158)
> 
> eeprom-i2c-1-51
> Adapter: SMBus nForce2 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Unknown EEPROM type (158)
> 
> w83627hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.62 V  (min =  +1.57 V, max =  +1.73 V)
> VCore 2:   +1.62 V  (min =  +1.57 V, max =  +1.73 V)
> +3.3V:     +3.25 V  (min =  +3.14 V, max =  +3.46 V)
> +5V:       +4.92 V  (min =  +4.74 V, max =  +5.24 V)
> +12V:     +11.78 V  (min = +10.83 V, max = +13.19 V)
> -12V:     -11.52 V  (min = -13.16 V, max = -10.90 V)
> -5V:       -4.85 V  (min =  -5.26 V, max =  -4.76 V)
> V5SB:      +5.41 V  (min =  +4.74 V, max =  +5.24 V)       ALARM
> VBat:      +0.62 V  (min =  +2.40 V, max =  +3.60 V)       ALARM
> fan1:     5113 RPM  (min = 2678 RPM, div = 2)
> fan2:     5357 RPM  (min = 6887 RPM, div = 2)              ALARM
> fan3:        0 RPM  (min = 2280 RPM, div = 4)              ALARM
> temp1:       +24?C  (high =   +34?C, hyst =   +91?C)   sensor = thermistor
> temp2:     +30.0?C  (high =  +120?C, hyst =  +115?C)   sensor = thermistor
> temp3:     +25.0?C  (high =  +120?C, hyst =  +115?C)   sensor = thermistor
> vid:      +1.650 V
> alarms:
> beep_enable:
>           Sound alarm disabled
> 
> [root@workstation1 cvs2]# i2cdump 0 50
> No size specified (using byte-data access)
> Error: Adapter for i2c bus 0 does not have byte read capability
> [root@workstation1 cvs2]# i2cdump 0 50 c
> Error: Adapter for i2c bus 0 does not have read capability
> [root@workstation1 cvs2]# lsmod
> Module                  Size  Used by    Tainted: P
> i2c-dev                 5088   0  (autoclean)
> w83781d                21744   0  (unused)
> i2c-nforce2             4040   0  (unused)
> eeprom                  5040   0  (unused)
> i2c-proc                7988   0  [w83781d eeprom]
> i2c-isa                 1292   0
> i2c-core               19556   0  [i2c-dev w83781d i2c-nforce2 eeprom
> i2c-proc i2c-isa]
> 
> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Wednesday, November 26, 2003 1:50 PM
> To: sensors@Stimpy.netroedge.com
> Cc: william.mcclintock@schriever.af.mil; frdurso@yahoo.com.br
> Subject: Re: unknown eeprom type (65) [ticket #1449]
> 
> 
> 
>>I'd like the two folks with the problem (or anybody else with a
>>nforce2) try the new i2cdump in cvs to confirm.
>>if 'i2cdump 0 50' works but 'i2cdump 0 50 c' fails then the problem
>>is in the amd756 driver.
> 
> 
> Bill, Fernando, if you please could get i2cdump from CVS and give it a
> try... Thanks.
> 
> 
>>Actually, if anybody has an amd756/66/68 then they could try this too.
>>Maybe the nforce2 acts a little differently...
> 
> 
> I think you're mixing things up. The i2c-amd756 driver covers the
> nforce (1), not the nforce2. I2c-nforce2 is a different driver.
> 
> 
>>Write quick doesn't have any data at all, other than the
>>single read/write bit at the end of the address byte.
> 
> 
> Interesting. So basically it is just meant to check wether someone would
> acknoledge the address or not?
> 

