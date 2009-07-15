From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Jul 2009 20:07:53 +0000
Subject: Re: [lm-sensors] Thermal driver for EMC1403
Message-Id: <20090715220753.6e82929b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090716005145.GA8012@intel.com>
In-Reply-To: <20090716005145.GA8012@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kalhan,

On Wed, 15 Jul 2009 20:51:46 -0400, Kalhan Trisal wrote:
> From 91f6d1d006741bb07a2e6603452b503a840c5c4d Mon Sep 17 00:00:00 2001
> From: Kalhan Trisal <kalhan.trisal@intel.com>
> Date: Wed, 15 Jul 2009 20:38:15 -0400
> Subject: [PATCH] Thermal driver for EMC1403 chip
> 
> Moorestown Platform has EMC1403 chip which support three thermal devices, one thermal zone is used by the EMC1403 chip itself and second is used by processor and third one is used for platform (skin temperature).Driver support poll and interrupt mode,min/max/crit configuration can be done using sysfs interface.
> The driver also support interrupt mode when the temperature crosses the threshold configured value the min/max/crit. ALERT/THERM interrupt will be triggered and driver register its callback with GPE driver, and send the events to OSPM power management to take action. OSPM will take action and set the new threshold values till it doesnot get ALERT/THERM events.temp1 is used for configuring internal EMC1403 chip diode, temp2 is used to configure processor diode and temp3 is used to configure the platform diode.
> 
> The interrupt mode code  has dependency MRST GPIO/MAX7315/OSPM drivers.Flag is added to differentiate the generic functional with Moorestown specific.
> 
> Signed-off-by: Kalhan Trisal <kalhan.trisal at intel.com>
> 
> ---
>  drivers/hwmon/Kconfig     |   10 +
>  drivers/hwmon/Makefile    |    1 +
>  drivers/hwmon/emc1403.c   |  738 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel_mid.h |    8 +
>  4 files changed, 757 insertions(+), 0 deletions(-)
>  create mode 100755 drivers/hwmon/emc1403.c

You sent the patch to me but I do not have the time to review your
driver. You will have to find somebody else, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
