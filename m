From: "Cousson, Benoit" <b-cousson@ti.com>
Date: Wed, 10 Aug 2011 14:17:05 +0000
Subject: Re: [lm-sensors] [RFC PATCH 4/6] OMAP4: Temperature sensor device
Message-Id: <4E4292E1.2070504@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com> <1312979122-5896-5-git-send-email-j-keerthy@ti.com> <20110810123647.GF12882@legolas.emea.dhcp.ti.com> <20110810124102.GM1939@atomide.com> <20110810124800.GK12882@legolas.emea.dhcp.ti.com>
In-Reply-To: <20110810124800.GK12882@legolas.emea.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "J, KEERTHY" <j-keerthy@ti.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

On 8/10/2011 2:48 PM, Balbi, Felipe wrote:
> Hi,
>
> On Wed, Aug 10, 2011 at 05:41:02AM -0700, Tony Lindgren wrote:
>> * Felipe Balbi<balbi@ti.com>  [110810 05:31]:
>>>
>>> On Wed, Aug 10, 2011 at 05:55:20PM +0530, Keerthy wrote:
>>>> +
>>>> +int __init omap_devinit_temp_sensor(void)
>>>> +{
>>>> +	if (!cpu_is_omap446x())
>>>> +		return 0;
>>>> +
>>>> +	return omap_hwmod_for_each_by_class("temperature_sensor",
>>>> +			temp_sensor_dev_init, NULL);
>>>> +}
>>>> +
>>>> +arch_initcall(omap_devinit_temp_sensor);
>>>
>>> I really dislike people adding more and more *initcall() to their pieces
>>> of code. But Tony is the final Judge.
>>
>> Yes how about making this just a regular device driver and have it
>> live under drivers/ somewhere?
>>
>> Or is there some reason why this could not be a loadable module?
>
> driver is loadable, this is just creating the platform_device, but still
> I don't think it deserves its own arch_initcall(), it could very well be
> something which is called after we know we're running at omap4, or
> called by each board...

Funny, because I thought we were trying to get rid of the ugly init 
devices from board file to use *initcall() from a dedicated device file.
The advantage is that you do not have anymore a central place that 
everybody will change and that is thus subject to merge conflicts.

The drawback is that you do not know where an when the devices are created.

That being said, device-tree will provide a nice way to build all this 
devices without any initcall or board hacks.
This is just a temporary issue :-)

Benoit

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
