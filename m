From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 07 Dec 2006 12:49:53 +0000
Subject: [lm-sensors] fancontrol with IT8705F
Message-Id: <20061207134953.74926624.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4576F2F4.9050200@gmx.de>
In-Reply-To: <4576F2F4.9050200@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Tobias,

Please answer to the mailing list rather than to me only.

On Thu, 7 Dec 2006 13:09:48 +0100, Tobias Fritz wrote:
> thanks for your reply. I rewrote fancontrol now and it works ok. But I'd still 
> be interested in a better solution. I'll contact the author of speedfan to 
> see if he really got it to work better or just mapped the 0-10 values to his 
> 0-100% settings (if there are just 10 different speeds I can set my fan to I 
> can live very well with the fancontrol hack. However if it is possible to set 
> it to more values it would be nice because right now it goes from 1500 RPM 
> directly to 2000 and then to 2200 and doesn't change much more after that)

Yes, this is typical of an improper PWM base frequency. When I
experimented with different frequencies on my own system, I drew the
following graph:
http://khali.linux-fr.org/devel/lm-sensors/pwm_response_curves.png

As you can see, at high frequencies, the range where I could actually
control the speed was really small, even though not as small as what
you report on your system.

> Output of the isadump:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 19 10 ff 07 37 ff 07 37 ff 07 1a 09 09 ff ff ff
> 10: ff ff ff 72 87 00 01 00 00 00 00 00 00 00 00 00
> 20: 69 00 cf b1 be 00 00 af ff 2d 1b ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ef ff ff
> 40: ff ff ff ff ff ff ff ff 2d ff ff ff ff ff ff ff
> 50: ff 18 7f 7f 7f ff ff ff 90 56 fb 12 00 00 00 00
> 60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
> 70: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff
> 80: 19 10 00 00 37 ff 07 37 ff 07 1a 09 09 ff ff ff
> 90: ff ff ff 72 87 00 01 00 00 00 00 00 00 00 00 00
> a0: 69 00 cf b1 be 00 00 af ff 2d 1b ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ef ff ff
> c0: ff ff ff ff ff ff ff ff 2d ff ff ff ff ff ff ff
> d0: ff 18 7f 7f 7f ff ff ff 90 56 fb 12 00 00 00 00
> e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
> f0: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff

So your current PWM base frequency is 48 MHz (comparing the value of
bits 6-4 of register 0x14 with the IT8705F datasheet) which is the
maximum value. You can use "isaset" to try different frequencies:

isaset 0x295 0x296 0x14 0x00 0x70   # 24 MHz
isaset 0x295 0x296 0x14 0x10 0x70   # 24 MHz
isaset 0x295 0x296 0x14 0x20 0x70   # 12 MHz
isaset 0x295 0x296 0x14 0x30 0x70   # 8 MHz
isaset 0x295 0x296 0x14 0x40 0x70   # 6 MHz
isaset 0x295 0x296 0x14 0x50 0x70   # 3 MHz
isaset 0x295 0x296 0x14 0x60 0x70   # 1.5 MHz
isaset 0x295 0x296 0x14 0x70 0x70   # 0.75 MHz

As a rule of thumb, lower frequencies should give your better control,
but you might also bring annoying sounds. Please experiment with
different values and report.

-- 
Jean Delvare

