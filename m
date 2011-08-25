From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Aug 2011 09:17:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <20110825111731.527f3686@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314260034-10358-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314260034-10358-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kim,

On Thu, 25 Aug 2011 17:13:54 +0900, Donggeun Kim wrote:
> This patch allows to read temperature
> from TMU(Thermal Management Unit) of SAMSUNG EXYNOS4 series of SoC.
> 
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  Documentation/hwmon/exynos4_tmu           |   66 ++++
>  drivers/hwmon/Kconfig                     |   10 +
>  drivers/hwmon/Makefile                    |    1 +
>  drivers/hwmon/exynos4_tmu.c               |  478 +++++++++++++++++++++++++++++
>  include/linux/platform_data/exynos4_tmu.h |   83 +++++
>  5 files changed, 638 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/exynos4_tmu
>  create mode 100644 drivers/hwmon/exynos4_tmu.c
>  create mode 100644 include/linux/platform_data/exynos4_tmu.h

I don't have time for a full review at the moment, but one thing stood
out so I'm commenting on that:

> +temp1_alarm	shows which interrupt threshold level is met
> +		1: current temperature exceeds level_0
> +		10: current temperature exceeds level_1
> +		100: current temperature exceeds level_2
> +		1000: current temperature exceeds level_3
> +		RO

This doesn't fit in the standard interface described in
Documentation/hwmon/sysfs-interface and will thus not be accepted.

Unfortunately the best you can do with the standard interface is 3
limits, not four. So you'd have:

temp1_max_alarm
temp1_crit_alarm
temp1_emergency_alarm

so you'll have to omit one of the levels, or map two levels to one
alarm file. These alarm files can only return 0 or 1.

BTW it would be great if you could also implement the corresponding
temp1_max, temp1_crit and temp1_emergency files, at least read-only,
otherwise the alarm files aren't so useful.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
