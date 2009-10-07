From: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Date: Wed, 07 Oct 2009 16:31:47 +0000
Subject: Re: [lm-sensors] [RFC][PATCH 0/2] LIS3LV02D I2C driver
Message-Id: <4ACCC273.1030308@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1254391591-9696-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1254391591-9696-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: eric.piel@tremplin-utc.net, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>

Just a quick heads up wrt overlapping work.

For the i2c support Kalhan Trisal has been posting patches for i2c
support for this
driver to the lm-sensors list for some time and the latest version of that
set is also pretty clean.

The changes in these two patch sets should probably be reconciled before
merging.

> These patches add I2C bus support for LIS3LV02D accelerometer driver
> and possibility to use platform configurability for
> remapping of device axes.
>
> Changes are tested on linux-omap environment.
> Applies to 2.6.32-rc1.
>
> Samu Onkalo (2):
>   LIS3LV02D: axis remap, irq and resource setup / release added to
>     platform data
>   LIS3LV02D: I2C support
>
>  drivers/hwmon/Kconfig         |   17 ++++
>  drivers/hwmon/Makefile        |    1 +
>  drivers/hwmon/lis3lv02d.h     |    1 +
>  drivers/hwmon/lis3lv02d_i2c.c |  183 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/lis3lv02d.h     |   13 +++
>  5 files changed, 215 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/lis3lv02d_i2c.c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
