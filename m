From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Thu, 11 Aug 2011 02:52:07 +0000
Subject: Re: [lm-sensors] [RFC PATCH 4/6] OMAP4: Temperature sensor device
Message-Id: <CAJ6a13b=Pv6i=Z53y2qLNhUNY-A3S395+9H+xg2ssGC_ZcLZyA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-5-git-send-email-j-keerthy@ti.com>
	<20110810123647.GF12882@legolas.emea.dhcp.ti.com>
In-Reply-To: <20110810123647.GF12882@legolas.emea.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: balbi@ti.com
Cc: lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com

On Wed, Aug 10, 2011 at 6:06 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> (you should Cc Tony, as he's OMAP maintainer)
>
> On Wed, Aug 10, 2011 at 05:55:20PM +0530, Keerthy wrote:
>> The device file adds the device support for OMAP4
>> on die temperature sensor.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A03 +-
>> =A0arch/arm/mach-omap2/temp_sensor_device.c =A0 =A0 =A0 =A0 =A0 | =A0 85=
 +++++++++++++++++++
>> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 12 +++
>> =A0.../plat-omap/include/plat/temperature_sensor.h =A0 =A0| =A0 87 +++++=
+++++++++++++++
>> =A04 files changed, 186 insertions(+), 1 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/temp_sensor_device.c
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/temperature_sensor=
.h
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>> index fb02937..5812fb4 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_ARCH_OMAP4) +=3D prm44xx.o $(hwmod-common)
>>
>> =A0obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
>>
>> +obj-$(CONFIG_OMAP_TEMP_SENSOR) =A0 =A0 =A0 =A0 =A0+=3D temp_sensor_devi=
ce.o
>> =A0obj-$(CONFIG_TWL4030_CORE) +=3D omap_twl.o
>>
>> =A0# SMP support ONLY available for OMAP4
>> @@ -86,7 +87,7 @@ obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0+=3D p=
rcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
>> =A0obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 +=3D prcm.o cm2xxx_3=
xxx.o cminst44xx.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0cm44xx.o prcm_mpu44xx.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0prminst44xx.o vc44xx_data.o \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0vp44xx_data.o
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0vp44xx_data.o temp_sensor4460_data.o
>>
>> =A0# OMAP voltage domains
>> =A0ifeq ($(CONFIG_PM),y)
>> diff --git a/arch/arm/mach-omap2/temp_sensor_device.c b/arch/arm/mach-om=
ap2/temp_sensor_device.c
>> new file mode 100644
>> index 0000000..5d5e92f
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/temp_sensor_device.c
>> @@ -0,0 +1,85 @@
>> +/*
>> + * OMAP on die Temperature sensor device file
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.co=
m/
>> + * Author: J Keerthy <j-keerthy@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/slab.h>
>> +#include <linux/io.h>
>> +#include <linux/pm_runtime.h>
>> +#include <plat/omap_device.h>
>> +#include "control.h"
>> +#include "pm.h"
>> +#include <plat/temperature_sensor.h>
>> +
>> +static struct omap_device_pm_latency omap_temp_sensor_latency[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0.deactivate_func =3D omap_device_idle_hwmods,
>> + =A0 =A0 =A0.activate_func =3D omap_device_enable_hwmods,
>> + =A0 =A0 =A0.flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,
>> + =A0 =A0 }
>
> wrong indentation.
>

Ok. I will correct this.

>> +};
>> +
>> +static int temp_sensor_dev_init(struct omap_hwmod *oh, void *user)
>> +{
>> + =A0 =A0 struct =A0omap_temp_sensor_pdata =A0 =A0 =A0 =A0 =A0*temp_sens=
or_pdata;
>> + =A0 =A0 struct =A0omap_device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
*od;
>> + =A0 =A0 struct =A0omap_temp_sensor_dev_attr =A0 =A0 =A0 *temp_sensor_d=
ev_attr;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 ret;
>> + =A0 =A0 static int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0device_count;
>
> use an IDR here (see include/linux/idr.h)

Ok. I will check this.

>
>> + =A0 =A0 ret =3D 0;
>
> initialize on the declarion and you can avoid this line.

Ok

>
>> + =A0 =A0 temp_sensor_pdata >> + =A0 =A0 =A0 =A0 kzalloc(sizeof(*temp_se=
nsor_pdata), GFP_KERNEL);
>> + =A0 =A0 if (!temp_sensor_pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&oh->od->pdev.dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to allocate memory for=
 temp sensor pdata\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor_dev_attr =3D oh->dev_attr;
>> + =A0 =A0 if (!strcmp(temp_sensor_dev_attr->name, "mpu"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_pdata->registers =3D &omap_mpu_tem=
p_sensor_registers;
>> +
>> + =A0 =A0 od =3D omap_device_build("omap_temp_sensor", device_count++,
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh, temp_sensor_pdata, sizeof(*temp_sensor_pda=
ta),
>> + =A0 =A0 =A0 =A0 =A0 =A0omap_temp_sensor_latency,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap_temp_sensor_la=
tency), 0);
>> + =A0 =A0 if (IS_ERR(od)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&oh->od->pdev.dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Could not build omap_device f=
or %s\n", oh->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(od);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 kfree(temp_sensor_pdata);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +int __init omap_devinit_temp_sensor(void)
>> +{
>> + =A0 =A0 if (!cpu_is_omap446x())
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 return omap_hwmod_for_each_by_class("temperature_sensor",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_dev_init, NULL);
>> +}
>> +
>> +arch_initcall(omap_devinit_temp_sensor);
>
> I really dislike people adding more and more *initcall() to their pieces
> of code. But Tony is the final Judge.
>
>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
>> index 6e6735f..8fd8e80 100644
>> --- a/arch/arm/plat-omap/Kconfig
>> +++ b/arch/arm/plat-omap/Kconfig
>> @@ -115,6 +115,18 @@ config OMAP_MCBSP
>> =A0 =A0 =A0 =A0 Say Y here if you want support for the OMAP Multichannel
>> =A0 =A0 =A0 =A0 Buffered Serial Port.
>>
>> +config OMAP_TEMP_SENSOR
>> + =A0 =A0 bool "OMAP Temp Sensor Support"
>> + =A0 =A0 depends on ARCH_OMAP
>> + =A0 =A0 default n
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Say Y here if you want support for the temp sensor
>> + =A0 =A0 =A0 on OMAP4460.
>> +
>> + =A0 =A0 =A0 This provides the temperature of the MPU
>> + =A0 =A0 =A0 subsystem. Only one instance of on die temperature
>> + =A0 =A0 =A0 sensor is present.
>
> if there's only one instance, why do you use
> omap_hwmod_for_each_by_class() ??

In case of OMAP5 there are multiple instances. Hence using
omap_hwmod_for_each_by_class().

>
>> diff --git a/arch/arm/plat-omap/include/plat/temperature_sensor.h b/arch=
/arm/plat-omap/include/plat/temperature_sensor.h
>> new file mode 100644
>> index 0000000..692ebdc
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/temperature_sensor.h
>> @@ -0,0 +1,87 @@
>> +/*
>> + * OMAP Temperature sensor header file
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.co=
m/
>> + * Author: J Keerthy <j-keerthy@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
>> +#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
>> +
>> +/* Offsets from the base of temperature sensor registers */
>> +
>> +#define OMAP4460_TEMP_SENSOR_CTRL_OFFSET =A0 =A0 0x00
>> +#define OMAP4460_BGAP_CTRL_OFFSET =A0 =A0 =A0 =A0 =A0 =A00x4c
>> +#define OMAP4460_BGAP_COUNTER_OFFSET =A0 =A0 =A0 =A0 0x50
>> +#define OMAP4460_BGAP_THRESHOLD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x54
>> +#define OMAP4460_BGAP_TSHUT_OFFSET =A0 =A0 =A0 =A0 =A0 0x58
>> +#define OMAP4460_BGAP_STATUS_OFFSET =A0 =A0 =A0 =A0 =A00x5c
>> +#define OMAP4460_FUSE_OPP_BGAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 -0xcc
>> +
>> +struct omap_temp_sensor_registers {
>> + =A0 =A0 u32 =A0 =A0 temp_sensor_ctrl;
>> + =A0 =A0 u32 =A0 =A0 bgap_tempsoff_mask;
>> + =A0 =A0 u32 =A0 =A0 bgap_soc_mask;
>> + =A0 =A0 u32 =A0 =A0 bgap_eocz_mask;
>> + =A0 =A0 u32 =A0 =A0 bgap_dtemp_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_mask_ctrl;
>> + =A0 =A0 u32 =A0 =A0 mask_hot_mask;
>> + =A0 =A0 u32 =A0 =A0 mask_cold_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_mode_ctrl;
>> + =A0 =A0 u32 =A0 =A0 mode_ctrl_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_counter;
>> + =A0 =A0 u32 =A0 =A0 counter_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_threshold;
>> + =A0 =A0 u32 =A0 =A0 threshold_thot_mask;
>> + =A0 =A0 u32 =A0 =A0 threshold_tcold_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 thsut_threshold;
>> + =A0 =A0 u32 =A0 =A0 tshut_hot_mask;
>> + =A0 =A0 u32 =A0 =A0 tshut_cold_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_status;
>> + =A0 =A0 u32 =A0 =A0 status_clean_stop_mask;
>> + =A0 =A0 u32 =A0 =A0 status_bgap_alert_mask;
>> + =A0 =A0 u32 =A0 =A0 status_hot_mask;
>> + =A0 =A0 u32 =A0 =A0 status_cold_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_efuse;
>> +};
>
> I find it unnecessary to pass the register map to driver using
> platform_data.

With multiple instances the register map to individual instances will chang=
e.
So passing it via platform_data.

>
>> +/*
>> + * @name: Name of the domain of the temperature sensor
>> + */
>
> comment fits in one line.

Ok

>
>
> --
> balbi
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
