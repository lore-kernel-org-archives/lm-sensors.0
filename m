From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 08 Mar 2014 15:59:08 +0000
Subject: Re: [lm-sensors] 3.13.?: Strange / dangerous fan policy...
Message-Id: <531B3E4C.2040105@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <531A1EEE.9090101@netscape.net>	<20140307205506.GA6870@roeck-us.net>	<531A426D.6080100@netscape.net>	<20140307225230.GA31135@roeck-us.net> <20140308120831.328e0179@endymion.delvare>
In-Reply-To: <20140308120831.328e0179@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <jdelvare@suse.de>, Manuel Krause <manuelkrause@netscape.net>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 03/08/2014 03:08 AM, Jean Delvare wrote:
> On Fri, 7 Mar 2014 14:52:30 -0800, Guenter Roeck wrote:
>> On Fri, Mar 07, 2014 at 11:04:29PM +0100, Manuel Krause wrote:
>>> Hi, and thanks for the quick response!
>>> No special fancy "fan control policy". 'fancontrol' isn't up or
>>> running.
>>> Vanilla kernels 3.11.* and 3.12.* had been working on here without
>>> any extra work.
>>> --
>>> # sensors
>>> acpitz-virtual-0
>>> Adapter: Virtual device
>>> temp1:        +71.0=B0C  (crit =3D +256.0=B0C)
>>> temp2:        +69.0=B0C  (crit =3D +110.0=B0C)
>>> temp3:        +52.0=B0C  (crit =3D +105.0=B0C)
>>> temp4:        +25.0=B0C  (crit =3D +110.0=B0C)
>>> temp5:        +58.0=B0C  (crit =3D +110.0=B0C)
>>>
>>> coretemp-isa-0000
>>> Adapter: ISA adapter
>>> Core 0:       +62.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>>> Core 1:       +60.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>>> --
>>> My notebook (HP/Compaq 6730b) does not have a seperate fan sensor.
>>> This is with 3.12.13 with my normal workload.
>>>
>>> Please, trust my above mentionned values of 94 =B0C vs. 74=B0C as I
>>> don't like to boot 3.13.6 anymore, to avoid harm to the notebook's
>>> casing.
>>
>> Understood. Unfortunately, we'll need to get information
>> from the new kernel to be able to track down the problem.
>
> Indeed. Not only the run-time temperatures, but also the high and crit
> limits.
>
>>> But I'd do to test any improvement-patch.
>>
>> So far I have no idea what is going on. I don't see anything in the
>> drivers providing above data that would explain the behavior,
>> but I might be missing something.
>
> Looks like a regression in the acpi subsystem or in power management,
> not hwmon. Hwmon is merely reporting the temperatures, it's not
> responsible for the actual temperatures.
>

I would agree. I don't think we have enough information to be sure,
though. There might be some unintended interaction or interference.

gpu is a good hint ... for example, look at commit b9ed919f1c8
(drm/nouveau/drm/pm: remove everything except the hwmon interfaces
to THERM). nouveau does export pwm and fan control information,
so any change in that code may have unintended side effects.
Similar, I don't know how ec39f64bba (drm/radeon/dpm: Convert to
use devm_hwmon_register_with_groups) could have the observed impact,
as it is purely passive, but I prefer to be rather safe than sorry.

This problem has now been submitted into bugzilla as
https://bugzilla.kernel.org/show_bug.cgi?id=3D71711.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
