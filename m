From: Eric.Pascal@itesoft.com (Eric Pascal)
Date: Tue, 25 Oct 2005 11:34:35 +0000
Subject: [lm-sensors] Patch for 'w83627thf' Chipset add SmartFan control
Message-Id: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have maintained a patch (published on a forum by Peter Oehry - http://archives.andrew.net.au/lm-sensors/msg27345.html) for w83627thf chipsets that enable SmartFan control on the chipset to automaticaly control the CPU Fan speed depending on the CPU temperature. The forum describes the function of the drivers as followed:

They correspond direct with the datasheet of the w83627thf

--------------------------------------------------------------------------
qfan[1-3]_mode		Mode are defined as follows:
				0 = manual Mode
				1 = thermal cruise
				2 = fan speed cruise
				3 = reserved no function
				offset of 4 controls duty-Bit (if set fan does
				not turn off)
qfan[1-3]_start		When at Thermal Cruise mode, fan_pwm will
				increase from 0 to this register value to provide
				a minimum value to turn on the fan.
qfan[1-3]_stop		minimal value for fan_pwm (before it turns of)
qfan[1-3]_stop_time	defines the time from stop value to 0 in 0.1s
qfan[1-3]_target		target temperature in ?C
qfan[1-3]_tolerance	+/- tolerance for target temperature
qfan_step_down		determines the speed of fan_pwm decreasing 
				the speed, when temperature is below
				target-tolerance (Unit is 1.6 seconds)
qfan_step_up		determines the speed of fan_pwm increasing the
				speed, when temperature is above
				target+tolerance (Unit is 1.6 seconds)

the good thing about all these changes is that all other functions
(except that it's not possible to change the pwm_value during cruise
mode) remains the same. So any front-end application can use all the old
functions as before.
---------------------------------------------------------------------------

I have adapted the patch to the successive versions of the kernel and here is the latest that can be applied to the 2.6.15rc5 kernel.
Can someone using a w83627thf validate it so that Linus will know it works from at least another person?

Thank you.
