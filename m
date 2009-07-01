From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Jul 2009 20:13:10 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <20090701221310.1d6aa587@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>
	<4A4BB4AB.7010003@cam.ac.uk>
	<68FBE0F3CE97264395875AC1C468F22C152BFA@mail03.cyberswitching.local>
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C152BFA@mail03.cyberswitching.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Verges <chrisv@cyberswitching.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 1 Jul 2009 12:19:02 -0700, Chris Verges wrote:
> > What are you actually doing with it?  If you aren't doing hardware
> > monitoring then I would expect you aren't going to receive a
> > favourable response on here.
> 
> The ADXL345 is a 3D accelerometer.  It's very similar to the following
> chips already in the HWMON section of the kernel:
> 
>    - SENSORS_LIS3LV02D
>    - SENSORS_APPLESMC
> 
> The driver provides 3D axis data when the user polls the chip via the
> sysfsinterface.

A few accelerometer drivers were originally added to drivers/hwmon
because the chips also included some hwmon features (e.g. temperature
sensor.) Now every new accelerometer driver gets dropped in
drivers/hwmon "because there are other accelerometer drivers there".
The LIS3LV02D driver is a perfect example of this... the device is not
even registered as a hwmon driver! This driver definitely doesn't
belong there.

Probably it's about time to put an end to this and kick all
accelerometer drivers out of drivers/hwmon.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
