From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Aug 2014 18:45:01 +0000
Subject: Re: [lm-sensors] [PATCH v4 4/4] drivers/hwmon/menf21bmc_hwmon: introduce MEN14F021P00 BMC HWMON driv
Message-Id: <20140821184501.GC16045@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1407918792.git.andreas.werner@men.de>
 <cf0593273cbadcb16b094b7bc3bd9d3b5a93f7ed.1407918792.git.andreas.werner@men.de>
In-Reply-To: <cf0593273cbadcb16b094b7bc3bd9d3b5a93f7ed.1407918792.git.andreas.werner@men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, wim@iguana.be, linux-watchdog@vger.kernel.org, cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, jdelvare@suse.de, lm-sensors@lm-sensors.org

On Wed, Aug 13, 2014 at 10:40:37AM +0200, Andreas Werner wrote:
> Added driver to support the 14F021P00 BMC Hardware Monitoring.
> The BMC is a Board Management Controller including monitoring of the
> board voltages.
> 
> Signed-off-by: Andreas Werner <andreas.werner@men.de>
> ---
>  drivers/hwmon/Kconfig           |   7 ++
>  drivers/hwmon/Makefile          |   1 +
>  drivers/hwmon/menf21bmc_hwmon.c | 238 ++++++++++++++++++++++++++++++++++++++++

Forgot: Please also provide Documentation/hwmon/menf21bmc.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
