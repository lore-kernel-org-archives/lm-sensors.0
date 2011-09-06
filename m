From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Tue, 06 Sep 2011 11:52:08 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V4] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13ZbYpHNEpyPJ_pe73z5uEb70xZq4umb78Uxf0rtCZpxJw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-7-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1108311721460.26173@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.00.1108311721460.26173@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On Thu, Sep 1, 2011 at 5:26 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi,
>
> On Wed, 31 Aug 2011, Keerthy wrote:
>
>> On chip temperature sensor driver. The driver monitors the temperature of
>> the MPU subsystem of the OMAP4. It sends notifications to the user space=
 if
>> the temperature crosses user defined thresholds via kobject_uevent inter=
face.
>> The user is allowed to configure the temperature thresholds vis sysfs no=
des
>> exposed using hwmon interface.
>
> I commented in a separate post that this driver should probably use an MFD
> driver for the System Control Module accesses, and then this hwmon driver
> should use functions from that to access the BANDGAP temperature sensor
> registers[1].
>
> But I had another comment on this driver.
>
> A similar sensor is available on the OMAP34xx[2], OMAP36xx[3], and
> OMAP4430[4] chips. =A0There are some register layout differences; the
> thermal shutdown threshold is configurable on the 4460 but fixed on the
> 4430; and also I'd assume, without looking, that the temperature mapping
> table is different on different chips.
>
> So it would seem to make sense to move the chip-specific code and
> data into chip-specific source files.
>
> I could see keeping a generic filename like "omap_temp_sensor.c" if you
> implemented a common interface to the bandgap sensors, ADCs and
> comparators, across all those different chips. =A0That might be worth
> thinking about. =A0But at least, this should probably be named
> drivers/hwmon/omap4460_temp_sensor.c, or something similar.

The same driver can be used for OMAP5 too.
That has 3 instances of the same sensor. So omap4460+?

>
>
> - Paul
>
> 1. Walmsley, Paul. =A0_Re: [PATCH 4/6 V4] OMAP4: Hwmod: OMAP temperature
> =A0 sensor_. =A0Posted to the linux-omap@vger.kernel.org list on Wed, 31 =
Aug
> =A0 2011 17:16:44 -0600. =A0Available from (among others):
> =A0 http://marc.info/?l=3Dlinux-omap&m=131483260632685&w=3D2
>
> 2. Section 7.4.6 "Band Gap Voltage and Temperature Sensor". _OMAP34xx
> =A0 Multimedia Device Silicon Revision 3.1.x Version R (SWPU223R)_ (public
> =A0 version). =A0Available from
> =A0 http://focus.ti.com/pdfs/wtbu/OMAP34xx_ES3.1.x_PUBLIC_TRM_vZR.zip
>
> 3. Section 13.4.6 "Band Gap Voltage and Temperature Sensor". _OMAP36xx
> =A0 Multimedia Device Silicon Revision 1.x Version V (SWPU177V)_ (public
> =A0 version). =A0Available from
> =A0 http://focus.ti.com/pdfs/wtbu/OMAP36xx_ES1.x_PUBLIC_TRM_vV.zip
>
> 4. Section 18.4.10 "Band Gap Voltage and Temperature Sensor". _OMAP4430
> =A0 Multimedia Device Silicon Revision 2.x Version V (SWPU231V)_ (public
> =A0 version). =A0Available from
> =A0 http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vV.zip
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
