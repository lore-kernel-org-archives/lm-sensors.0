From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 07 Sep 2011 16:06:38 +0000
Subject: Re: [lm-sensors] [PATCH v7] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <1315411598.2455.106.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315388948-20346-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1315388948-20346-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-09-07 at 05:49 -0400, Donggeun Kim wrote:
> This patch allows to read temperature
> from TMU(Thermal Management Unit) of SAMSUNG EXYNOS4 series of SoC.
> 
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changes for v7
>   - removed sysfs_notify function call
>   - changed kobject_uevent_env to kobject_uevent
>   - cleaned up documentation

Thanks, applied. 

FYI, I requested access to the chip datasheet - if I get it, I'll see if
there is a way to get interrupts for 1->0 transitions.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
