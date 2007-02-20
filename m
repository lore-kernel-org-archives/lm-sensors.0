From: paul@astropaul.com (Paul Reilly)
Date: Tue, 20 Feb 2007 13:07:17 +0000
Subject: [lm-sensors] IPMI sysfs support for 2.6.16.x
Message-Id: <1171976837.45daf28524626@mail.third-rock.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1171733778.45d73d12edf0a@mail.third-rock.net>
In-Reply-To: <1171733778.45d73d12edf0a@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Philip,

Thanks for the info, and advice on taking the IPMI approach directly
rather than using lm-sensors. I had not looked at that, and perhaps
it is the best way to go. I'd like to be able to integrate the sensor
data in to Cacti to graph temperatures, fan speeds etc over time. So
if I can do that with  IPMI tool I will use that.

IPMItool certainly looks very good from what I have seen,

Best Regards,
Paul

> Unless there is some specific reason that you want lm_sensors, you might
> find that accessing the temperature readings directly with IPMI methods
> is much easier.  Your kernel likely already has the IPMI drivers and you
> may already have the ipmitool command which gives you access to all the
> BMC features without needing sysfs support.
>
> Penguin Computing has done extensive testing of ipmitool to access the
> BMC both locally and remotely via IPMI over LAN.
>
> Look at the output of 'ipmitool sdr elist' and 'ipmitool sensors'
>
> In addition, with ipmitool you have access to the historical event logs
> (ipmitool sel elist), server control ("ipmitool chassis power status"
> and related "soft" for clean ACPI shutdown, "on", and "reset"), and
> console access (ipmitool sol)
>
> Give Penguin Tech Support a call if you need help getting IPMI working
> on your system.
>
> Thanks,
> Phil Pokorny
> Director of Field Engineering
> Penguin Computing
>


-- 

