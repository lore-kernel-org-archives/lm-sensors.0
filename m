From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 06 Sep 2011 15:46:44 +0000
Subject: Re: [lm-sensors] [PATCH v6] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <1315324004.2455.85.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315215663-25960-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1315215663-25960-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-09-05 at 05:41 -0400, Donggeun Kim wrote:
> This patch allows to read temperature
> from TMU(Thermal Management Unit) of SAMSUNG EXYNOS4 series of SoC.
> 
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Looks pretty good now. Only a whitespace nitpick, and we'll still have
to resolve the uevent issue.

[ ... ]

> diff --git a/Documentation/hwmon/exynos4_tmu b/Documentation/hwmon/exynos4_tmu
> new file mode 100644
> index 0000000..7fe12c1
> --- /dev/null
> +++ b/Documentation/hwmon/exynos4_tmu
> @@ -0,0 +1,81 @@
> +Kernel driver exynos4_tmu
> +========> +
> +Supported chips:
> +* ARM SAMSUNG EXYNOS4 series of SoC
> +  Prefix: 'exynos4-tmu'
> +  Datasheet: Not publicly available
> +
> +Authors: Donggeun Kim <dg77.kim@samsung.com>
> +
> +Description
> +-----------
> +
> +This driver allows to read temperature inside SAMSUNG EXYNOS4 series of SoC.
> +
> +The chip only exposes the measured 8-bit temperature code value
> +through a register.
> +Temperature can be taken from the temperature code.
> +There are three equations converting from temperature to temperature code.
> +
> +The three equations are:
> +  1. Two point trimming
> +       Tc = (T - 25) * (TI2 - TI1) / (85 - 25) + TI1
> +
> +  2. One point trimming
> +       Tc = T + TI1 - 25
> +
> +  3. No trimming
> +       Tc = T + 50
> +
The above assignment lines create a whitespace warning (blank before
tab). Please fix.

[ ... ]

> +
> +static void exynos4_tmu_work(struct work_struct *work)
> +{
> +       struct exynos4_tmu_data *data = container_of(work,
> +                       struct exynos4_tmu_data, irq_work);
> +       unsigned int interrupt_stat;
> +       char *envp[2];
> +
> +       mutex_lock(&data->lock);
> +       clk_enable(data->clk);
> +
> +       interrupt_stat = readl(data->base + EXYNOS4_TMU_REG_INTSTAT);
> +
> +       writel(EXYNOS4_TMU_INTCLEAR_VAL, data->base + EXYNOS4_TMU_REG_INTCLEAR);
> +
> +       if (interrupt_stat & EXYNOS4_TMU_TRIG_LEVEL3_MASK) {
> +               envp[0] = "TRIG_LEVEL=3";
> +               sysfs_notify(&data->hwmon_dev->kobj, NULL,
> +                       "temp1_emergency_alarm");
> +       } else if (interrupt_stat & EXYNOS4_TMU_TRIG_LEVEL2_MASK) {
> +               envp[0] = "TRIG_LEVEL=2";
> +               sysfs_notify(&data->hwmon_dev->kobj, NULL,
> +                       "temp1_crit_alarm");
> +       } else if (interrupt_stat & EXYNOS4_TMU_TRIG_LEVEL1_MASK) {
> +               envp[0] = "TRIG_LEVEL=1";
> +               sysfs_notify(&data->hwmon_dev->kobj, NULL, "temp1_max_alarm");
> +       } else
> +               envp[0] = "TRIG_LEVEL=0";
> +       envp[1] = NULL;
> +
> +       kobject_uevent_env(&data->hwmon_dev->kobj, KOBJ_CHANGE, envp);
> +

Concern here is two-fold: envp is driver specific, and sysfs_notify()
should really be called whenever an attribute changes its state. Right
now it is only called for 0->1 transitions, but not for 1->0
transitions, which means that any listener will not get notified for
1->0 transitions. This makes the sysfs notification pretty much useless.

For the uevent, I would suggest to generate the global uevent as other
drivers do it right now. 
	kobject_uevent(&data->hwmon_dev->kobj, KOBJ_CHANGE);
An alternative would be to pass one of the changed attribute names as
environment (eg the highest temperature 0->1 transition).

For the 1->0 transitions, I don't really have a good idea how to handle
it if the chip does not generate interrupts in this case. Not really
sure, though, if calling sysfs_notify even makes sense in that case,
since a poll on a "triggered" attribute file will be stuck forever.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
