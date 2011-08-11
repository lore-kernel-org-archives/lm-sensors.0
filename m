From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Thu, 11 Aug 2011 14:27:20 +0000
Subject: Re: [lm-sensors] [RFC PATCH 4/6] OMAP4: Temperature sensor device
Message-Id: <CAJ6a13b=iQ+jK5PfWhvMi28EyuPo-dODtMs32=r30OvQd1LBsw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-5-git-send-email-j-keerthy@ti.com>
	<20110810123647.GF12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13b=Pv6i=Z53y2qLNhUNY-A3S395+9H+xg2ssGC_ZcLZyA@mail.gmail.com>
	<20110811103006.GF27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13ZeVacnvksrtN1zZSP3rRYz=_YAR4-XJkdo0yg1us-e+A@mail.gmail.com>
	<20110811140541.GJ28500@legolas.emea.dhcp.ti.com>
In-Reply-To: <20110811140541.GJ28500@legolas.emea.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: balbi@ti.com
Cc: lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com

On Thu, Aug 11, 2011 at 7:35 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Aug 11, 2011 at 04:31:50PM +0530, J, KEERTHY wrote:
>> On Thu, Aug 11, 2011 at 4:00 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > Hi,
>> >
>> > On Thu, Aug 11, 2011 at 08:10:07AM +0530, J, KEERTHY wrote:
>> >> >> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconf=
ig
>> >> >> index 6e6735f..8fd8e80 100644
>> >> >> --- a/arch/arm/plat-omap/Kconfig
>> >> >> +++ b/arch/arm/plat-omap/Kconfig
>> >> >> @@ -115,6 +115,18 @@ config OMAP_MCBSP
>> >> >> =A0 =A0 =A0 =A0 Say Y here if you want support for the OMAP Multic=
hannel
>> >> >> =A0 =A0 =A0 =A0 Buffered Serial Port.
>> >> >>
>> >> >> +config OMAP_TEMP_SENSOR
>> >> >> + =A0 =A0 bool "OMAP Temp Sensor Support"
>> >> >> + =A0 =A0 depends on ARCH_OMAP
>> >> >> + =A0 =A0 default n
>> >> >> + =A0 =A0 help
>> >> >> + =A0 =A0 =A0 Say Y here if you want support for the temp sensor
>> >> >> + =A0 =A0 =A0 on OMAP4460.
>> >> >> +
>> >> >> + =A0 =A0 =A0 This provides the temperature of the MPU
>> >> >> + =A0 =A0 =A0 subsystem. Only one instance of on die temperature
>> >> >> + =A0 =A0 =A0 sensor is present.
>> >> >
>> >> > if there's only one instance, why do you use
>> >> > omap_hwmod_for_each_by_class() ??
>> >>
>> >> In case of OMAP5 there are multiple instances. Hence using
>> >> omap_hwmod_for_each_by_class().
>> >
>> > that's not a reality yet, so why don't you leave it for when OMAP5 is
>> > around ?
>>
>> Keeping it generic so that we need not change again. We are pretty
>> close to reality i guess. Why not keep it generic? Any specific reason
>> for not keeping this loop?
>
> Other than the loop being completely unnecessary on the only OMAP
> version you're supporting ? no... not really.
>
>> >> >> diff --git a/arch/arm/plat-omap/include/plat/temperature_sensor.h =
b/arch/arm/plat-omap/include/plat/temperature_sensor.h
>> >> >> new file mode 100644
>> >> >> index 0000000..692ebdc
>> >> >> --- /dev/null
>> >> >> +++ b/arch/arm/plat-omap/include/plat/temperature_sensor.h
>> >> >> @@ -0,0 +1,87 @@
>> >> >> +/*
>> >> >> + * OMAP Temperature sensor header file
>> >> >> + *
>> >> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www=
.ti.com/
>> >> >> + * Author: J Keerthy <j-keerthy@ti.com>
>> >> >> + *
>> >> >> + * This program is free software; you can redistribute it and/or
>> >> >> + * modify it under the terms of the GNU General Public License
>> >> >> + * version 2 as published by the Free Software Foundation.
>> >> >> + *
>> >> >> + * This program is distributed in the hope that it will be useful=
, but
>> >> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See th=
e GNU
>> >> >> + * General Public License for more details.
>> >> >> + *
>> >> >> + * You should have received a copy of the GNU General Public Lice=
nse
>> >> >> + * along with this program; if not, write to the Free Software
>> >> >> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> >> >> + * 02110-1301 USA
>> >> >> + *
>> >> >> + */
>> >> >> +
>> >> >> +#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
>> >> >> +#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
>> >> >> +
>> >> >> +/* Offsets from the base of temperature sensor registers */
>> >> >> +
>> >> >> +#define OMAP4460_TEMP_SENSOR_CTRL_OFFSET =A0 =A0 0x00
>> >> >> +#define OMAP4460_BGAP_CTRL_OFFSET =A0 =A0 =A0 =A0 =A0 =A00x4c
>> >> >> +#define OMAP4460_BGAP_COUNTER_OFFSET =A0 =A0 =A0 =A0 0x50
>> >> >> +#define OMAP4460_BGAP_THRESHOLD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0x54
>> >> >> +#define OMAP4460_BGAP_TSHUT_OFFSET =A0 =A0 =A0 =A0 =A0 0x58
>> >> >> +#define OMAP4460_BGAP_STATUS_OFFSET =A0 =A0 =A0 =A0 =A00x5c
>> >> >> +#define OMAP4460_FUSE_OPP_BGAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 -0xcc
>> >> >> +
>> >> >> +struct omap_temp_sensor_registers {
>> >> >> + =A0 =A0 u32 =A0 =A0 temp_sensor_ctrl;
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_tempsoff_mask;
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_soc_mask;
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_eocz_mask;
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_dtemp_mask;
>> >> >> +
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_mask_ctrl;
>> >> >> + =A0 =A0 u32 =A0 =A0 mask_hot_mask;
>> >> >> + =A0 =A0 u32 =A0 =A0 mask_cold_mask;
>> >> >> +
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_mode_ctrl;
>> >> >> + =A0 =A0 u32 =A0 =A0 mode_ctrl_mask;
>> >> >> +
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_counter;
>> >> >> + =A0 =A0 u32 =A0 =A0 counter_mask;
>> >> >> +
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_threshold;
>> >> >> + =A0 =A0 u32 =A0 =A0 threshold_thot_mask;
>> >> >> + =A0 =A0 u32 =A0 =A0 threshold_tcold_mask;
>> >> >> +
>> >> >> + =A0 =A0 u32 =A0 =A0 thsut_threshold;
>> >> >> + =A0 =A0 u32 =A0 =A0 tshut_hot_mask;
>> >> >> + =A0 =A0 u32 =A0 =A0 tshut_cold_mask;
>> >> >> +
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_status;
>> >> >> + =A0 =A0 u32 =A0 =A0 status_clean_stop_mask;
>> >> >> + =A0 =A0 u32 =A0 =A0 status_bgap_alert_mask;
>> >> >> + =A0 =A0 u32 =A0 =A0 status_hot_mask;
>> >> >> + =A0 =A0 u32 =A0 =A0 status_cold_mask;
>> >> >> +
>> >> >> + =A0 =A0 u32 =A0 =A0 bgap_efuse;
>> >> >> +};
>> >> >
>> >> > I find it unnecessary to pass the register map to driver using
>> >> > platform_data.
>> >>
>> >> With multiple instances the register map to individual instances will=
 change.
>> >> So passing it via platform_data.
>> >
>> > what will change is the base address, the offsets should remain the
>> > same.
>>
>> The base address offsets and even bit fields seem to be differing across
>> different OMAP versions.
>
> then a comment making that clear is necessary. But as of today, you
> support only one OMAP version, so I'm sure it's worth the trouble for a
> first version of the driver.

I will add a comment.

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
