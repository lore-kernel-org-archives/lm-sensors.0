From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 24 Jun 2007 20:31:18 +0000
Subject: Re: [lm-sensors] ASUS M2NPV-VM problems
Message-Id: <467ED496.6000708@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <465D7955.7060307@zerone.se>
In-Reply-To: <465D7955.7060307@zerone.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Krzysztof,
> 
> The high bits of register 0xfc say that this VID value is the "initial"
> value and not the "current" value. You may try writing 0x01 or 0x40 to
> this register to update the VID value, in case it changes anything:
> 
> isaset -y -f 0x2e 0x87
> isaset -y -f 0x2e 0x01
> isaset -y -f 0x2e 0x55
> isaset -y -f 0x2e 0x55
> isaset -y 0x2e 0x2f 0x07 7
> isaset -y 0x2e 0x2f 0xfc 0x01 # or 0x40
> isaset -y 0x2e 0x2f 0x02 0x02
> 
> isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> 

Here is a dump after typing the above commands:
(with isaset -y 0x2e 0x2f 0xfc 0x01)

ubuntu@ubuntu:~$ sudo isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 7 using bank register 0x07.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 87 16 01 01 00 00 00 00 00 00 00 00 1f 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
60: 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00 
70: 00 00 00 38 00 04 00 00 00 00 00 00 00 00 00 00 
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
b0: 00 00 00 00 00 00 00 00 20 00 00 00 00 00 00 00 
c0: 01 00 00 40 00 00 00 00 01 00 00 40 00 00 00 00 
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
f0: 00 00 00 00 00 00 00 00 00 00 00 00 3f 00 00 00 


(with  isaset -y 0x2e 0x2f 0xfc 0x40)
ubuntu@ubuntu:~$ sudo isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 7 using bank register 0x07.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 87 16 01 01 00 00 00 00 00 00 00 00 1f 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
60: 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00 
70: 00 00 00 38 00 04 00 00 00 00 00 00 00 00 00 00 
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
b0: 00 00 00 00 00 00 00 00 20 00 00 00 00 00 00 00 
c0: 01 00 00 40 00 00 00 00 01 00 00 40 00 00 00 00 
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
f0: 00 00 00 00 00 00 00 00 00 00 00 00 7f 00 00 00 

This seems like a hardware is not wired correctly.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
