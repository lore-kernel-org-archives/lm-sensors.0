From: Jordan <xero@xeron.cc>
Date: Wed, 18 Apr 2007 01:27:53 +0000
Subject: Re: [lm-sensors] w83627dhg msi 975x problems
Message-Id: <20070418012753.GA6861@xeron.cc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415185853.GA11766@xeron.cc>
In-Reply-To: <20070415185853.GA11766@xeron.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 17, 2007 at 11:27:51PM +0200, Jan van Tiggelen wrote:
> At the moment, schematics for both the 83627DHG and the ICH7 and also the
> full bios changelog for this board are in the request queue at MSI again.
> 
> Probably this time it does make sense to use the PECI interface for giving
> more system controls to the ICH7. Let's see what the schematics will tell
> us.

Hmm, I read that the ICH8 supports PECI (in the kernel documents for the ehf
driver) however I never read anything about ICH7 supporting it...in either
case I'm not very familiar with it.
 
> Jordan, meanwhile, could you post your current BIOS version? And did you
> check the other outputs from your sensors, such as voltages, etc.... Are
> they all reading correctly?
> 

OK, so I got the isadumps and the bios version. I made sure the driver
didn't get loaded. I did a diff on the dumps, it does seem that the output
changes, although I'm assuming this could be the voltages/temperatures/etc
which are changing, so I'm not going to make any assumptions just yet.

bios is 7.3b7

infact it seems i'm one version out of date. it doesn't even list 7.3 on their
official bios page here, which is strange...

http://global.msi.com.tw/index.php?func=downloaddetail&type=bios&maincat_no=1&prod_no&7

and here are the isadumps:

smart fan in bios off:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 7f 03 00 00 00 01 01 01 01 3c 3c 0a 0a
10: 04 ff 00 00 00 01 01 3c 42 17 00 00 ff ff ff c4
20: 99 ec cd cd ff b5 c3 22 3a 12 35 da 00 96 18 9e
30: 5b 44 34 04 60 38 b6 0f 23 51 08 87 a4 2a 05 ff
40: 01 2e 1f fe ff ff 01 05 2d 00 00 04 58 95 00 a3
50: ff ff 00 ff ff ff 00 80 c1 70 ff ff 19 e5 04 05
60: 04 7f 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: 04 ff 04 7f 03 00 00 00 01 01 01 01 3c 3c 0a 0a
90: 04 ff 00 00 00 01 01 3c 42 17 00 00 ff ff ff c6
a0: 99 ec cd cd ff b5 c3 22 3a 12 35 da 00 96 18 9e
b0: 5b 44 34 04 60 38 b6 0f 23 51 08 87 a4 2a 05 ff
c0: 01 00 10 fe ff ff 01 05 2d 00 00 04 58 95 00 a3
d0: ff ff 00 ff ff ff 00 80 c1 70 ff ff 19 e5 04 05
e0: 04 7f 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


smart fan in bios on:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 7f 03 00 00 00 01 01 01 01 3c 3c 0a 0a
10: 04 ff 00 00 00 01 01 3c 42 17 00 00 ff ff ff c8
20: 98 ec cd cd ff b5 c3 22 38 27 34 da 00 9e 18 9e
30: 1b 44 34 04 60 78 96 1f 23 51 08 86 a4 2a 04 ff
40: 01 6e 1f fe ff ff 01 05 2d 00 00 04 58 95 00 a3
50: ff ff 00 ff ff ff 00 80 c1 70 ff ff 19 e5 04 05
60: 04 7f 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: 04 ff 04 7f 03 00 00 00 01 01 01 01 3c 3c 0a 0a
90: 04 ff 00 00 00 01 01 3c 42 17 00 00 ff ff ff ca
a0: 98 ec cd cd ff b5 c3 22 38 28 34 da 00 9e 18 9e
b0: 1b 44 34 04 60 78 96 1f 23 51 08 86 a4 2a 04 ff
c0: 01 00 10 fe ff ff 01 05 2d 00 00 04 58 95 00 a3
d0: ff ff 00 ff ff ff 00 80 c1 70 ff ff 19 e5 04 05
e0: 04 7f 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

As far as I can tell, voltages/temperatures/etc are all working
correctly. Although I did initially have an issue with 3 temperature
sensors showing up, where as my bios only shows 2. I'm guessing this
motherboard just doesn't use the one, so it was constantly reporting
ridiculous values. I just added an ignore line in my sensors.conf for
that. For reference, here's the output of sensors:

w83627dhg-isa-0290
Adapter: ISA adapter
VCore:     +1.21 V  (min =  +0.00 V, max =  +1.74 V) 
in1:      +12.51 V  (min =  +1.27 V, max =  +8.34 V) ALARM
AVCC:      +3.28 V  (min =  +0.43 V, max =  +2.53 V) ALARM
3VCC:      +3.28 V  (min =  +0.83 V, max =  +1.09 V) ALARM
in4:       +2.04 V  (min =  +0.77 V, max =  +0.03 V) ALARM
in5:       +1.45 V  (min =  +1.20 V, max =  +0.96 V) ALARM
in6:       +4.99 V  (min =  +0.90 V, max =  +0.79 V) ALARM
VSB:       +3.25 V  (min =  +0.13 V, max =  +1.25 V) ALARM
VBAT:      +3.09 V  (min =  +2.13 V, max =  +1.15 V) ALARM
Case Fan: 1480 RPM  (min =  629 RPM, div = 16)
CPU Fan:  2109 RPM  (min =  514 RPM, div = 16)
Aux Fan:  1591 RPM  (min = 2008 RPM, div = 16) ALARM
Sys Temp:    +33 C  (high =   +81 C, hyst =    +8 C)  
CPU Temp:  +33.5 C  (high = +120.0 C, hyst = +115.0 C)  

coretemp-isa-0000
Adapter: ISA adapter
temp1:       +29 C  (high =   +85 C)

coretemp-isa-0001
Adapter: ISA adapter
temp1:       +24 C  (high =   +85 C)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
