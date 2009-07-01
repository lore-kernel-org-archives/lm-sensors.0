From: "Chris Verges" <chrisv@cyberswitching.com>
Date: Wed, 01 Jul 2009 20:52:28 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <68FBE0F3CE97264395875AC1C468F22C152C1D@mail03.cyberswitching.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local><4A4BB4AB.7010003@cam.ac.uk><68FBE0F3CE97264395875AC1C468F22C152BFA@mail03.cyberswitching.local> <20090701221310.1d6aa587@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

> Probably it's about time to put an end to this and kick all
> accelerometer drivers out of drivers/hwmon.

Hi Jean,

This actually makes a lot of sense.  The remaining question is,
"To where do we kick them?"

After reading Jonathan's iio.pdf, I'm all on-board with the
adxl345 driver being placed in this new subsystem.  However,
IIO subsystem isn't released into the "vanilla" kernel yet.

Until the IIO subsystem is finished and I can port the driver
into it, what's the appropriate place for the adxl345 to
reside?  misc?  A new directory?

Chris

P.S. All references to hwmon will be removed, and the
programmer who added them in will be flogged.  :-) Thanks for
pointing that out!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
