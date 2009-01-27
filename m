From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Jan 2009 13:29:32 +0000
Subject: Re: [lm-sensors] VRM 11.0 needed for it8718 chip
Message-Id: <20090127142932.4c1eb96f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <495FD5F5.70103@free.fr>
In-Reply-To: <495FD5F5.70103@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Jan 2009 12:48:55 +0100, Vincent Danjean wrote:
> aya:/home/vdanjean# isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 7 using bank register 0x07.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 87 18 05 00 00 01 3b 3f 01 88 01 00 01 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
> c0: 00 3b 3f 01 08 00 00 00 00 00 38 00 00 08 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7e
> f0: 10 40 00 00 00 00 08 00 00 00 00 00 7f 00 00 00

VID value is in register 0xfc, so value 0x7f.

Feeding the VRM 11.0 formula with this value leads to 0.819 V, so I
don't quite get how you manage to get 0. Could it be that you're
running an old version of hwmon-vid? Decoding of VRM 11.0 was fixed in
kernel 2.6.20.

Anyway, a value of 0x7f probably means that the VID pins aren't
connected, so there's not much we can do for you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
