From: Gianni Vialetto <gianni@rootcube.net>
Date: Thu, 17 Jul 2014 06:29:29 +0000
Subject: Re: [lm-sensors] hwmon: question about the sysfs interface
Message-Id: <20140717062929.GA1487@elysium.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140714164728.GA1041@elysium.lan>
 <20140714172556.GA3753@roeck-us.net>
In-Reply-To: <20140714172556.GA3753-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Hi Guenter,

> For automatic fan control we don't really have a well defined ABI.
> Part of the problem is that the mechanisms used by various chips are
> quite different.
> 
> Please have a look into Documentation/hwmon/nct6775. It is by far
> the driver with the most comprehensive fan control mechanisms and
> attributes. Would any of the attributes or atribute groups in this
> driver meet your needs ? I could imagine that pwm1_target_temp
> for the upper temperature limit and pwm1_temp_tolerance for the difference
> between upper and lower limit might do. Then there are other attributes
> such as pxm1_start, pwm1_floor, pwm1_step, and pwm1_max which you
> could use to control pwm values further is that is possible with the
> driver.

Using pwm1_target_temp and pwm1_temp_tolerance seems a like nice idea,
yes. Some of the other attributes are already used and I'm not certain
how much I should change at this point.

> An alternative would be to use two sets of pwm_auto_point attributes,
> where the first set specifies the start pwm limit and the second
> specifies the upper temperature and limit. So you would have something
> like
> 
> 	pwm1_auto_point1_pwm	pwm at low temperature
> 	pwm1_auto_point1_temp	low temperature
> 
> 	pwm1_auto_point2_pwm	pwm at high temperature
> 	pwm1_auto_point2_temp	high temperature
> 
> After all, there is no requirement that pwm must exactly match the configured
> value; the above only means that the chip uses those values to calculate
> the necessary fan speed. In addition to that, you could still have some
> of the other attributes as needed, such as pwm1_min, pwm1_max, and so on.

This was my initial plan, roughly, but I like the first solution more at
this point.

> Hope this helps,
> Guenter

Definitely. Thank you.

Regards,
Gianni

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
