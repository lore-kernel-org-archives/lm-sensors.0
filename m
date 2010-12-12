From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Dec 2010 17:10:16 +0000
Subject: Re: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101212181016.68f96154@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101209165858.GA521@ericsson.com>
In-Reply-To: <20101209165858.GA521@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 9 Dec 2010 08:58:58 -0800, Guenter Roeck wrote:
> I am looking through libsensors and the hwmon sysfs ABI to identify and fix
> inconsistencies.
> 
> One problem I noticed is powerX_alarm, which is defined as "system is drawing
> more power than the cap allows".
> 
> powerX_cap is defined as " ... The *_cap files only appear if the cap is known
> to be enforced by hardware".

This is almost contradictory. If the cap is enforced, then it can't be
exceeded, which means the alarm will never trigger.m

> Now there are conditions where power limits are defined and supported,
> but the hardware does not enforce it. Similar, there are devices reporting power
> alarms not associated with cap enforcement. Examples are ltc4215 and PMBus devices.
> powerX_alarm is supported by the ltc4215 driver, but there is no _cap attribute,
> and the alarm is not associated with a maximum, thus a reported alarm doesn't
> really reflect the ABI.
> 
> I see a number of options:
> 
> 1) Introduce powerX_max as unenforced "max" attribute, in addition to powerX_cap.
>    1a) Introduce powerX_cap_alarm to reflect alarms associated with powerX_cap,
>        introduce powerX_max_alarm, and redefine the semantics of powerX_alarm 
>        to include all possible alarms
>    1b) Redefine semantics of powerX_alarm to include all possible reasons for
>        power alarms.
> 
> 2) Redefine the semantics of powerX_cap to include unenforced maximum power.
>    Redefine powerX_alarm to include all possible reasons for alarms.
> 
> My preferred solution would be 1) with 1b), though 2) would be fine for me as well.
> Any thoughts / comments ? 

1) (both a and b) is fine with me. 2) not so, as the _cap name gets
confusing then.

I don't think that _cap should have existed in the first place. Just
because something happens when a limit is exceeded is no good reason to
rename that limit to something else. But now that it's there, I guess
it will be difficult to get rid of it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
