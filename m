From: Manuel Krause <manuelkrause@netscape.net>
Date: Mon, 10 Mar 2014 01:49:46 +0000
Subject: Re: [lm-sensors] 3.13.?: Strange / dangerous fan policy...
Message-Id: <531D1A3A.4040500@netscape.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <531A1EEE.9090101@netscape.net> <531B3E4C.2040105@roeck-us.net> <531BB171.1060208@netscape.net> <2833205.f1U4jaAo8e@vostro.rjw.lan>
In-Reply-To: <2833205.f1U4jaAo8e@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, rui.zhang@intel.com

On 2014-03-09 18:58, Rafael J. Wysocki wrote:
> On Sunday, March 09, 2014 01:10:25 AM Manuel Krause wrote:
>> On 2014-03-08 16:59, Guenter Roeck wrote:
>>> On 03/08/2014 03:08 AM, Jean Delvare wrote:
>>>> On Fri, 7 Mar 2014 14:52:30 -0800, Guenter Roeck wrote:
>>>>> On Fri, Mar 07, 2014 at 11:04:29PM +0100, Manuel Krause wrote:
>>>>>> Hi, and thanks for the quick response!
>>>>>> No special fancy "fan control policy". 'fancontrol' isn't up or
>>>>>> running.
>>>>>> Vanilla kernels 3.11.* and 3.12.* had been working on here
>>>>>> without
>>>>>> any extra work.
>>>>>> --
>>>>>> # sensors
>>>>>> acpitz-virtual-0
>>>>>> Adapter: Virtual device
>>>>>> temp1:        +71.0=B0C  (crit =3D +256.0=B0C)
>>>>>> temp2:        +69.0=B0C  (crit =3D +110.0=B0C)
>>>>>> temp3:        +52.0=B0C  (crit =3D +105.0=B0C)
>>>>>> temp4:        +25.0=B0C  (crit =3D +110.0=B0C)
>>>>>> temp5:        +58.0=B0C  (crit =3D +110.0=B0C)
>>>>>>
>>>>>> coretemp-isa-0000
>>>>>> Adapter: ISA adapter
>>>>>> Core 0:       +62.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>>>>>> Core 1:       +60.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>>>>>> --
>>>>>> My notebook (HP/Compaq 6730b) does not have a seperate fan
>>>>>> sensor.
>>>>>> This is with 3.12.13 with my normal workload.
>>>>>>
>>>>>> Please, trust my above mentionned values of 94 =B0C vs. 74=B0C as I
>>>>>> don't like to boot 3.13.6 anymore, to avoid harm to the
>>>>>> notebook's
>>>>>> casing.
>>>>>
>>>>> Understood. Unfortunately, we'll need to get information
>>>>> from the new kernel to be able to track down the problem.
>>>>
>>>> Indeed. Not only the run-time temperatures, but also the high
>>>> and crit
>>>> limits.
>>>>
>>>>>> But I'd do to test any improvement-patch.
>>>>>
>>>>> So far I have no idea what is going on. I don't see anything
>>>>> in the
>>>>> drivers providing above data that would explain the behavior,
>>>>> but I might be missing something.
>>>>
>>>> Looks like a regression in the acpi subsystem or in power
>>>> management,
>>>> not hwmon. Hwmon is merely reporting the temperatures, it's not
>>>> responsible for the actual temperatures.
>>>>
>>>
>>> I would agree. I don't think we have enough information to be sure,
>>> though. There might be some unintended interaction or interference.
>>>
>>> gpu is a good hint ... for example, look at commit b9ed919f1c8
>>> (drm/nouveau/drm/pm: remove everything except the hwmon interfaces
>>> to THERM). nouveau does export pwm and fan control information,
>>> so any change in that code may have unintended side effects.
>>> Similar, I don't know how ec39f64bba (drm/radeon/dpm: Convert to
>>> use devm_hwmon_register_with_groups) could have the observed impact,
>>> as it is purely passive, but I prefer to be rather safe than sorry.
>>>
>>> This problem has now been submitted into bugzilla as
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D71711.
>>>
>>> Guenter
>>>
>>
>> Sorry, for beeing late, had to search for/accumulate much info
>> for you...
>> I hope, you like me to put it into one answer to you all CCing you.
>>
>> My GFX is a GM45 Intel (mobile), shared memory, running the
>> opensource Mesa drivers/extensions.
>> kernel-module: i915
>>
>> According to the output of 'cpupower': I have
>> CPUidle driver: acpi_idle
>> CPUidle governor: menu
>>
>> CPUfreq:
>>     driver: acpi-cpufreq
>>     available cpufreq governors: ondemand, performance
>> -
>> And "ondemand" is running.
>> --
>>
>> # sensors
>> acpitz-virtual-0
>> Adapter: Virtual device
>> temp1:        +41.0=B0C  (crit =3D +256.0=B0C)
>> temp2:        +92.0=B0C  (crit =3D +110.0=B0C)
>> temp3:        +71.0=B0C  (crit =3D +105.0=B0C)
>> temp4:        +26.5=B0C  (crit =3D +110.0=B0C)
>> temp5:        +25.0=B0C  (crit =3D +110.0=B0C)
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:       +86.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>> Core 1:       +84.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>>
>> FROM a critical "smelly" situation today, kernel-compilation, fan
>> @100%.
>> --
>>
>> Additional findings:
>>
>> Identification from bootup ACPI initialisation vs. sensors:
>> temp1 =3D DTSZ
>> temp2 =3D CPUZ --> triggering Cooling in 3.12.13 if > 74=B0C
>> temp3 =3D SKNZ
>> temp4 =3D BATZ "Battery Zone" always calm ~ +6=B0C of ambient T
>> temp5 =3D FDTZ --- in 3.12.13 a representation of the cooling-fan
>> (25 - 45 - 58 - max?)
>> Core 0 & Core 1 are the internal CPU T sensors.
>>
>> With the 3.13.x (.5+) kernels the first gatherered cooling
>> settings from bootup do stay forever. Means, rebooting a hot
>> system will get a FDTZ @45=B0C+ and won't make any problems, as it
>> does cool enough (even for kernel compiling on here). If it gets
>> 25=B0C @bootup the system goes into emergency cooling somewhen.
>> Same is with a suspend/resume.
>>
>> Kernel 3.12.13 adjusts the cooling on it's own, but appropriately.
>
> This almost certainly is an ACPI regression, but I'm not sure whether
> thermal management or CPU power management is broken on your system.
>
> Can you compare the contents of /sys/class/thermal/ from working and
> not working kernels, please?
>
> Rafael
>

