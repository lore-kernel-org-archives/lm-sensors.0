From: Amit Kachhap <amit.kachhap@linaro.org>
Date: Tue, 13 Mar 2012 04:34:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] thermal: exynos: Add thermal interface support for linux thermal layer
Message-Id: <CAK44p23NwjPe3Ku0tfFXCQzi+2fdgEipFf+oCVKk99sC9qVMBA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330772767-16120-1-git-send-email-amit.kachhap@linaro.org>
	<1330772767-16120-2-git-send-email-amit.kachhap@linaro.org>
	<4D68720C2E767A4AA6A8796D42C8EB5904B13D@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5904B13D@BGSMSX101.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "patches@linaro.org" <patches@linaro.org>

Hi Durgadoss,

Thanks for the detailed review.

On 12 March 2012 16:21, R, Durgadoss <durgadoss.r@intel.com> wrote:
> Hi Amit,
>
> Thanks for keeping this up. And Sorry for late reply.
>
>> -----Original Message-----
>> From: amit kachhap [mailto:amitdanielk@gmail.com] On Behalf Of Amit Dani=
el
>> Kachhap
>> Sent: Saturday, March 03, 2012 4:36 PM
>> To: linux-pm@lists.linux-foundation.org; linux-samsung-soc@vger.kernel.o=
rg
>> Cc: linux-kernel@vger.kernel.org; mjg59@srcf.ucam.org; linux-
>> acpi@vger.kernel.org; lenb@kernel.org; linaro-dev@lists.linaro.org; lm-
>> sensors@lm-sensors.org; amit.kachhap@linaro.org; eduardo.valentin@ti.com=
; R,
>> Durgadoss; patches@linaro.org
>> Subject: [PATCH 1/4] thermal: exynos: Add thermal interface support for =
linux
>> thermal layer
>>
>> This codes uses the generic linux thermal layer and creates a bridge
>> between temperature sensors, linux thermal framework and cooling devices
>> for samsung exynos platform. This layer recieves or monitor the
>> temperature from the sensor and informs the generic thermal layer to take
>> the necessary cooling action.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> ---
>> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A08 +
>> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/thermal/exynos_thermal.c | =A0272 +++++++++++++++++++++++++++=
+++++++++++
>> =A0include/linux/exynos_thermal.h =A0 | =A0 72 ++++++++++
>> =A04 files changed, 353 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/thermal/exynos_thermal.c
>> =A0create mode 100644 include/linux/exynos_thermal.h
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 298c1cd..4e8df56 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -29,3 +29,11 @@ config CPU_THERMAL
>> =A0 =A0 =A0 =A0 This will be useful for platforms using the generic ther=
mal interface
>> =A0 =A0 =A0 =A0 and not the ACPI interface.
>> =A0 =A0 =A0 =A0 If you want this support, you should say Y or M here.
>> +
>> +config SAMSUNG_THERMAL_INTERFACE
>> + =A0 =A0 bool "Samsung Thermal interface support"
>> + =A0 =A0 depends on THERMAL && CPU_THERMAL
>> + =A0 =A0 help
>> + =A0 =A0 =A0 This is a samsung thermal interface which will be used as
>> + =A0 =A0 =A0 a link between sensors and cooling devices with linux ther=
mal
>> + =A0 =A0 =A0 framework.
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 655cbc4..c67b6b2 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -4,3 +4,4 @@
>>
>> =A0obj-$(CONFIG_THERMAL) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D thermal_sys=
.o
>> =A0obj-$(CONFIG_CPU_THERMAL) =A0 =A0+=3D cpu_cooling.o
>> +obj-$(CONFIG_SAMSUNG_THERMAL_INTERFACE) =A0 =A0 =A0+=3D exynos_thermal.o
>> diff --git a/drivers/thermal/exynos_thermal.c
>> b/drivers/thermal/exynos_thermal.c
>> new file mode 100644
>> index 0000000..878d45c
>> --- /dev/null
>> +++ b/drivers/thermal/exynos_thermal.c
>> @@ -0,0 +1,272 @@
>> +/* linux/drivers/thermal/exynos_thermal.c
>> + *
>> + * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
>> + * =A0 =A0 =A0 =A0 =A0 http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/thermal.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/err.h>
>> +#include <linux/slab.h>
>> +#include <linux/cpu_cooling.h>
>> +#include <linux/exynos_thermal.h>
>> +
>> +#define MAX_COOLING_DEVICE 4
>> +struct exynos4_thermal_zone {
>> + =A0 =A0 unsigned int idle_interval;
>> + =A0 =A0 unsigned int active_interval;
>> + =A0 =A0 struct thermal_zone_device *therm_dev;
>> + =A0 =A0 struct thermal_cooling_device *cool_dev[MAX_COOLING_DEVICE];
>> + =A0 =A0 unsigned int cool_dev_size;
>> + =A0 =A0 struct platform_device *exynos4_dev;
>> + =A0 =A0 struct thermal_sensor_conf *sensor_conf;
>> +};
>> +
>> +static struct exynos4_thermal_zone *th_zone;
>> +
>> +static int exynos4_get_mode(struct thermal_zone_device *thermal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum thermal_device_mo=
de *mode)
>> +{
>> + =A0 =A0 if (th_zone->sensor_conf) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("Temperature sensor not initialised\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 *mode =3D THERMAL_DEVICE_DISABLED;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 *mode =3D THERMAL_DEVICE_ENABLED;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int exynos4_set_mode(struct thermal_zone_device *thermal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum thermal_device_mo=
de mode)
>> +{
>> + =A0 =A0 if (!th_zone->therm_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_notice("thermal zone not registered\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> + =A0 =A0 if (mode =3D=3D THERMAL_DEVICE_ENABLED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 th_zone->therm_dev->polling_delay =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_zone->activ=
e_interval*1000;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 th_zone->therm_dev->polling_delay =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_zone->idle_=
interval*1000;
>
> If it is 'DISABLED' mode, shouldn't the polling delay be just 0 ?
Yes Ideally this should be zero. But I wanted thermal monitoring to
always happen with some long interval in case of error scenarios.
Anyway I will check this again.
>
>> +
>> + =A0 =A0 thermal_zone_device_update(th_zone->therm_dev);
>> + =A0 =A0 pr_info("thermal polling set for duration=3D%d sec\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_zone->therm=
_dev->polling_delay/1000);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*This may be called from interrupt based temperature sensor*/
>> +void exynos4_report_trigger(void)
>> +{
>> + =A0 =A0 unsigned int monitor_temp;
>> +
>> + =A0 =A0 if (!th_zone || !th_zone->therm_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 monitor_temp =3D th_zone->sensor_conf->trip_data.trip_val[0];
>
> Why are we checking only against the 0-th trip point ?
> Why not for other trip_val[i] also ?
Yes correct. Actually the trip temperatures are arranged in ascending order.
>
>> +
>> + =A0 =A0 thermal_zone_device_update(th_zone->therm_dev);
>> +
>> + =A0 =A0 mutex_lock(&th_zone->therm_dev->lock);
>> + =A0 =A0 if (th_zone->therm_dev->last_temperature > monitor_temp)
>> + =A0 =A0 =A0 =A0 =A0 =A0 th_zone->therm_dev->polling_delay =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 th_zone->active_interval*1000;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 th_zone->therm_dev->polling_delay =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 th_zone->idle_interval*1000;
>> +
>> + =A0 =A0 kobject_uevent(&th_zone->therm_dev->device.kobj, KOBJ_CHANGE);
>
> Wouldn't it make more sense to pass the trip point id also as an 'env'
> parameter ? This way, the user space can easily figure out which trip
> point has been crossed.
Its a good suggestion. I will check if some uevent property allows that.
>
>> + =A0 =A0 mutex_unlock(&th_zone->therm_dev->lock);
>> +}
>> +
>> +static int exynos4_get_trip_type(struct thermal_zone_device *thermal, i=
nt
>> trip,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum therma=
l_trip_type *type)
>> +{
>> + =A0 =A0 if (trip =3D=3D 0 || trip =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *type =3D THERMAL_TRIP_STATE_ACTIVE;
>> + =A0 =A0 else if (trip =3D=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *type =3D THERMAL_TRIP_CRITICAL;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int exynos4_get_trip_temp(struct thermal_zone_device *thermal, i=
nt
>> trip,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned lo=
ng *temp)
>> +{
>> + =A0 =A0 /*Monitor zone*/
>> + =A0 =A0 if (trip =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *temp =3D th_zone->sensor_conf->trip_data.trip=
_val[0];
>> + =A0 =A0 /*Warn zone*/
>> + =A0 =A0 else if (trip =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *temp =3D th_zone->sensor_conf->trip_data.trip=
_val[1];
>> + =A0 =A0 /*Panic zone*/
>> + =A0 =A0 else if (trip =3D=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *temp =3D th_zone->sensor_conf->trip_data.trip=
_val[2];
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 /*convert the temperature into millicelsius*/
>> + =A0 =A0 *temp =3D *temp * 1000;
>> +
>> + =A0 =A0 return 0;
>> +}
>
> This could be:
>
> if (trip < 0 || trip >2) return -EINVAL;
> *temp =3D th_zone->sensor_conf->trip_data.trip_val[trip];
> return 0;
Agreed. Will apply.
>
>> +
>> +static int exynos4_get_crit_temp(struct thermal_zone_device *thermal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned lo=
ng *temp)
>> +{
>> + =A0 =A0 /*Panic zone*/
>> + =A0 =A0 *temp =3D th_zone->sensor_conf->trip_data.trip_val[2];
>> + =A0 =A0 /*convert the temperature into millicelsius*/
>> + =A0 =A0 *temp =3D *temp * 1000;
>> + =A0 =A0 return 0;
>> +}
>
> Why not make it, exynos4_get_trip_temp(thermal, 2, temp) ?
OK.
>
>> +
>> +static int exynos4_bind(struct thermal_zone_device *thermal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct thermal_cooling_device =
*cdev)
>> +{
>> + =A0 =A0 /* if the cooling device is the one from exynos4 bind it */
>> + =A0 =A0 if (cdev !=3D th_zone->cool_dev[0])
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (thermal_zone_bind_cooling_device(thermal, 0, cdev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error binding cooling dev\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 if (thermal_zone_bind_cooling_device(thermal, 1, cdev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error binding cooling dev\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> If we fail here, do you want to remove the earlier 'binding' also ?
Yes. Missed this error handling.
>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +
>> +}
>> +
>> +static int exynos4_unbind(struct thermal_zone_device *thermal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct thermal_cooling_dev=
ice *cdev)
>> +{
>> + =A0 =A0 if (cdev !=3D th_zone->cool_dev[0])
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (thermal_zone_unbind_cooling_device(thermal, 0, cdev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error unbinding cooling dev\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> I think we should still go ahead and try to 'unbind' the other one.
Yes. Missed this error handling.
>
>> + =A0 =A0 }
>> + =A0 =A0 if (thermal_zone_unbind_cooling_device(thermal, 1, cdev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error unbinding cooling dev\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +
>> +}
>> +
>> +static int exynos4_get_temp(struct thermal_zone_device *thermal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long *=
temp)
>> +{
>> + =A0 =A0 void *data;
>> +
>> + =A0 =A0 if (!th_zone->sensor_conf) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("Temperature sensor not initialised\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 data =3D th_zone->sensor_conf->private_data;
>> + =A0 =A0 *temp =3D th_zone->sensor_conf->read_temperature(data);
>> + =A0 =A0 /*convert the temperature into millicelsius*/
>> + =A0 =A0 *temp =3D *temp * 1000;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/* bind callback functions to thermalzone */
>> +static struct thermal_zone_device_ops exynos4_dev_ops =3D {
>> + =A0 =A0 .bind =3D exynos4_bind,
>> + =A0 =A0 .unbind =3D exynos4_unbind,
>> + =A0 =A0 .get_temp =3D exynos4_get_temp,
>> + =A0 =A0 .get_mode =3D exynos4_get_mode,
>> + =A0 =A0 .set_mode =3D exynos4_set_mode,
>> + =A0 =A0 .get_trip_type =3D exynos4_get_trip_type,
>> + =A0 =A0 .get_trip_temp =3D exynos4_get_trip_temp,
>> + =A0 =A0 .get_crit_temp =3D exynos4_get_crit_temp,
>> +};
>> +
>> +int exynos4_register_thermal(struct thermal_sensor_conf *sensor_conf)
>> +{
>> + =A0 =A0 int ret, count, tab_size;
>> + =A0 =A0 struct freq_pctg_table *tab_ptr;
>> +
>> + =A0 =A0 if (!sensor_conf || !sensor_conf->read_temperature) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Temperature sensor not initialised\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 th_zone =3D kzalloc(sizeof(struct exynos4_thermal_zone), GFP_K=
ERNEL);
>> + =A0 =A0 if (!th_zone) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_unregister;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 th_zone->sensor_conf =3D sensor_conf;
>> +
>> + =A0 =A0 tab_ptr =3D (struct freq_pctg_table *)sensor_conf->cooling_dat=
a.freq_data;
>> + =A0 =A0 tab_size =3D sensor_conf->cooling_data.freq_pctg_count;
>> +
>> + =A0 =A0 /*Register the cpufreq cooling device*/
>> + =A0 =A0 th_zone->cool_dev_size =3D 1;
>> + =A0 =A0 count =3D 0;
>> + =A0 =A0 th_zone->cool_dev[count] =3D cpufreq_cooling_register(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct freq_pctg_table *)&(ta=
b_ptr[count]),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tab_size, cpumask_of(0));
>> +
>> + =A0 =A0 if (IS_ERR(th_zone->cool_dev[count])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed to register cpufreq cooling dev=
ice\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 th_zone->cool_dev_size =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_unregister;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 th_zone->therm_dev =3D thermal_zone_device_register(sensor_con=
f->name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3, NULL, &exyn=
os4_dev_ops, 0, 0, 0, 1000);
>> + =A0 =A0 if (IS_ERR(th_zone->therm_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed to register thermal zone device=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_unregister;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 th_zone->active_interval =3D 1;
>> + =A0 =A0 th_zone->idle_interval =3D 10;
>> +
>> + =A0 =A0 exynos4_set_mode(th_zone->therm_dev, THERMAL_DEVICE_DISABLED);
>> +
>> + =A0 =A0 pr_info("Exynos: Kernel Thermal management registered\n");
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_unregister:
>> + =A0 =A0 exynos4_unregister_thermal();
>> + =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL(exynos4_register_thermal);
>> +
>> +void exynos4_unregister_thermal(void)
>> +{
>> + =A0 =A0 unsigned int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < th_zone->cool_dev_size; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (th_zone && th_zone->cool_dev[i])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_cooling_unregister(th_=
zone->cool_dev[i]);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (th_zone && th_zone->therm_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 thermal_zone_device_unregister(th_zone->therm_=
dev);
>> +
>> + =A0 =A0 kfree(th_zone);
>> +
>> + =A0 =A0 pr_info("Exynos: Kernel Thermal management unregistered\n");
>> +}
>> +EXPORT_SYMBOL(exynos4_unregister_thermal);
>> diff --git a/include/linux/exynos_thermal.h b/include/linux/exynos_therm=
al.h
>> new file mode 100644
>> index 0000000..186e409
>> --- /dev/null
>> +++ b/include/linux/exynos_thermal.h
>> @@ -0,0 +1,72 @@
>> +/* linux/include/linux/exynos_thermal.h
>> + *
>> + * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
>> + * =A0 =A0 =A0 =A0 =A0 http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef THERMAL_INTERFACE_H
>> +#define THERMAL_INTERFACE_H
>> +/* CPU Zone information */
>> +
>> +#define SENSOR_NAME_LEN =A0 =A0 =A016
>> +#define MAX_TRIP_COUNT =A0 =A0 =A0 8
>> +
>> +#define PANIC_ZONE =A0 =A0 =A04
>> +#define WARN_ZONE =A0 =A0 =A0 3
>> +#define MONITOR_ZONE =A0 =A02
>> +#define SAFE_ZONE =A0 =A0 =A0 1
>> +#define NO_ACTION =A0 =A0 =A0 0
>
> I don't get why we need two separate SAFE and NO_ACTION
> zones..To me, both should be the same.
Yes not needed.
>
>> +
>> +
>> +struct =A0 =A0 =A0 thermal_trip_point_conf {
>> + =A0 =A0 int trip_val[MAX_TRIP_COUNT];
>> + =A0 =A0 int trip_count;
>> +};
>> +
>> +struct =A0 =A0 =A0 thermal_cooling_conf {
>> + =A0 =A0 struct freq_pctg_table freq_data[MAX_TRIP_COUNT];
>> + =A0 =A0 int freq_pctg_count;
>> +};
>> +
>> +/**
>> + * struct exynos4_tmu_platform_data
>> + * @name: name of the temperature sensor
>> + * @read_temperature: A function pointer to read temperature info
>> + * @private_data: Temperature sensor private data
>> + * @sensor_data: Sensor specific information like trigger temperature, =
level
>> + */
>> +struct thermal_sensor_conf {
>> + =A0 =A0 char =A0 =A0name[SENSOR_NAME_LEN];
>> + =A0 =A0 int =A0 =A0 (*read_temperature)(void *data);
>> + =A0 =A0 struct =A0thermal_trip_point_conf trip_data;
>> + =A0 =A0 struct =A0thermal_cooling_conf cooling_data;
>
> Since both trip_count and freq_pctg_count are same at all
> times (please correct me if I am wrong) I think it's better
> to have a single 'count' variable inside this structure and move
> trip_val and freq_data to this structure directly.
No trip_count and pctg_count are different.
>
> One General Concern:
> Why do we even need this exynos_thermal layer between Thermal Framework
> and the Thermal Sensor Drivers ? I think the thermal sensor driver (in
> this case exynos_tmu.c) can directly register with the Thermal framework.
> This means, we will soon have platformXXX_thermal.c files for each
> platform, which is not really a good way to go IMHO.
> I also understand that the framework does not have alarm attributes,
> notification support etc..But We can add them if needed.
Yes even comments from Guenter Roeck and Mark Brown also point in the
same direction. Actually I wanted to separate the sensor h/w
implementation independent from thermal management algorithm so its
future modification may be clean. But looks like the agreement is to
merge them.
>
> I have reviewed your two sets of patches independently. My only
> request to you would be to post the next versions of both the patch
> sets at the same time, so that it becomes easier to understand and test.
Thanks even i also think this a good way.
>
> Thanks,
> Durga
>
>> + =A0 =A0 void =A0 =A0*private_data;
>> +};
>> +
>> +/**
>> + * exynos4_register_thermal: Register to the exynos thermal interface.
>> + * @sensor_conf: =A0 Structure containing temperature sensor information
>> + *
>> + * returns zero on success, else negative errno.
>> + */
>> +int exynos4_register_thermal(struct thermal_sensor_conf *sensor_conf);
>> +
>> +/**
>> + * exynos4_unregister_thermal: Un-register from the exynos thermal inte=
rface.
>> + *
>> + * return not applicable.
>> + */
>> +void exynos4_unregister_thermal(void);
>> +
>> +/**
>> + * exynos4_report_trigger: Report any trigger level crossed in the
>> + * =A0 temperature sensor. This may be useful to take any cooling actio=
n.
>> + *
>> + * return not applicable.
>> + */
>> +extern void exynos4_report_trigger(void);
>> +#endif
>> --
>> 1.7.1
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
