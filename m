From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 Jan 2012 18:52:27 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error handling
Message-Id: <20120128195227.17787e04@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 27 Jan 2012 14:22:00 +0100, Frans Meulenbroeks wrote:
> 2012/1/26 Jean Delvare <khali@linux-fr.org>
> > Frans, could you please provide a register dump of your LM96080 chip?
> > I'd like to add that to my collection. You can get such a dump using
> > the i2c-dev driver + i2cdump (from package i2c-tools.)
> 
> I hope this is what you are looking for:
> 
> root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028# cat
> fan1_input
> 3668
> root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028#
> i2cdump  1 0x28
> No size specified (using byte-data access)
> Error: Could not set address to 0x28: Device or resource busy
> root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028#
> i2cdump -f 1 0x28
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1, address 0x28, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 01 7f 2d 00 00 3c 18 00 00 00 00 00 00 00 00 00    ??-..<?.........
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 0c 00 00 00 00 00 00 1a 2e ff 00 00 00 00 00 00    ?......?........
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 08    ..............??
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 
> Not fully sure if this is correct as I had to use -f

That's perfect, thank you.

> Also fan1_input is 3668, which is hex 0e54 but I do not see that value in
> the dump.

As is the case of most monitoring chips, the LM96080 doesn't measure
the fan speed directly. Instead, it measures how much time it takes to
the fan to spin once, and this time is expressed in units of an
internal clock (22.5 kHz). The relevant register is 0x28, value is 0x2e
or 46. The speed is computed as:

RPM = (22.5k * 60) / (register value * divisor)

Where the divisor is 1, 2, 4 or 8, encoded in register 0x05. In your
case the divisor is 8, which leads to :

22.5 *  1000 * 60 / (46 * 8) = 3668 RPM

As a side note, a divisor of 4 or even 2 would yield better speed
measurement accuracy in your case (i.e. you can set fan1_div to 2 in
your configuration file.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
