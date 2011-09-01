From: Donggeun Kim <dg77.kim@samsung.com>
Date: Thu, 01 Sep 2011 08:17:00 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <4E5F3F7C.5070106@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314781018-29720-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314781018-29720-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 2011년 09월 01일 14:22, Guenter Roeck wrote:
> On Wed, Aug 31, 2011 at 04:56:58AM -0400, Donggeun Kim wrote:
>> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
[snip]
>> +       struct exynos4_tmu_platform_data *pdata = data->pdata;
>> +       unsigned int temp_code;
>> +
>> +       switch (pdata->cal_type) {
>> +       case TYPE_TWO_POINT_TRIMMING:
>> +               temp_code = (temp - 25) *
>> +                   (data->temp_error2 - data->temp_error1) /
>> +                   (85 - 25) + data->temp_error1;
>> +               break;
>> +       case TYPE_ONE_POINT_TRIMMING:
>> +               temp_code = temp + data->temp_error1 - 25;
>> +               break;
>> +       default:
>> +               temp_code = temp + EXYNOS4_TMU_DEF_CODE_TO_TEMP_OFFSET;
>> +               break;
>> +       }
> 
> A bit of an overall question/concern - with all those calculations, can there
> be over- or underflows ? What if temp_code is < 0 (ie 0xffffffXX) or > 255 ?
> 
temp should range between 25 and 125. So, the argument should be checked
whether it is over or under the range.
I will fix it.
[snip]
>> +       struct exynos4_tmu_platform_data *pdata = data->pdata;
>> +       unsigned int temp;
>> +
>> +       switch (pdata->cal_type) {
>> +       case TYPE_TWO_POINT_TRIMMING:
>> +               temp = (temp_code - data->temp_error1) * (85 - 25) /
>> +                   (data->temp_error2 - data->temp_error1) + 25;
>> +               break;
>> +       case TYPE_ONE_POINT_TRIMMING:
>> +               temp = temp_code - data->temp_error1 + 25;
>> +               break;
>> +       default:
>> +               temp = temp_code - EXYNOS4_TMU_DEF_CODE_TO_TEMP_OFFSET;
>> +               break;
>> +       }
>> +
> Any over- or underflow concerns here ?
> 
temp_code, which is read from register, should range between 75 and 175.
It also should be checked.
[snip]
>> +static void exynos4_tmu_work(struct work_struct *work)
>> +{
>> +       struct exynos4_tmu_data *data = container_of(work,
>> +                       struct exynos4_tmu_data, irq_work);
>> +       char *envp[2];
>> +
>> +       mutex_lock(&data->lock);
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
> This is the big one. We'll have to decide how to handle this. There is currently 
> no ABI for uevents. If we permit uevents, I think there should be a common ABI,
> and we should avoid a situation where every driver returns a different set of events.
> 
If you have the common ABI for uevents in mind, I will follow it.
If calling 'kobject_uevent_env' is the matter, I consider replacing it
with koject_uevent function.

Thanks.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
