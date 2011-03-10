From: Robert Kaiser <kairo@kairo.at>
Date: Thu, 10 Mar 2011 20:05:04 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <ilbatg$r2t$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter Roeck schrieb:
> On Thu, Mar 10, 2011 at 06:53:28AM -0500, Guenter Roeck wrote:
> [ ... ]
>>>
>>> So first question is what chip he has.
>>>
>> ... answer is NCT6775F, from Robert's log. It uses the "old" registers for the min
>> speed settings, so presumably that should be correct. Yet, there must be a reason
>> for the alarm. Maybe it is the "maximum RPM" register after all - the NCT6775F
>> has that set of registers as well.
>>
> Doesn't look like the "maximum RPM" register is the culprit. I have a system with NCT6775F
> (not using its fan controls, though). Looks like one can not write into that register, so it
> must be a status register. Maybe it reports the maximum RPM the chip has seen.

OK, so here's a bit of shortened output of my tests:


# echo 5000 > /sys/devices/platform/w83627ehf.656/fan2_min
# sensors
[...]
fan2:                    0 RPM  (min = 5037 RPM, div = 4)
[...]

# sensors
[...]
fan2:                 1102 RPM  (min = 5113 RPM, div = 8)  ALARM
[...]

# sensors
[...]
fan2:                 1095 RPM  (min = 5113 RPM, div = 8)  ALARM
[...]

# sensors
[...]
fan2:                 1061 RPM  (min = 5113 RPM, div = 8)  ALARM
[...]

# echo 0 > /sys/devices/platform/w83627ehf.656/fan2_min
# sensors
[...]
fan2:                 1054 RPM  (min =    0 RPM, div = 8)
[...]

# sensors
[...]
fan2:                 1095 RPM  (min =    0 RPM, div = 8)
[...]

# sensors
[...]
fan2:                 1061 RPM  (min =    0 RPM, div = 8)
[...]


So, in short, it looks like it's correct that this is a minimum, but it 
might get triggered very early in the cycle or so and when re-setting 
the alarm due to that re-writing of the minimum, everything is OK.

Robert Kaiser


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
