From: chris@ripptech.com (Chris Ripp)
Date: Sun, 19 Jun 2005 22:15:30 +0000
Subject: [lm-sensors] Req for sensors help w/ Asus PC-DL
Message-Id: <42B5D24A.7010704@ripptech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B4EC0B.1020603@ripptech.com>
In-Reply-To: <42B4EC0B.1020603@ripptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[snip]

>We just sent a query about THF chip to winbond we think it might have some additional features. (more fans)
>
>The CPUs itself might have build in sensor. I think it resides on address 0x48 and 0x49
>
>Please can you do:
>
>modprobe i2c-i801
>modprobe i2c-dev
>i2cdump 0 0x48
>i2cdump 0 0x49
>
>  
>
able ~ # i2cdump 0 0x48
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x48, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
10: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
20: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
30: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
40: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
50: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
60: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
70: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
80: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
90: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
a0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
b0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
c0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
d0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
e0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
f0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
able ~ # i2cdump 0 0x49
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x49, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
10: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
20: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
30: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
40: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
50: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
60: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
70: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
80: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
90: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
a0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
b0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
c0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
d0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
e0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP
f0: 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50 7c 00 4b 50    |.KP|.KP|.KP|.KP

I will have to recompile for this, and can't do it right now, when I get
there I'll reply about this section...


>In meanwhile you can try:
>
>modprobe adm1021 force_adm1021=0,0x48
>Or better (i'm not sure about delimiter)
>modprobe adm1021 force_adm1021=0,0x48,0,0x49
>sensors
>
>More on this on monday after my exam.
>
>Regards
>Rudolf
>
>
>  
>

