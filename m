From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Nov 2005 16:22:09 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <wQmA1K3L.1132759311.5781220.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Keith,

> > Keith, is it an ICH7 on your system too, or another
> > incarnation?
> (...)
> 00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus
> Controller (rev 02)

OK, that's an ICH5, so it's a different model. The ICH5 is out there
since quite some times now, we probably would know if the i2c-i801
driver didn't support it properly, including on SMP.

The pretty much rules out the i2c-i801 driver guilt IMHO, on its own at
least.

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> 50: 50 51 52 53 XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX 61 XX XX 64 XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX

I am really curious what the device at 0x64 can be. We don't know of any
device living at that address.

--
Jean Delvare
