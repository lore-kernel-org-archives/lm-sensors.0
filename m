From: tfindlay@internode.on.net (Timothy Findlay)
Date: Mon, 11 Jul 2005 15:55:23 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <42D27327.7050402@internode.on.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Folks,

I've got a zippy new P5WD2 Premium, which is based on the Intel 955 
chipset (Intel 801 SMBus) ... here's my output from "sensors-detect":

Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x30
Client found at address 0x32
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
Client found at address 0x69

Searching my motherboard, I found a myriad of other chips, but I'm 
pretty sure the Winbond W83627EHG-A is the one we're after.

I searched your site a bit, and wondered if I could use the w83627ehf 
driver ? If so, how ?

Here's my output from the following, which address should I use ? or do 
I just start guessing ?

[root@localhost ~]# i2cdetect -l
i2c-0   unknown         SMBus I801 adapter at 0400              
Algorithm unavailable

[root@localhost ~]# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: 30 XX 32 XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

I am basically capable, though hesitant to start hacking/recompiling my 
kernel ... is there any other way to get this driver working ?

I'm running a 2.6.12-1.1390 kernel .... is the new driver likely to be 
bundled in soon ?

PS. I'm using Fedore Core 4 btw ...

Regards,
Tim.
