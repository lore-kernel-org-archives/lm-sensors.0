From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Mar 2011 19:44:06 +0000
Subject: Re: [lm-sensors] [PATCH resend] sensors: Add support for additional
Message-Id: <20110315204406.541c06f6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110210030757.GA22858@ericsson.com>
In-Reply-To: <20110210030757.GA22858@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 15 Mar 2011 11:15:00 -0700, Guenter Roeck wrote:
> Regarding formatting, there is also "emergency" and "emergency hyst".

I'd seen this, yes. "emergency" could be shorten to "emerg" (after all
we already shortened "critical" to "crit".) For hysteresis, my plan is
to ensure it's always on the same line as the limit it relates to, so
"hyst" will always be enough.

An alternative would be to compute the max limit name size for each
sensor. However, this would not guarantee per-device alignment, only
per-sensor. This would also increase the code complexity, and I'm not
sure if it's worth it. Opinion?

> Also, there can be temperature limits above 100C, which affects
> formatting as well. So it won't be easy to keep everything aligned.

This can be easily addressed by adding a digit to the values. This only
adds 3 characters per line, it's probably acceptable. The only drawback
is that it won't keep the different sensor types aligned any longer,
unless we also do the same for them. Which might be an option after
all...

> Some sample output:
> 
> max6696-i2c-1-19
> Adapter: Phalanx i2c channel 1
> temp1:        +21.6 C  (low  = -55.0 C, high = +70.0 C)
>                        (crit = +70.0 C, crit hyst = +60.0 C)
>                        (emergency = +90.0 C, emergency hyst = +80.0 C)
> temp2:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (MIN)
>                        (crit = +90.0 C, crit hyst = +80.0 C)
>                        (emergency = +120.0 C, emergency hyst = +110.0 C)
> temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (MIN)
>                        (crit = +90.0 C, crit hyst = +80.0 C)
>                        (emergency = +120.0 C, emergency hyst = +110.0 C)
> 
> max6696-i2c-100-18

You have interesting I2C bus numbers :p

> Adapter: SMBus I801 adapter at 5080
> temp1:        +22.4 C  (low  = -55.0 C, high = +70.0 C)
>                        (crit = +70.0 C, crit hyst = +60.0 C)
>                        (emergency = +90.0 C, emergency hyst = +80.0 C)
> temp2:        +81.1 C  (low  = -55.0 C, high = +70.0 C)  ALARM (MAX)
>                        (crit = +90.0 C, crit hyst = +80.0 C)
>                        (emergency = +120.0 C, emergency hyst = +110.0 C)
> temp3:        +22.8 C  (low  = -55.0 C, high = +70.0 C)
>                        (crit = +90.0 C, crit hyst = +80.0 C)
>                        (emergency = +120.0 C, emergency hyst = +110.0 C)
> jc42-i2c-100-1a
> Adapter: SMBus I801 adapter at 5080
> temp1:        +26.2 C  (low  =  +0.0 C, high =  +0.0 C)  ALARM (MAX, CRIT)

The "MAX" in alarm is inconsistent with the "high" label... We should
use LOW and HIGH for temperature alarms, not MIN and MAX.

>                        (hyst =  +0.0 C, crit =  +0.0 C)

Here hyst is separated from high, which makes it non-obvious that they
relate to each other. I'll improve this, and I'm glad you have a test
case ;)

>                        (crit hyst =  +0.0 C)
> 
> lineage_pem-i2c-61-45
> Adapter: i2c-55-mux (chan_id 0)
> in1:          +0.00 V                                    ALARM (MAX)

Max alarm without max limit? Did you hack the driver for testing
purpose?

I think you're missing one space here, as an ALARM on the temp1 line
would have 2 spaces before ALARM.

> in2:          +0.00 V                                    ALARM
> fan1:             N/A
> temp1:        +34.0 C  (high = +97.0 C, crit = +107.0 C)
> power1:        0.00 nW  
> curr1:        +0.00 A  

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