Hi again,
unfortunately you didn't specify how deeply I should dig into=20
/sys/class/thermal. So you get the lines from # BOF # to # EOF #=20
below. I hope they're readable without more comments.

The most remarkable changes, in my eyes, had happened within=20
"thermal_zone1".

Best regards,
Manuel Krause


# BOF #
Following ones are all from /sys/class/thermal/ which are links=20
to -> ../../devices/virtual/thermal/

I've listed the directories in sections of cooling_devices and=20
thermal_zones separately for each bad/good kernel. For Emailing=20
purposes only. You can merge them into a spreadsheet for your=20
evaluation on your own. I've left out reporting some subdirs and=20
subdir's values that _really_ didn't seem to need attention.

Also, I've had collected the #sensors output for each readout,=20
having reproduced nearly the same workload, represented by the=20
"Fan speed" (thermal_zone4=3D=3DFDTZ).

And I've done my very best to not produce typos or c&p errors.


  3.13.5 -- 20140309 -- 20:52 -- bad
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
dir             |-
                  /type       /cur_state  /max_state
cooling_device0  Processor    0          10
cooling_device1  Processor    0          10
cooling_device2  Fan          0           1
cooling_device3  Fan          1           1
cooling_device4  Fan          0           1
cooling_device5  Fan          0           1
cooling_device6  Fan          0           1
cooling_device7  LCD          0          24

  3.12.13 -- 20140310 -- 00:26 -- good
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
dir             |-
                  /type       /cur_state  /max_state
