From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Mar 2006 20:05:33 +0000
Subject: [lm-sensors] [PATCH] Add fan control support to W83627EHF
Message-Id: <440B448D.4090609@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409FFA1.7050109@sh.cvut.cz>
In-Reply-To: <4409FFA1.7050109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

> The tempX_target register can still contain a target temperature,
> either the default value loaded by the BIOS or the last temp target
> when the chip was in temp cruise. fanX_target is a good way to add the
> sysfs interface, I like that.

Yep. The target temp register is shared with this speed register so some logic in the driver
must be programmed.

> 
> RPM cruise allows me to set an RPM directly without knowing the PWM
> value. Or, more specifically, it's good for low RPMs, which are hard
> to get perfectly right, since the PWM value is typically 100 or so. At
> PWM values of 70 or so, the fan just stops spinning. Yes, if I wanted
> to read out the RPM value and tinker with the PWM until I got the RPM
> I wanted, I could find what the low threshold is where the fan
> overcomes friction and starts spinning. But that's why RPM cruise is
> so nice.

Ok now I get it.

> Anyway, as long as the chip implements it, it doesn't hurt to export
> the interface, right?

I will certainly have no time for this in next 5 days. So feel free to implement it.
(As the patch on the top of mine) If you have time please check my implementation or
change it so it is even better :) (also provide a patch on top of my original patch)

So to restore the RPM cruise you need to delete both mapping arrays (USER_MAP and CHIP_MAP iirc)
then the pwm_enable will be like:
            * 0 Manual mode
            * 1 Thermal Cruise
            * 2 Fan Speed Cruise
            * 3 Smart FAN III
This has to be fixed so 0 is disabled (to comply with the interface def)
So best to emulate disabled (please check datasheet if it cannot be disabled) is to write 255 to corresponding
pwm ...

Thanks,

Regards
Rudolf


