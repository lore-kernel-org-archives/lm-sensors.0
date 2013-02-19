From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Feb 2013 01:02:29 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (adt7410) Don't re-read non-volatile registers
Message-Id: <20130219010229.GA25124@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de>
 <51228D7A.8030608@gmx.de>
In-Reply-To: <51228D7A.8030608@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Mon, Feb 18, 2013 at 09:22:18PM +0100, Hartmut Knaack wrote:
> Lars-Peter Clausen schrieb:
> > Currently each time the temperature register is read the driver also reads the
> > threshold and hysteresis registers. This increases the amount of I2C traffic and
> > time needed to read the temperature by a factor of ~5. Neither the threshold nor
> > the hysteresis change on their own, so once we've read them, we should be able
> > to just use the cached value of the registers. This patch modifies the code
> > accordingly and only reads the threshold and hysteresis registers once during
> > probe.
> I have been thinking about this a lot, and I am concerned about data integrity. From what I know about I2C, there is no data integrity verification specified in the protocol. So, what the master sends is not necessarily what the slave receives (not to mention other devices on the bus, which could potentially mess around with the slaves, or even reset of the slave). Reading back just cached values makes it pretty hard to verify, if there are issues. I think it might be better to call a read-temperature function with a parameter that indicates, which temperature register is required.

I am not concerned about that, unless there is a known issue with the chip
and it is known to return bad data under some circumstances. I am doing the
same in the PMBus drivers, since there are simply too many limit registers
to read on some of the chips (there may literally be more than a hundred).
That works fine most of the time; if it does not work, it is a chip problem,
an i2c bus master problem, a hardware signal problem, or a combination of all.
I actually think it is better if the problem is exposed by cached bad readings.
Then there is a chance to do something about it. This would be much better
than just re-reading the value next time and ignoring the problem.

Something else - the commit window just opened (a week earlier than I guessed),
so this part of the series is going to miss 3.9. Hartmut, if you plan to provide
an Acked-by or Reviewed-by or Tested-by for the first part of the series, you'll
have to do it soon, as I plan to send my push request to Linus around Thursday.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
