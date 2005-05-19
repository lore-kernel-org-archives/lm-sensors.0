From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: lm77 on national sc1100
Message-Id: <20040706204052.31744a2b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> So, here is an updated version of the lm77 driver that exports the
> hysteresis for all three limits as an absolute value.

A few additional comments:

1* I guess you could use s16 instead of int to store temperature values.

2* Your "set" functions are not correct. You use temporary variables to
store the values instead of the internal variables. This means that
reading the value right after writing it will return the old value (for
at most HZ + HZ / 2). You also change the value of write min_hyst and
max_hyst (internal variables) at the time you change crit or crit_hyst.
This may make you reconsider your choice of storing 3 different values
for the three hysteresis values instead of computing them on the fly
(not sure, you choose).

3* Your alignment for DEVICE_ATTR calls hardly makes them readable. I
doubt kernel people will like this. Also, please split lines when they
go to long. Same goes for some other places in the code.

4* This comment: "temperature registers: low 3 bits are unused" is
misleading. The bits are not unused, they are just not part of the
temperature value. BTW, what about exporting these three bits in an
"alarm" file? Whould be quite straightforward.

5* Please discard the "which is exactly opposite to the usual practice"
comment about byte ordering. It turns out that high byte first is the
usual practice, and we chose the wrong default in the i2c core (long
time ago). I guess you picked this from lm75.c, which would benefit a
similar update.

6* In lm77_update_device you define a variable in the middle of a block.
I'm surprised it did even compile. At any rate, not all compilers will
accept it, so please don't do that.

All the rest is fine (as far as I can see)!

In the end you'll have to submit your driver as a complete patch
(including changes to Kconfig and Makefile) against the kernel tree. The
base tree for your patch should be 2.6.7-mm5 (or -mm6) +
http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.7-mm5-i2c.patch.gz.

> While testing I figured out that the low three bits of the temperature
> limit registers are actually not unused: they contain the same status
> bits as the temperature registers (and indeed, the datasheet doesn't
> say that they should be 0 like it does for the high 3 bits of the
> config register, it just declares them as undefined). Therefore I had
> to remove the unused bits detection step from the source (apart from
> the check on the config register) and I suggest that the same should
> be done in the sensors-detect script.

I actually suspected that from the beginning and the sensors-detect
script never made any assumption about these bits. But thanks for
letting us know.

-- 
Jean Delvare
http://khali.linux-fr.org/
