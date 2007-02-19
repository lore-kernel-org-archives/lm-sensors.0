From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Mon, 19 Feb 2007 08:10:25 +0000
Subject: [lm-sensors] IPMI sysfs support for 2.6.16.x
Message-Id: <45D95B71.2070205@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1171733778.45d73d12edf0a@mail.third-rock.net>
In-Reply-To: <1171733778.45d73d12edf0a@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Paul Reilly wrote:
>>> Can I just copy the whole drivers/char/ipmi/  dir from a 2.6.17 kernel,
>>> and put it in my 2.6.16.33 ?
>>>
>>>       
>> That is probably the easiest way to handle this.  There may be one or
>> two things that need to be fixed, but not much.
>>     
>
> OK, Thanks Corey. I tried that and it bails out during the kernel compile
> with problems with function declarations:
>
> [snip]
> Should I be doing something different with the include files?
> Any tips on how to fix this?

Unless there is some specific reason that you want lm_sensors, you might
find that accessing the temperature readings directly with IPMI methods
is much easier.  Your kernel likely already has the IPMI drivers and you
may already have the ipmitool command which gives you access to all the
BMC features without needing sysfs support.

Penguin Computing has done extensive testing of ipmitool to access the
BMC both locally and remotely via IPMI over LAN.

Look at the output of 'ipmitool sdr elist' and 'ipmitool sensors'

In addition, with ipmitool you have access to the historical event logs
(ipmitool sel elist), server control ("ipmitool chassis power status"
and related "soft" for clean ACPI shutdown, "on", and "reset"), and
console access (ipmitool sol)

Give Penguin Tech Support a call if you need help getting IPMI working
on your system.

Thanks,
Phil Pokorny
Director of Field Engineering
Penguin Computing

