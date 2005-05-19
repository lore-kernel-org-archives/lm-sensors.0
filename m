From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: Raw sensor readings
Message-Id: <20050408021041.GE10623@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY101-F36EBF0A9799BF1039FC5FEA43E0@phx.gbl>
In-Reply-To: <BAY101-F36EBF0A9799BF1039FC5FEA43E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi John:

* John Siegler <siegs@hotmail.com> [2005-04-07 17:31:10 +0000]:
> I apologize if this is the wrong place to ask, but I am simply wondering 
> what is the best way to obtain the raw readings (low order bits) from the 
> sensors, in order to calculate randomness. I read in the values from the 
> /proc/sys/dev/sensors files (using 2.4 kernel), but the values did not seem 
> to contain the low order bits since the fan speed and cpu temp did not 
> change much. Is there an easy way to access this data using libsensors, or 
> will that give me the same not-very-random data? Or is there a driver 
> available?

There's just not enough precision in the measurements to use it as an
entropy source.  Most of the sensors chips have 8 or 9 bits of precision,
with 1/2 degree being the limit.  The fan speed sensors are no better.
Unless your system temps fluctuate wildly (and randomly!), I think it's
not a good use for that.  As if that's not bad enough, we rate-limit
to somewhere between 30-60 readings per minute; so even if it was a good
source of entropy, and you polled the chip constantly (which is not
recommended) you wouldn't get a lot of bits (of entropy) out of it.
Sorry.

If you insist anyway, you could check the datasheet of the sensor chip
and drive it directly with the userspace i2c-dev module to get the 
raw readings.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
