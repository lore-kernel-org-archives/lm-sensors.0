From: "Chris Verges" <chrisv@cyberswitching.com>
Date: Wed, 01 Jul 2009 19:19:02 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <68FBE0F3CE97264395875AC1C468F22C152BFA@mail03.cyberswitching.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local> <4A4BB4AB.7010003@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Jonathan,

Thanks for the response!

> Just for reference this chip is definitely on my list of ones to
support
> via the Industrial I/O (iio) framework, I just haven't managed to get
hold
> of one as yet!

If you need a sample set, let me know off the mailing list.  I may be
able
to ship a couple to you ... need to check our available stock.  I think
ours are BGAs, in case you have the intention of soldering by hand.  :-)

> What are you actually doing with it?  If you aren't doing hardware
> monitoring then I would expect you aren't going to receive a
favourable
> response on here.

The ADXL345 is a 3D accelerometer.  It's very similar to the following
chips already in the HWMON section of the kernel:

   - SENSORS_LIS3LV02D
   - SENSORS_APPLESMC

The driver provides 3D axis data when the user polls the chip via the
sysfs
interface.

The ADXL345 has the additional capability of being a "tap-touch"
detector --
almost like an input device, if you will -- but this driver doesn't
expose
that functionality.  Maybe in the future.

> I'll take a look at the actual code tomorrow.  Always good to see
another
> accelerometer driver.

Thanks!  Looking forward to the feedback.

Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
