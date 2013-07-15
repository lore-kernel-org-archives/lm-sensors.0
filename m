From: Wei Ni <wni@nvidia.com>
Date: Mon, 15 Jul 2013 06:25:29 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (lm90) split set&show temp as common codes
Message-Id: <51E395D9.6070000@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com> <1373615287-18502-2-git-send-email-wni@nvidia.com> <20130712152615.23464a6b@endymion.delvare> <20130712135000.GA3386@roeck-us.net> <20130712163034.1fc1cd66@endymion.delvare> <20130712144011.GC3629@roeck-us.net>
In-Reply-To: <20130712144011.GC3629@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, rui.zhang@intel.com, Jean Delvare <khali@linux-fr.org>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 07/12/2013 10:40 PM, Guenter Roeck wrote:
> On Fri, Jul 12, 2013 at 04:30:34PM +0200, Jean Delvare wrote:
>> Hi Guenter,
>>
>> On Fri, 12 Jul 2013 06:50:00 -0700, Guenter Roeck wrote:
>>> On Fri, Jul 12, 2013 at 03:26:15PM +0200, Jean Delvare wrote:
>>>> One thing I am a little worried about (but maybe I'm wrong) is that I
>>>> seem to understand you want to register every LM90-like chip as both a
>>>> hwmon device and two thermal devices. I seem to recall that every
>>>> thermal device is also exposed automatically as a virtual hwmon
>>>> device, is that correct? If so we will be presenting the same values
>>>> twice to libsensors, which would be confusing.
>>>
>>> Not sure if that is a good idea, but if I recall correctly, the thermal folks
>>> plan to remove that path.

Hi, Rui
As Jean said, if we want to register the lm90 as thermal device, it will
have two hwmon devices in the sysfs, one is registered by the lm90
driver, another one is registered by the thermal_zone_device_register(),
this would be confusing.

Do you have any ideas for it?

Thanks.
Wei.

>>
>> If that means that for example the ACPI thermal zone is no longer
>> displayed by "sensors", then I strongly object - unless it is
>> explicitly registered as a separate hwmon device from now on, of course.
>>
> If I recall correctly that was the idea. Of course, in practice that will mean
> that devices will _not_ get exposed as hwmon devices, as implementers won't
> bother doing both.
> 
>> My idea was to make the bridge optional - you decide when you register
>> a thermal device if it should be exposed as hwmon or not.
>>
> Yes, that would be a much better solution.

I think we can decide it in the DT, we can add a dt property in the lm90
device node, such as:
sys-interface = SYS_HWMON;
or
sys-interface = SYS_THERMAL;
So we register it as the hwmon or thermal device

> 
>> I don't have a strong opinion on the implementation, as long as each
>> input is listed by "sensors" once and only once.
>>
> Agreed.
> 
> Guenter
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