cooling_device0  Processor    0          10
cooling_device1  Processor    0          10
cooling_device2  Fan          0           1
cooling_device3  Fan          1           1
cooling_device4  Fan          1           1
cooling_device5  Fan          1           1
cooling_device6  Fan          1           1
cooling_device7  LCD          0          24


  3.13.5 -- 20140309 -- 20:52 -- bad
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
dir          |-
               /passive /temp  |-     /cdev?_  /trip_   /trip_
                                       trip_    point_   point_
                                       point    ?_temp   ?_type
thermal_zone0  0        68000   ?=3D0    n.a.   256000   critical
thermal_zone1   n.a.    70000 |-
                                 ?=3D0   6       110000   critical
                                 ?=3D1   5       107000   passive
                                 ?=3D2   4        90000   active
                                 ?=3D3   3        75000   active
                                 ?=3D4   2        55000   active
                                 ?=3D5   1        45000   active
                                 ?=3D6   1        30000   active
thermal_zone2   n.a.    54000 |-
                                 ?=3D0   1       105000   critical
                                 ?=3D1   1        95000   passive
thermal_zone3   n.a.    25800 |-
                                 ?=3D0   1       110000   critical
                                 ?=3D1   1        60000   passive
thermal_zone4  0        58000   ?=3D0    n.a.   110000   critical


  3.12.13 -- 20140310 -- 00:26 -- good
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
dir          |-
               /passive /temp  |-     /cdev?_  /trip_   /trip_
                                       trip_    point_   point_
                                       point    ?_temp   ?_type
thermal_zone0  0        50000   ?=3D0    n.a.   256000   critical
thermal_zone1   n.a.    70000 |-
                                 ?=3D0   1       110000   critical
                                 ?=3D1   1       107000   passive
                                 ?=3D2   2        90000   active
                                 ?=3D3   3        67000   active
                                 ?=3D4   4        55000   active
                                 ?=3D5   5        45000   active
                                 ?=3D6   6        30000   active
thermal_zone2   n.a.    53000 |-
                                 ?=3D0   1       105000   critical
                                 ?=3D1   1        95000   passive
thermal_zone3   n.a.    25600 |-
                                 ?=3D0   1       110000   critical
                                 ?=3D1   1        60000   passive
thermal_zone4  0        58000   ?=3D0    n.a.   110000   critical

---
Legend here:
        /type  is always  acpitz
        /mode             enabled
        /policy           step_wise

       - from kernel ACPI initialisation: thermal_zone0=3D=3DDTSZ,
          thermal_zone1=3D=3DCPUZ, thermal_zone2=3D=3DSKNZ,
          thermal_zone3=3D=3DBATZ, thermal_zone4=3D=3DFDTZ
       - n.a. means      file or value is not available
___
Legend in general:
              /power/control          is always  auto
              /power/runtime_status              unsupported
              /uevent                            ''=3D=3Dempty

----------------------------------------------------------------

  3.13.5 -- 20140309 -- 20:52 -- bad
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +68.0=B0C  (crit =3D +256.0=B0C)
temp2:        +70.0=B0C  (crit =3D +110.0=B0C)
temp3:        +54.0=B0C  (crit =3D +105.0=B0C)
temp4:        +25.8=B0C  (crit =3D +110.0=B0C)
temp5:        +58.0=B0C  (crit =3D +110.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +66.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
Core 1:       +63.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)


  3.12.13 -- 20140310 -- 00:26 -- good
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +50.0=B0C  (crit =3D +256.0=B0C)
temp2:        +70.0=B0C  (crit =3D +110.0=B0C)
temp3:        +53.0=B0C  (crit =3D +105.0=B0C)
temp4:        +25.6=B0C  (crit =3D +110.0=B0C)
temp5:        +58.0=B0C  (crit =3D +110.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +65.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
Core 1:       +61.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)

# EOF #



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
