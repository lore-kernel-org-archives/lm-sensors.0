From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Mon, 15 Jun 2009 14:29:01 +0000
Subject: Re: [lm-sensors] Jetway NC92-330-LF motherboard sensors.conf
Message-Id: <55a4f86e0906150729o6dda875eofc0221bc8982c6d0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <55a4f86e0906050429q2aad447cqf7ddea1a043bf1c5@mail.gmail.com>
In-Reply-To: <55a4f86e0906050429q2aad447cqf7ddea1a043bf1c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

(In case that wasn't clear, the thing marked CPUFAN in the BIOS and in
the config is actually on the northbridge, and the exhaust from the
northbridge blows over the cpu)

2009/6/15 Maciej Żenczykowski <zenczykowski@gmail.com>:
> Fair enough, but the intel atom 330 chip is only 8W TDP (passive
> cooling, although using the exhaust heat from the northbridge for
> cooling) and the northbridge chipset is ~20W TDP (active cooling).  As
> such it's not clear exactly what to expect to get hotter faster.
> They're marked the way I believe the BIOS marks them, but on an idle
> machine with plenty of cooling:
>
> Core 0:      +40.0°C  (crit = +95.0°C)
> Core 1:      +41.0°C  (crit = +95.0°C)
> Core 2:      +42.0°C  (crit = +95.0°C)
> Core 3:      +41.0°C  (crit = +95.0°C)
>
> CPUFAN:     1920 RPM
> SYSFAN1:    3667 RPM
> SYSFAN2:    2008 RPM
> ?CPU Temp:   +31.0°C  (high = +85.0°C, hyst = +81.0°C)
> ?Sys Temp:   +41.0°C  (high = +85.0°C, hyst = +81.0°C)
> ???? Temp:   +47.0°C  (high = +70.0°C, hyst = +68.0°C)
>
> # cat /proc/acpi/thermal_zone/THRM/temperature
> temperature:             31 C
>
> Unfortunately the core temps may or may not be correct (they may need
> an offset of +-X degrees, since it's not clear what TjMax actually is
> for an atom 330, and I'm 'kind of' guessing it to be 95), and the cpu
> temp being lower than the sys temp actually makes some sense...
>
> The last temperature isn't even shown by the BIOS, but does seem to
> show a kind of reasonable value (maybe it's the NB?)...
>
> I'm guessing that the CPU does actually run cooler than the
> northbridge - it's just a tad counter-intuitive.
>
> 2009/6/15 Jean Delvare <khali@linux-fr.org>:
>> On Fri, 5 Jun 2009 13:29:38 +0200, Maciej Żenczykowski wrote:
>>> submitting a sensors.conf file for a Jetway NC92-330-LF motherboard
>>> with f71882fg monitoring chip.
>>>
>>> # uname -a
>>> Linux gaia 2.6.29.4-168.mz1.fc11.x86_64 #1 SMP Fri Jun 5 11:10:05 CEST
>>> 2009 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> # lsmod | head -n 5
>>> Module                  Size  Used by
>>> f71882fg               27120  0
>>> coretemp                6768  0
>>>
>>> Also including a slight patch to coretemp.c for atom support.
>>>
>>> Hope you include the conf in the wiki.
>>
>> Done, thanks for your contribution:
>> http://www.lm-sensors.org/wiki/Configurations/Jetway/NC92-330-LF
>>
>> Note: you should really be able to tell which is the CPU temperature
>> sensor by putting significant load on the system and watching which
>> temperature value raises highest and fastest.
>>
>> --
>> Jean Delvare
>>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
