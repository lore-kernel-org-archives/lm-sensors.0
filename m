From: Amit Kachhap <amit.kachhap@linaro.org>
Date: Wed, 04 Jan 2012 10:26:07 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/3] thermal: exynos4: Register the tmu
Message-Id: <CAK44p20XeLVkJyox2SsDqyy=RYgEQNpyGGypwTMPXpueQT1T3g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1324468798-20423-1-git-send-email-amit.kachhap@linaro.org>
	<1324468798-20423-3-git-send-email-amit.kachhap@linaro.org>
	<1325629553.26706.11.camel@groeck-laptop>
In-Reply-To: <1325629553.26706.11.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: guenter.roeck@ericsson.com, Donggeun Kim <dg77.kim@samsung.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

Hi Guenter,

The main idea of this work is to leave the current userspace based
notification scheme and add the kernel based cooling scheme on top of
it. Anyway, It is a good idea to move the file hwmon/exynos4_tmu.c as
this creates 2 hwmon entries.
Adding CC: Donggeun Kim to know his opinion.

Thanks,
Amit Daniel

On 4 January 2012 03:55, Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> On Wed, 2011-12-21 at 06:59 -0500, Amit Daniel Kachhap wrote:
>> Export and register information from the hwmon tmu sensor to the samsung
>> exynos kernel thermal framework where different cooling devices and ther=
mal
>> zone are binded. The exported information is based according to the data
>> structure thermal_sensor_conf present in exynos_thermal.h. HWMON sysfs
>> functions are currently left although all of them are present in generic
>> linux thermal layer.
>> Also the platform data structure is modified to pass frequency cooling
>> in percentages for each thermal level.
>>
> Hi Amit,
>
> wouldn't it make more sense to merge the code as necessary from
> hwmon/exynos4_tmu.c into the new thermal/exynos_thermal.c, and drop
> hwmon/exynos4_tmu.c entirely ?
>
> With that, you should get the hwmon entries for free, and we would not
> have to maintain two drivers with overlapping functionality.
>
> Thanks,
> Guenter
>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> ---
>> =A0drivers/hwmon/exynos4_tmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 34 ++++=
++++++++++++++++++++++--
>> =A0include/linux/platform_data/exynos4_tmu.h | =A0 =A07 ++++++
>> =A02 files changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/exynos4_tmu.c b/drivers/hwmon/exynos4_tmu.c
>> index f2359a0..6912a7f 100644
>> --- a/drivers/hwmon/exynos4_tmu.c
>> +++ b/drivers/hwmon/exynos4_tmu.c
>> @@ -37,6 +37,9 @@
>> =A0#include <linux/hwmon-sysfs.h>
>>
>> =A0#include <linux/platform_data/exynos4_tmu.h>
>> +#ifdef CONFIG_SAMSUNG_THERMAL_INTERFACE
>> +#include <linux/exynos_thermal.h>
>> +#endif
>>
>> =A0#define EXYNOS4_TMU_REG_TRIMINFO =A0 =A0 0x0
>> =A0#define EXYNOS4_TMU_REG_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A00x20
>> @@ -248,10 +251,13 @@ static void exynos4_tmu_work(struct work_struct *w=
ork)
>>
>> =A0 =A0 =A0 kobject_uevent(&data->hwmon_dev->kobj, KOBJ_CHANGE);
>>
>> - =A0 =A0 enable_irq(data->irq);
>>
>> =A0 =A0 =A0 clk_disable(data->clk);
>> =A0 =A0 =A0 mutex_unlock(&data->lock);
>> +#ifdef CONFIG_SAMSUNG_THERMAL_INTERFACE
>> + =A0 =A0 exynos4_report_trigger();
>> +#endif
>> + =A0 =A0 enable_irq(data->irq);
>> =A0}
>>
>> =A0static irqreturn_t exynos4_tmu_irq(int irq, void *id)
>> @@ -345,6 +351,14 @@ static const struct attribute_group exynos4_tmu_att=
r_group =3D {
>> =A0 =A0 =A0 .attrs =3D exynos4_tmu_attributes,
>> =A0};
>>
>> +#ifdef CONFIG_SAMSUNG_THERMAL_INTERFACE
>> +static struct thermal_sensor_conf exynos4_sensor_conf =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "exynos4-therm",
>> + =A0 =A0 .read_temperature =A0 =A0 =A0 =3D (int (*)(void *))exynos4_tmu=
_read,
>> +};
>> +#endif
>> +/*CONFIG_SAMSUNG_THERMAL_INTERFACE*/
>> +
>> =A0static int __devinit exynos4_tmu_probe(struct platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 struct exynos4_tmu_data *data;
>> @@ -432,9 +446,20 @@ static int __devinit exynos4_tmu_probe(struct platf=
orm_device *pdev)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 exynos4_tmu_control(pdev, true);
>> -
>> +#ifdef CONFIG_SAMSUNG_THERMAL_INTERFACE
>> + =A0 =A0 (&exynos4_sensor_conf)->private_data =3D data;
>> + =A0 =A0 (&exynos4_sensor_conf)->sensor_data =3D pdata;
>> + =A0 =A0 ret =3D exynos4_register_thermal(&exynos4_sensor_conf);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to register therma=
l interface\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_hwmon_device;
>> + =A0 =A0 }
>> +#endif
>> =A0 =A0 =A0 return 0;
>> -
>> +#ifdef CONFIG_SAMSUNG_THERMAL_INTERFACE
>> +err_hwmon_device:
>> + =A0 =A0 hwmon_device_unregister(data->hwmon_dev);
>> +#endif
>> =A0err_create_group:
>> =A0 =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &exynos4_tmu_attr_group);
>> =A0err_clk:
>> @@ -458,6 +483,9 @@ static int __devexit exynos4_tmu_remove(struct platf=
orm_device *pdev)
>>
>> =A0 =A0 =A0 exynos4_tmu_control(pdev, false);
>>
>> +#ifdef CONFIG_SAMSUNG_THERMAL_INTERFACE
>> + =A0 =A0 exynos4_unregister_thermal();
>> +#endif
>> =A0 =A0 =A0 hwmon_device_unregister(data->hwmon_dev);
>> =A0 =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &exynos4_tmu_attr_group);
>>
>> diff --git a/include/linux/platform_data/exynos4_tmu.h b/include/linux/p=
latform_data/exynos4_tmu.h
>> index 39e038c..642c508 100644
>> --- a/include/linux/platform_data/exynos4_tmu.h
>> +++ b/include/linux/platform_data/exynos4_tmu.h
>> @@ -21,6 +21,7 @@
>>
>> =A0#ifndef _LINUX_EXYNOS4_TMU_H
>> =A0#define _LINUX_EXYNOS4_TMU_H
>> +#include <linux/cpu_cooling.h>
>>
>> =A0enum calibration_type {
>> =A0 =A0 =A0 TYPE_ONE_POINT_TRIMMING,
>> @@ -64,6 +65,9 @@ enum calibration_type {
>> =A0 * =A0 in the positive-TC generator block
>> =A0 * =A0 0 <=3D reference_voltage <=3D 31
>> =A0 * @cal_type: calibration type for temperature
>> + * @freq_pctg_table: Table representing frequency reduction percentage.
>> + * @freq_tab_count: Count of the above table as frequency reduction may
>> + * =A0 applicable to only some of the trigger levels.
>> =A0 *
>> =A0 * This structure is required for configuration of exynos4_tmu driver.
>> =A0 */
>> @@ -79,5 +83,8 @@ struct exynos4_tmu_platform_data {
>> =A0 =A0 =A0 u8 reference_voltage;
>>
>> =A0 =A0 =A0 enum calibration_type cal_type;
>> +
>> + =A0 =A0 struct freq_pctg_table freq_tab[4];
>> + =A0 =A0 unsigned int freq_tab_count;
>> =A0};
>> =A0#endif /* _LINUX_EXYNOS4_TMU_H */
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
