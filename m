From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: w83627hf driver
Message-Id: <4060A2B2.2060004@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, thanks.  I'll send your info to the team for review.


Phil

Peter Oehry wrote:

>Hello Philip
>
>I updated the w83627hf driver with some code to support the QFan options
>of the w83627thf chip. I think, if we have a Chip, that is able to
>control the fans, it's better to let the chip do this work rather than
>software.
>So far my updated driver can control nearly all qfan settings through
>some new sysfs nodes. It does the work perfect for me. I was only able
>to test the settings for fan2 as the MB (ASUS P4P800) so far as I now
>has only the cpu-fan-pwm connected to the chip.
>
>I don't know if there is another driver in the lm_sensors, that can
>already do this. The problem of getting this things into the lm_sensors
>project might be de discussion of how shoud the new nodes in the sysfs
>be named an how do they behave. I have now idea how many chips the
>ability of qfan have and how different they are to controll.
>
>So far I created the following nodes:
>They correspond direct with the datasheet of the w83627thf
>
>qfan[1-3]_mode		Mode are definde as follows:
>			0 = manual Mode
>			1 = thermal cruise
>			2 = fan speed cruise
>			3 = reserved no function
>			offset of 4 controls duty-Bit (if set fan does
> 			not turn off)
>qfan[1-3]_start		When at Thermal Cruise mode, fan_pwm will
> 			increase from 0 to this register value to prived
> 			a minimum value to turn on the fan.
>qfan[1-3]_stop		minmal value for fan_pwm (bevore it turns of)
>qfan[1-3]_stop_time	defines the time from stop value to 0 in 0.1s
>qfan[1-3]_target	target temperature in ?C
>qfan[1-3]_tolerance	+/- tolerance for target temperature
>qfan_step_down		determines the speed of fan_pwm decreasing the
> 			speed, when temperature is below
> 			target-tolerance (Unit is 1.6 seconds)
>qfan_step_up		determines the speed of fan_pwm increasing the
> 			speed, when temperature is above
> 			target+tolerance (Unit is 1.6 seconds)
>
>the good thing about all these changes is that all other functions
>(except that it's not possible to change the pwm_value during cruise
>mode) remains the same. So any front-end application can use all the old
>functions as bevore.
>
>Let me know if you're interested in my work. I can send you the driver
>as it is or make a diff against my source. It might need som cosmetic
>work bevore I can give you the driver. I thought I'll do this only if
>you're interested. I can also help in furhter development or testing. By
>the way I worked with the driver I got from the latest Kernel patch
>(2.6.5-rc2). I am stil using a 2.6.1 Kernel patched with some drivers.
>
>
>  
>
