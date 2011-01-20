From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 20 Jan 2011 20:04:28 +0000
Subject: Re: [lm-sensors]
Message-Id: <1295553868.9786.435.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-01-20 at 02:45 -0500, R, Durgadoss wrote:
> Hi,
> 
> This patch adds the core temperature threshold support to
> coretemp.c. These thresholds can be configured via the sysfs interfaces
> temp1_max and temp1_max_hyst. An interrupt is generated when CPU temperature
> goes above temp1_max or drops below temp1_max_hyst.
> 
> This patch needs the x86 patch, that can be downloaded
> from here:
> http://git.kernel.org/tip/9e76a97efd31a08cb19d0ba12013b8fb4ad3e474
> 
> ---------------------------------------------
> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Wed, 19 Jan 2011 03:52:19 +0530
> Subject: PATCH[1/1] hwmon:Adding_Threshold_support_to_coretemp
> 
> This patch adds the core temperature threshold support to
> coretemp.c. These thresholds can be configured via the sysfs interfaces
> temp1_max and temp1_max_hyst. An interrupt is generated when CPU temperature
> goes above temp1_max or drops below temp1_max_hyst.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 
Did you try building coretemp, with this patch applied, as module ?

Guess not. platform_thermal_notify is not exported, resulting in the
following error message.

ERROR: "platform_thermal_notify" [drivers/hwmon/coretemp.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
