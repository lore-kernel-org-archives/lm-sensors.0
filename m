From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Wed, 10 Aug 2011 15:20:10 +0000
Subject: Re: [lm-sensors] [RFC PATCH 5/6] OMAP4460: Temperature sensor data
Message-Id: <CAJ6a13YD9KNDjCZbr2wL_0B_un0zxHo-s-dXb3TkHwUvgF+s_w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-6-git-send-email-j-keerthy@ti.com>
	<20110810123758.GH12882@legolas.emea.dhcp.ti.com>
In-Reply-To: <20110810123758.GH12882@legolas.emea.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: balbi@ti.com
Cc: vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, lm-sensors@lm-sensors.org

On Wed, Aug 10, 2011 at 6:07 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Aug 10, 2011 at 05:55:21PM +0530, Keerthy wrote:
>> The register set and the
>> bit fields might vary across OMAP versions. Hence
>> creating a structure comprising of all the registers
>> and bit fields to make the driver uniform for all the
>> versions with different register sets. The data file
>> contains the structure populated with register offsets
>> and bit fields corresponding to OMAP4460 on die sensor.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/temp_sensor4460_data.c | =A0 63 +++++++++++++++++=
+++++++++++
>> =A01 files changed, 63 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
>>
>> diff --git a/arch/arm/mach-omap2/temp_sensor4460_data.c b/arch/arm/mach-=
omap2/temp_sensor4460_data.c
>> new file mode 100644
>> index 0000000..294963d
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/temp_sensor4460_data.c
>> @@ -0,0 +1,63 @@
>> +/*
>> + * OMAP4460 on die Temperature sensor data file
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
>> +#include <linux/slab.h>
>> +#include "control.h"
>> +#include <plat/temperature_sensor.h>
>> +
>> +/*
>> + * OMAP4460 has one instance of thermal sensor for MPU
>> + * need to describe the individual bit fields
>> + */
>> +struct omap_temp_sensor_registers omap_mpu_temp_sensor_registers =3D {
>
> this is used on previous patch, so you have a compilation error.

I will reorder the patches.

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
