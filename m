From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
Date: Wed, 11 Jun 2008 19:41:29 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] f71882.c driver,
Message-Id: <200806111941.m5BJfTpl003204@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200806110520.m5B5KDgO018954@localhost>
In-Reply-To: <200806110520.m5B5KDgO018954@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Hans,

Your proposal sounds fine to me. I wasn't too happy with the fan?_target
pwm? conflict either.  So I will implement the following:

	1. Remove fan?_target.
	2. Add fan?_full_speed.
	3. Interpret pwm? as the duty cycle when in duty cycle mode.
	4. Scale pwm? from 0..255 to 0..fan?_full_speed when in rpm mode.
	5. Change the behavior of pwm?_enable not to change pwm vs. duty
	   cycle mode.
	5. Add module option to select rpm/duty cycle mode.  
	6. Add pwm?_auto*

This will take some time of course. (Although being able to read the
temperature of my "Asus EAH3650 silent" would speed things up ;-)

My BIOS doesn't put a usefull value in the full speed register. There is
also no way to set the case fan to anything but a fixed PWM value. Then
again I build the computer from seperate components, I can imagine a
fully assembled system could do more.

regards,

Mark van Doesburg.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
