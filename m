From: Felipe Balbi <balbi@ti.com>
Date: Thu, 11 Aug 2011 10:30:06 +0000
Subject: Re: [lm-sensors] [RFC PATCH 4/6] OMAP4: Temperature sensor device
Message-Id: <20110811103006.GF27742@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5586970934641413728=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-5-git-send-email-j-keerthy@ti.com>
 <20110810123647.GF12882@legolas.emea.dhcp.ti.com>
 <CAJ6a13b=Pv6i=Z53y2qLNhUNY-A3S395+9H+xg2ssGC_ZcLZyA@mail.gmail.com>
In-Reply-To: <CAJ6a13b=Pv6i=Z53y2qLNhUNY-A3S395+9H+xg2ssGC_ZcLZyA@mail.gmail.com>
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: balbi@ti.com, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com


--===============5586970934641413728==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 11, 2011 at 08:10:07AM +0530, J, KEERTHY wrote:
> >> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> >> index 6e6735f..8fd8e80 100644
> >> --- a/arch/arm/plat-omap/Kconfig
> >> +++ b/arch/arm/plat-omap/Kconfig
> >> @@ -115,6 +115,18 @@ config OMAP_MCBSP
> >> =A0 =A0 =A0 =A0 Say Y here if you want support for the OMAP Multichann=
el
> >> =A0 =A0 =A0 =A0 Buffered Serial Port.
> >>
> >> +config OMAP_TEMP_SENSOR
> >> + =A0 =A0 bool "OMAP Temp Sensor Support"
> >> + =A0 =A0 depends on ARCH_OMAP
> >> + =A0 =A0 default n
> >> + =A0 =A0 help
> >> + =A0 =A0 =A0 Say Y here if you want support for the temp sensor
> >> + =A0 =A0 =A0 on OMAP4460.
> >> +
> >> + =A0 =A0 =A0 This provides the temperature of the MPU
> >> + =A0 =A0 =A0 subsystem. Only one instance of on die temperature
> >> + =A0 =A0 =A0 sensor is present.
> >
> > if there's only one instance, why do you use
> > omap_hwmod_for_each_by_class() ??
>=20
> In case of OMAP5 there are multiple instances. Hence using
> omap_hwmod_for_each_by_class().

that's not a reality yet, so why don't you leave it for when OMAP5 is
around ?

> >> diff --git a/arch/arm/plat-omap/include/plat/temperature_sensor.h b/ar=
ch/arm/plat-omap/include/plat/temperature_sensor.h
> >> new file mode 100644
> >> index 0000000..692ebdc
> >> --- /dev/null
> >> +++ b/arch/arm/plat-omap/include/plat/temperature_sensor.h
> >> @@ -0,0 +1,87 @@
> >> +/*
> >> + * OMAP Temperature sensor header file
> >> + *
> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.=
com/
> >> + * Author: J Keerthy <j-keerthy@ti.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public License
> >> + * version 2 as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful, but
> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU
> >> + * General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, write to the Free Software
> >> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> >> + * 02110-1301 USA
> >> + *
> >> + */
> >> +
> >> +#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
> >> +#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
> >> +
> >> +/* Offsets from the base of temperature sensor registers */
> >> +
> >> +#define OMAP4460_TEMP_SENSOR_CTRL_OFFSET =A0 =A0 0x00
> >> +#define OMAP4460_BGAP_CTRL_OFFSET =A0 =A0 =A0 =A0 =A0 =A00x4c
> >> +#define OMAP4460_BGAP_COUNTER_OFFSET =A0 =A0 =A0 =A0 0x50
> >> +#define OMAP4460_BGAP_THRESHOLD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x=
54
> >> +#define OMAP4460_BGAP_TSHUT_OFFSET =A0 =A0 =A0 =A0 =A0 0x58
> >> +#define OMAP4460_BGAP_STATUS_OFFSET =A0 =A0 =A0 =A0 =A00x5c
> >> +#define OMAP4460_FUSE_OPP_BGAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 -0xcc
> >> +
> >> +struct omap_temp_sensor_registers {
> >> + =A0 =A0 u32 =A0 =A0 temp_sensor_ctrl;
> >> + =A0 =A0 u32 =A0 =A0 bgap_tempsoff_mask;
> >> + =A0 =A0 u32 =A0 =A0 bgap_soc_mask;
> >> + =A0 =A0 u32 =A0 =A0 bgap_eocz_mask;
> >> + =A0 =A0 u32 =A0 =A0 bgap_dtemp_mask;
> >> +
> >> + =A0 =A0 u32 =A0 =A0 bgap_mask_ctrl;
> >> + =A0 =A0 u32 =A0 =A0 mask_hot_mask;
> >> + =A0 =A0 u32 =A0 =A0 mask_cold_mask;
> >> +
> >> + =A0 =A0 u32 =A0 =A0 bgap_mode_ctrl;
> >> + =A0 =A0 u32 =A0 =A0 mode_ctrl_mask;
> >> +
> >> + =A0 =A0 u32 =A0 =A0 bgap_counter;
> >> + =A0 =A0 u32 =A0 =A0 counter_mask;
> >> +
> >> + =A0 =A0 u32 =A0 =A0 bgap_threshold;
> >> + =A0 =A0 u32 =A0 =A0 threshold_thot_mask;
> >> + =A0 =A0 u32 =A0 =A0 threshold_tcold_mask;
> >> +
> >> + =A0 =A0 u32 =A0 =A0 thsut_threshold;
> >> + =A0 =A0 u32 =A0 =A0 tshut_hot_mask;
> >> + =A0 =A0 u32 =A0 =A0 tshut_cold_mask;
> >> +
> >> + =A0 =A0 u32 =A0 =A0 bgap_status;
> >> + =A0 =A0 u32 =A0 =A0 status_clean_stop_mask;
> >> + =A0 =A0 u32 =A0 =A0 status_bgap_alert_mask;
> >> + =A0 =A0 u32 =A0 =A0 status_hot_mask;
> >> + =A0 =A0 u32 =A0 =A0 status_cold_mask;
> >> +
> >> + =A0 =A0 u32 =A0 =A0 bgap_efuse;
> >> +};
> >
> > I find it unnecessary to pass the register map to driver using
> > platform_data.
>=20
> With multiple instances the register map to individual instances will cha=
nge.
> So passing it via platform_data.

what will change is the base address, the offsets should remain the
same.

--=20
balbi

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQ68tAAoJEAv8Txj19kN1+q0IAKS96sAifZHcydQuh3BKnXsO
4QUkimO66PVZ3FgTj9+DgqzuczcvmeaCXw6wk8Op1uvRQXF+diA0T5FSOwCJy78N
AoBZVCFti2/QCVLDfgJUS/FQqdIb8JmSC5eng8mWMgkQ+a1PmI/7TJzSGP+ICabd
uqn62r0FXazryq0o4PZMFx83ArULRapum7f03dE5Uyv78AlHrxV1PzZGFVveCfnj
Zxd2jXzlRkdtXpHqWg/oytp9NWLKG0y4GsPRKEglUzF5pROKUNeWmQE58bIIxJxb
6ACDcycDC6lpigETL9L925TiQZKQkCnfS5SwwPKVHJgoi1l8kmjKRtqhebOPlL4=
=bBWz
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--


--===============5586970934641413728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5586970934641413728==--
