From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 04 Mar 2006 21:47:20 +0000
Subject: [lm-sensors] [PATCH] Add fan control support to W83627EHF
Message-Id: <440A0AE8.5050604@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409FFA1.7050109@sh.cvut.cz>
In-Reply-To: <4409FFA1.7050109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Thanks for posting your work! I'm testing it right now. I have a question:
> 
> 
>>pwm[1-4]_enable - this file controls mode of fan/temperature control:
>>       * 0 Disabled. In fact the pwm is set to 255
>>       * 1 Manual Mode, write to pwm file any value 0-255 (fullspeed)
>>       * 2 Thermal Cruise
>>       * 3 Smart FAN III
> 
> 
> There is another mode, RPM Cruise, in the datasheet. Smart Fan 3 is
> only supported by CPUFANOUT0 and CPUFANOUT1. Tell me what you think,
> maybe mode 3 should be RPM cruise and mode 4 is either not allowed
> (-EINVAL) or for the two fans that allow Smart Fan 3, it turns it on.

I removed the support for RPM cruise because I cannot see the use of such mode.
The mode can be supported in the driver and in fact it was there.
see the

+static const u8 W83627EHF_PWM_MODE_USER_MAP[] = { 0, 0, 1, 3 };
+static const u8 W83627EHF_PWM_MODE_CHIP_MAP[] = { 1, 2, 4, 3 };

This translates between the former modes:
            * 0 Manual mode
            * 1 Thermal Cruise
            * 2 Fan Speed Cruise
            * 3 Smart FAN III

And yes the we must not allow the smartfan III on the fan1 and 3...

TODO:
not allow the SF3 mode on fans without support
check if fan4 is really enabled

You can meet me on IRC freenode.net #linux-sensors

Regards
Rudolf

> That's all until I get through testing,
> David

