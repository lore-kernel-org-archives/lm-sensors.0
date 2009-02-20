From: Gabriel C <crazy@frugalware.org>
Date: Fri, 20 Feb 2009 00:31:40 +0000
Subject: Re: [lm-sensors] Intel DQ45CB motherboard and weird sensors output
Message-Id: <499DF9EC.40404@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <499372A3.6080803@frugalware.org>
In-Reply-To: <499372A3.6080803@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> Hi Gabriel,
> 
> On Wed, 18 Feb 2009 00:53:35 +0100, Gabriel C wrote:
>> I've found the following Super-I/O chip on the mobo :
>>
>> Winbond WPCD377IAUFG
>>
>> So it seems you are right.
> 
> OK, thanks for reporting. I have just committed a fix to sensors-detect
> so that it will differentiate between LM96000/PC8374L (have sensors)
> and WPCD377I (no sensors) on the SMBus. Please give it a try:
> http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect


Thanks , I will test when I'm home and report back.

> 
> The next step would be to differentiate between PC8374L and WPCD377I on
> the LPC bus. I don't know how do to that though, as I don't have any
> datasheet for the WPCD377I. I'll ask my contact at Nuvoton. In the
> meantime, can you please provide the output of the following command:
> 
> isadump 0x2e 0x2f 8


Sure , here it is :

sudo isadump 0x2e 0x2f 8
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 8 using bank register 0x07.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 41
20: f1 01 00 00 01 01 00 91 00 11 2e 00 00 10 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
