From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 24 Oct 2005 12:03:35 +0000
Subject: [lm-sensors] Support for SMSC 47M15x/192
Message-Id: <nGfHkxVg.1130147499.1122440.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510162303.21468.pavouk@pavouk.org>
In-Reply-To: <200510162303.21468.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Pavel,

On 2005-10-24, Pavel Ruzicka wrote:
> It's a little strange. I can't set fan1_min lower than 640.

It is expected due to the hardware implementation. The lowest speed that
can be monitored (and thus the lowest limit you can set) depends on an
internal clock speed and a clock divider. For a divider of 8, this is
(32768*60)/(2*8*192) = 640. For lower dividers, the value is even
greater.

Most chips let you disable the alarm by writing 0 to the limit but these
SMSC chips use a different logic and it seems you can't disable the
alarm that way.

> fan2_div it's possible to change to 1, 2, 4, 8, but minimal limits
> are increased. Example of output:
> smsc47m1-isa-0800
> Adapter: ISA adapter
> fan1:        0 RPM  (min =  640 RPM, div = 8)          ALARM
> fan2:        0 RPM  (min = 5120 RPM, div = 1)          ALARM

See above, this is because the minimum low value is greater with lower
dividers. 5120 RPM is the lowest possible value for divider 1.

> smsc47m1-isa-0800
> Adapter: ISA adapter
> fan1:        0 RPM  (min =  640 RPM, div = 8)          ALARM
> fan2:     1050 RPM  (min = 1280 RPM, div = 4)          ALARM

This is more surprising, as the driver should try to preserve the low
limit on divider increment. Unless you actually did it the other way
around (4 then 1)? I took a look at the code and it looks correct to me.

Anyway, you can set the value again by writing it to fan2_min.

> Setting of pwm doesn't work for me, but maybe I can do something wrong.
>
> sensors -s tells me:
> -----------------------
> Error: Line 2047: Unknown feature name
> smsc47m1-isa-0800: No such feature known
> -----------------------
>
> This is part of /etc/sensors.conf:
> -------------------
> chip "smsc47m1-*"
>     set fan2_min 640
>     set fan2_div 8
>     set pwm1 1
> -------------------

That's expected, as libsensors doesn't know about fan speed control
except for a few chips. Typically, PWM operations are done directly
through sysfs. Check in /sys/bus/i2c/devices, you should find a
directory for your chip and pwm files here. Use with caution, of course.

Anyway, the tests above are sufficient to convince me that your chip is
compatible with the LPC47M192 as fan as fan control and monitoring is
concerned. We will have to update our documentation accordingly.

Thanks,
--
Jean Delvare
