From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Fri, 12 Aug 2011 01:14:28 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13Zy3-iPoiVrzacSWizXwTRhp5+2Pt4JbGEzd6=448536g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
	<20110811141248.GK28500@legolas.emea.dhcp.ti.com>
	<CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
	<20110811185408.GB15970@legolas.emea.dhcp.ti.com>
	<20110811185558.GC15970@legolas.emea.dhcp.ti.com>
	<4E444B8F.9060908@ti.com>
In-Reply-To: <4E444B8F.9060908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com

On Fri, Aug 12, 2011 at 3:07 AM, Roger Quadros <rogerq@ti.com> wrote:
> On 08/11/2011 01:55 PM, Felipe Balbi wrote:
>> Hi,
>>
>> On Thu, Aug 11, 2011 at 09:54:09PM +0300, Felipe Balbi wrote:
>>>>> you need some other way to handle this. Why do you need to manually s=
et
>>>>> the rate rather than having hwmod handle this for you ?
>>>>>
>>>>> your argument that "it's a one time setting" is not enough to have th=
is
>>>>> in the driver. Drivers should not care about clocks anymore, this sho=
uld
>>>>> have been done on another layer.
>>>>
>>>> Hwmod will have no idea on the rate required.
>>>
>>> does the rate need to change ? Also, I have not mentioned hwmod anytime
>>
>> i did mention hwmod, nevermind that part. Still I'm not sure where is
>> the right place to handle this.
>>
>
> Aren't the omap_device_pm_latency callbacks the right place to do it?

It is a one time setting. These callbacks get called everytime
pm_runtime_get_sync and pm_runtime_put_sync are called.
IMHO this is not the right place.

>
> e.g. in the following snippet from mach-omap2/temp_sensor_device.c
>
> +static struct omap_device_pm_latency omap_temp_sensor_latency[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0.deactivate_func =3D omap_device_idle_hwmods,
> + =A0 =A0 =A0 =A0.activate_func =3D omap_device_enable_hwmods,
> + =A0 =A0 =A0 =A0.flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> + =A0 =A0 =A0 }
> +};
>
> instead of directly pointing activate_func to omap_device_enable_hwmods,
> it could point to a function that sets the required clock rate and then
> enables the hwmod.
>
>
> regards,
> -roger
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
