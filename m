From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 12 Jun 2008 08:05:54 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] f71882.c driver,
Message-Id: <4850D8E2.2090708@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200806110520.m5B5KDgO018954@localhost>
In-Reply-To: <200806110520.m5B5KDgO018954@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark van Doesburg wrote:
> Hello Hans,
> 
> Your proposal sounds fine to me. I wasn't too happy with the fan?_target
> pwm? conflict either.  So I will implement the following:
> 
> 	1. Remove fan?_target.
> 	2. Add fan?_full_speed.
> 	3. Interpret pwm? as the duty cycle when in duty cycle mode.
> 	4. Scale pwm? from 0..255 to 0..fan?_full_speed when in rpm mode.
> 	5. Change the behavior of pwm?_enable not to change pwm vs. duty
> 	   cycle mode.
> 	5. Add module option to select rpm/duty cycle mode.  
> 	6. Add pwm?_auto*

Excellent! (and thanks!)

> My BIOS doesn't put a usefull value in the full speed register. There is
> also no way to set the case fan to anything but a fixed PWM value.

To bad, I guess that it doesn't use rpm mode then, if the chip doesn't put 
anything usefull in the fullspeed reg itself either I guess most BIOS'es will 
not use rpm mode, but will stick with pwm mode.

Regards,

hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
