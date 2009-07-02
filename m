From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 02 Jul 2009 11:25:20 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <20090702132520.2e02959e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>
	<4A4BB4AB.7010003@cam.ac.uk>
	<68FBE0F3CE97264395875AC1C468F22C152BFA@mail03.cyberswitching.local>
	<20090701221310.1d6aa587@hyperion.delvare>
	<68FBE0F3CE97264395875AC1C468F22C152C1D@mail03.cyberswitching.local>
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C152C1D@mail03.cyberswitching.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Verges <chrisv@cyberswitching.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Chris,

On Wed, 1 Jul 2009 13:52:28 -0700, Chris Verges wrote:
> > Probably it's about time to put an end to this and kick all
> > accelerometer drivers out of drivers/hwmon.
> 
> Hi Jean,
> 
> This actually makes a lot of sense.  The remaining question is,
> "To where do we kick them?"
> 
> After reading Jonathan's iio.pdf, I'm all on-board with the
> adxl345 driver being placed in this new subsystem.  However,
> IIO subsystem isn't released into the "vanilla" kernel yet.
> 
> Until the IIO subsystem is finished and I can port the driver
> into it, what's the appropriate place for the adxl345 to
> reside?  misc?  A new directory?

This is a very valid question, and the current situation probably is
the result of it not having a simple answer.

We could create drivers/accelerometer and move the drivers there for
the time being. Or we can move them to drivers/misc until iio is
merged. Honestly, it would be great if iio could be finally merged, it
would help driver authors get their driver in good shape and in the
right place right away. But I know Jonathan is busy and I can't blame
him if things take time.

All in all, I don't really care where the drivers go, as long as it's
not in drivers/hwmon. So the choice is probably better left to the
authors of the accelerometer drivers. Once one driver is moved, the
rest will have to follow.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
