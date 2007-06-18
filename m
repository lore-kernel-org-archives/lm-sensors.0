From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jun 2007 09:08:00 +0000
Subject: Re: [lm-sensors] ASUS M2NPV-VM problems
Message-Id: <20070618110800.0930b32a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <465D7955.7060307@zerone.se>
In-Reply-To: <465D7955.7060307@zerone.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sat, 16 Jun 2007 17:20:04 +0200, Krzysztof Helt wrote:
> The Asus M2NPV-MX also returns VID = +0.000V.
> 
> The dump is following:
> ubuntu@ubuntu:~$ isadump 0x295 0x296
> Error: Can only be run as root (or make it suid root)
> ubuntu@ubuntu:~$ sudo isadump 0x295 0x296
> WARNING! Running this program can cause system crashes, data loss
> and worse!
> I will probe address register 0x295 and data register 0x296.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 00 64 00 00 00 00 00 00 80 7f 09 07 87 ff ff 
> 10: ff ff ff 70 50 7f 7f 7f 00 ff ff ff ff ff ff ff 
> 20: 4f c8 00 b2 b0 00 00 b0 b4 29 2c 19 05 01 01 01 
> 30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 
> 40: 7f ff 7f ff 7f ff 00 0d 2d ff ff ff ff ff ff ff 
> 50: ff 31 7f 7f 7f 50 f5 00 90 00 3e 12 60 00 00 00 
> 60: 7f 7f 7f 00 00 03 ff ff 7f 7f 7f 00 00 03 ff ff 
> 70: 7f 7f 7f 00 00 03 ff ff ff ff ff ff ff ff ff ff 
> 80: 00 00 00 00 ff ff ff ff 00 00 ff ca 02 00 99 99 
> 90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff 
> a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff 
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 
> ubuntu@ubuntu:~$ isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> Error: Can only be run as root (or make it suid root)
> ubuntu@ubuntu:~$ sudo isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> WARNING! Running this program can cause system crashes, data loss
> and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 7 using bank register 0x07.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00 
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 20: 87 16 01 01 00 00 00 00 00 00 00 00 1f 00 00 00 
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 60: 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 70: 00 00 00 38 00 04 00 00 00 00 00 00 00 00 00 00 
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> b0: 00 00 00 00 00 00 00 00 20 00 00 00 00 00 00 00 
> c0: 01 00 00 40 00 00 00 00 01 00 00 40 00 00 00 00 
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 3f 00 00 00 
> 
> I hope it is helpful.

Both registers (0x0a of the HWM logical device I/O area, and 0xfc of the
Super-I/O config area) agree on the value (6 LSB = 0x3f, which
translates to 0.000 V).

The high bits of register 0xfc say that this VID value is the "initial"
value and not the "current" value. You may try writing 0x01 or 0x40 to
this register to update the VID value, in case it changes anything:

isaset -y -f 0x2e 0x87
isaset -y -f 0x2e 0x01
isaset -y -f 0x2e 0x55
isaset -y -f 0x2e 0x55
isaset -y 0x2e 0x2f 0x07 7
isaset -y 0x2e 0x2f 0xfc 0x01 # or 0x40
isaset -y 0x2e 0x2f 0x02 0x02

isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7

If this doesn't help, possibilities are:
* The CPU VID pins are not connected.
* The CPU VID pins are connected, but the VID_ISEL value isn't correct
for your CPU. That would happen if the pin 5 (JP6) wasn't wired
properly.

In both cases, this is a hardware problem, which can't be worked around
in software.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
