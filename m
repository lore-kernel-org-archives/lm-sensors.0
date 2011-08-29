From: Donggeun Kim <dg77.kim@samsung.com>
Date: Mon, 29 Aug 2011 09:29:26 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <4E5B5BF6.5040107@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314346902-27528-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314346902-27528-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 2011년 08월 27일 02:45, Guenter Roeck wrote:
> On Fri, 2011-08-26 at 04:21 -0400, Donggeun Kim wrote:
(snip)
>> +static void exynos4_tmu_work(struct work_struct *work)
>> +{
>> +       struct exynos4_tmu_data *data = container_of(work,
>> +                       struct exynos4_tmu_data, irq_work);
>> +       char *envp[2];
>> +
>> +       clk_enable(data->clk);
>> +
>> +       data->interrupt_stat = readl(data->base + EXYNOS4_TMU_REG_INTSTAT);
>> +
>> +       writel(EXYNOS4_TMU_INTCLEAR_VAL, data->base + EXYNOS4_TMU_REG_INTCLEAR);
>> +
>> +       if (data->interrupt_stat & EXYNOS4_TMU_TRIG_LEVEL3_MASK) {
>> +               envp[0] = "TRIG_LEVEL=3";
>> +               sysfs_notify(&data->hwmon_dev->kobj, NULL,
>> +                       "temp1_emergency_alarm");
>> +       } else if (data->interrupt_stat & EXYNOS4_TMU_TRIG_LEVEL2_MASK) {
>> +               envp[0] = "TRIG_LEVEL=2";
>> +               sysfs_notify(&data->hwmon_dev->kobj, NULL,
>> +                       "temp1_crit_alarm");
>> +       } else if (data->interrupt_stat & EXYNOS4_TMU_TRIG_LEVEL1_MASK) {
>> +               envp[0] = "TRIG_LEVEL=1";
>> +               sysfs_notify(&data->hwmon_dev->kobj, NULL, "temp1_max_alarm");
>> +       } else
>> +               envp[0] = "TRIG_LEVEL=0";
>> +       envp[1] = NULL;
>> +
>> +       kobject_uevent_env(&data->hwmon_dev->kobj, KOBJ_CHANGE, envp);
>> +
>> +       enable_irq(data->irq);
>> +
>> +       clk_disable(data->clk);
> 
> Maybe disable the clock first, then re-enable the interrupt ? Anyway,
> the access will need to be mutex protected.
> 
> Another question: it seems the sysfs notification only occurs for a 0->1
> transition, but not for a 1->0 transition. Is there an interrupt for a
> 1->0 transition, or does it only happen silently ?
> 
The datasheet says that current temperature goes down a threshold
temperature, the interrupt is not generated.
> If the 1->0 transition is silent (does not generate an interrrupt), you
> would have to read EXYNOS4_TMU_REG_INTSTAT in the show_alarm functions
> to ensure that the current status is displayed, and to ensure that the
> alarm is ever cleared if the condition goes away. 
> 
The source for an interrupt can be known only when an interrupt occurs
through EXYNOS4_TMU_REG_INTSTAT. In exynos4_tmu_work function,
EXYNOS4_TMU_REG_INTCLEAR register should be cleared for upcoming
interrupts. After writing value for INTCLEAR register, the value of
EXYNOS4_TMU_REG_INTSTAT is reset as zero. Thus, the value read from
EXYNOS4_TMU_REG_INTSTAT stays zero until an interrupt is generated.
The transition from one to zero cannot be known by reading the value of
EXYNOS4_TMU_REG_INTSTAT during normal case (no interrupt period).
Therefore, I'd like to change the show_alarm functions, which read
current temperature and compare the corresponding threshold level, to
determine alarm state.
(snip)

The rest things you commented will be applied in the next patch.

Thanks for your review.






_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
