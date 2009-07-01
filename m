From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Jul 2009 19:33:11 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <20090701213311.04d9a8bd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>
	<4A4BB4AB.7010003@cam.ac.uk>
In-Reply-To: <4A4BB4AB.7010003@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>, Chris Verges <chrisv@cyberswitching.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 01 Jul 2009 19:10:35 +0000, Jonathan Cameron wrote:
> 
> > Hi kernel hackers,
> > 
> > Here is a patch that adds support to the Linux kernel for Analog
> > Device's ADXL345 chip.  It is an accelerometer that uses I2C and HWMON.
> > When I looked into the MAINTAINERS file for the appropriate list, the
> > "Orphan" status of "Hardware Monitoring" confused me as to the proper
> > list for this patch ... please let me know if I need to forward it
> > elsewhere.
> Hi Chris,
> 
> Just for reference this chip is definitely on my list of ones to support
> via the Industrial I/O (iio) framework, I just haven't managed to get hold
> of one as yet!  It's particualrly interesting to me because of the fifo
> buffering functionality as currently I only have access to a VTI chip
> that does something similar.
> 
> A new version of the IIO framework will get posted just
> as soon as I've had a few mins to bring the documentation / demo userspace
> apps up to date with the current code state.
> I've been chasing down bugs for the last week.
> 
> First big question is:
> 
> What are you actually doing with it?  If you aren't doing hardware
> monitoring then I would expect you aren't going to receive a favourable
> response on here.

Absolutely correct. Chris' driver doesn't implement any attribute
listed in Documentation/hwmon/sysfs-interface. The device registers as
a hwmon device for no good reason I can think of, and the driver
includes hwmon headers it doesn't make any use of. So to me it doesn't
look like a good candidate for drivers/hwmon. Chris, I suggest that you
remove all references to hwmon from your driver, and resubmit it to a
different subsystem (iio, misc, input, whatever.)

> (see the original IIO discussion on LKML for why I
> started writing that in the first place.
> http://lkml.org/lkml/2008/5/20/135)
> It's somewhat out of date and incomplete, but there is a white paper draft at
> http://www-sigproc.eng.cam.ac.uk/~jic23/iio.pdf
> 
> I'll take a look at the actual code tomorrow.  Always good to see another
> accelerometer driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
