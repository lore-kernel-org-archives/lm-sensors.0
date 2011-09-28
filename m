From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 28 Sep 2011 12:57:40 +0000
Subject: [lm-sensors] [PATCH] hwmon:ad7314 port from IIO.
Message-Id: <1317214661-31282-1-git-send-email-jic23@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-iio@vger.kernel.org, Device-drivers-devel@blackfin.uclinux.org, Jonathan Cameron <jic23@cam.ac.uk>

I've been moaning about this driver along with the
adt7310, adt7410 and adt75 even since they were
submitted to IIO.  They are all simple temperature
sensors directed at hardware monitoring.

This ad7314 is a very simple part so I've simple
done the port without hardware.  The others are
much more complex beasts.

If anyone wants it more fully featured (for example
I've dropped the clunky support that was in the IIO
driver for powering down between samples) then feel
free to add it.

Main changes from IIO driver.

* dropped mode support
* rewrote the sign extension in temperature read function
  (that was 'interesting' before.)

I'll squish the IIO driver if / when this goes into hwmon.

Entirely plausible I've messed the port up completely so
please take a look!

Thanks,

Jonathan

Jonathan Cameron (1):
  hwmon: ad7314 driver (ported from IIO).

 drivers/hwmon/Kconfig  |   10 +++
 drivers/hwmon/Makefile |    1 +
 drivers/hwmon/ad7314.c |  181 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/ad7314.c

-- 
1.7.3.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
