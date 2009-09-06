From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Sep 2009 08:21:17 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <20090906102117.3ca2d4e0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karl,

On Sat, 05 Sep 2009 17:03:40 -0500, Karl Schmidt wrote:
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1, address 0x2e, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff    ................
> 20: 64 79 c3 c3 c1 24 1a 17 b2 02 95 02 aa 02 ab 02    dy???$??????????
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 5c 89    ..............\?
> 40: 05 00 00 00 00 4d 00 ff 00 ff 00 ff 00 ff 81 7f    ?....M........??
> 50: 81 7f 81 7f a3 02 58 02 ff ff ff ff 02 02 02 a7    ??????X?....????
> 60: a7 a7 e0 00 00 00 00 2d 2d 2d 64 64 64 44 40 00    ???....---dddD@.
> 70: 00 00 00 09 09 09 09 09 09 00 30 00 40 00 00 1c    ...??????.0.@..?
> 80: 00 a4 00 00 44 2a 86 c3 0d 00 4d 4d 0b 0b 0c 00    .?..D*???.MM???.
> 90: cc cc cc cc 0c 0c 0c 5a f1 c0 ae 00 ff 00 ff 00    ???????Z???.....
> a0: 00 00 0c 00 00 00 00 0b 0b fe ff fe ff ff ff ff    ..?....???.?....
> b0: ff 00 00 00 00 00 28 28 0e 0e 2b 2b 00 00 00 00    ......((??++....
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

I have just checked the DME1737 datasheet. This chip doesn't have
real-time status registers but interrupt status registers. In these
registers, each bit can be enabled or disabled individually. If
interrupts are globally enabled, this lets the vendor decide which
events should trigger an interrupt.

The interrupt enable registers are at 0x7E, 0x80 and 0x82. As you can
see, you have only zeroes in these registers, meaning that all
interrupts are disabled. This is why you don't see any alarm flag.
According to the datasheet, this isn't the default value. So this
suggests your mainboard vendor willingly disabled all the individual
interrupt bits.

The global interrupt enable flag is also disabled (register 0x7c bit
2), which is the default. This makes me wonder why the vendor disabled
the individual bits, given that they wouldn't trigger any interrupt
anyway.

Juerg, I don't think the current situation is satisfying: the dme1737
driver is creating *_alarm files in sysfs for alarms which will never
trigger. I think the driver should be modified to check the individual
interrupt enable bits, and only export alarm files for interrupts which
can trigger. What do you think?

Then we may also discuss whether it is desirable to enable individual
interrupt bits when the rest of the configuration is such that physical
interrupts will never trigger anyway. If both the global interrupt bit
and the group enable bits are clear, this should be safe as far as I
can see. This would let users see the alarm flags even when the BIOS
disabled them without a good reason. What do you think?

Karl, I suggest that you go check the BIOS options of your system.
Maybe there are ways to enable or disable an action (such as beeping or
thermal throttling) on some hardware monitoring events? This might
explain what we're seeing. If there are such options, please toggle
them, check whether this gives your alarms in "sensors", and provide a
new i2c dump for each relevant combination.

If you can't find any such option, and want your alarm flags to raise,
here is how you can do that on your system:

# modprobe i2c-dev
# rmmod dme1737
# i2cset -y 0 0x2e 0x7e 0xec
# i2cset -y 0 0x2e 0x80 0x7e
# i2cset -y 0 0x2e 0x82 0x0e
# modprobe dme1737

This will restore the interrupt bits to what the datasheet lists as
the default. I expect this to let you see alarm flags on out-of-limits
conditions again.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
