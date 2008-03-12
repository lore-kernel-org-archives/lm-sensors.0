From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Mar 2008 13:00:31 +0000
Subject: Re: [lm-sensors] serious w83627ehf problem stopping cpu fan
Message-Id: <20080312140031.715b00d1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080312011430.GA20751@alf.mars>
In-Reply-To: <20080312011430.GA20751@alf.mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Mar 2008 02:14:32 +0100, Helmut Grohne wrote:
> Hi,
> 
> (I'm posting from outside, so please CC me on a reply.)
> 
> Some time ago I updated my kernel to 2.6.23.14 (vanilla) from something
> pre-20. My system has a w83627ehf chip (the chip is labeled like that)
> and the support for this chip seemed to have improved.
> 
> However my cpu fan "occasionally" stops spinning. This happened three
> times at the time of this writing. It seems to happen when the system is
> completely idle. As a result the cpu heats up and maybe destroying or
> damaging itself over time. This is BAD!
> 
> I therefore tried to play with the /sys/devices/platform/w83627ehf.*/
> interface. Changing the files pwm2* "sometimes" has an barely
> predictable effect on the cpu fan. I was for instance able to start the
> fan again by writing 2 to pwm2_enable the last time it stopped. However
> I cannot disable the fan now by writing 0 to pwm2 which sometimes worked
> before. Most of my writing data to these files seems to get ignored.
> 
> The only thing I really need now is a stable cpu fan. Can I somehow lock
> it to maximum speed or something similar? Can I somehow run w83627ehf

If you disable Q-Fan in the BIOS, that's what should happen.

> with reduced functionality (like no longer modifying the fan at all)?

No. The w83627ehf driver doesn't change the chip settings by itself, so
there's nothing to reduce.

> 
> Please help me debug this. Do you want any other information not found
> below?

Did you try without the w83627ehf driver loaded? What makes you believe
that the w83627ehf driver is responsible for your problem? This might
as well be an ACPI issue.

> 
> Helmut Grohne
> 
> (...)
> root@# cat sensor_fix.sh 
> #!/bin/bash
> # this script is now invoked every 5 minutes from cron to try and fix
> # the fan automatically.
> 
> cd /sys/devices/platform/w83627ehf.* || exit 1
> 
> test $(<fan2_input) -le 2000 || exit 0
> 
> echo fan not spinning
> 
> while :; do
>         echo "trying pwm2_enable 2"
>         echo 2 > pwm2_enable
>         sleep 1
>         test $(<fan2_input) -le 2000 || exit 0
> 
>         echo "trying pwm2 255"
>         echo 255 > pwm2
>         sleep 1
>         test $(<fan2_input) -le 2000 || exit 0

Note that the value written to pwm2 has no effect when pwm2_enable = 2,
so there's nothing you can hope from this step.

> 
>         echo "trying pwm2_enable 1"
>         echo 1 > pwm2_enable
>         sleep 1
>         test $(<fan2_input) -le 2000 || exit 0
> 
>         echo "trying pwm2 255"
>         echo 255 > pwm2
>         sleep 1
>         test $(<fan2_input) -le 2000 || exit 0
> 
>         echo "trying pwm2_target 1000"
>         echo 1000 > pwm2_target
>         sleep 1
>         test $(<fan2_input) -le 2000 || exit 0

This is setting the target temperature to 1 degree C. That doesn't make
any sense to me, as there is the way the chip can achieve this. On top
of that, this setting is only valid fir pwm2_enable = 2, which isn't
the case at this point.

> done
> root@# exit

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
