From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: ADM1031 / ADM1030 Driver
Message-Id: <1083743187.40989bd3eff5b@imp5-q.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083188185.5337.5.camel@megapc>
In-Reply-To: <1083188185.5337.5.camel@megapc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Jean Delvare <khali@linux-fr.org>:

> Hi Alex,
> 
> > ADM1031 driver with activation of monitoring by default.
> > 
> > removed tempX_enable files as they are for interrupt, not
> > measurements.
> 
> I'm testing at the moment.
> 
> The fans are now starting as I load the driver (well, a few seconds
> after), and temperature monitoring works :)
> 
> Bugs found:
> 
> 1* I cannot set temperature critical limits.

Found the bug. Fixed.


> 
> 2* Whatever I set the PWM values to, the fans turn, probably to full
> speed.

It would help if you could send me the i2cdump for 2 or 3 values of PWM.

> 
> 3* Fan speed values don't seem to be correct. They read 1323 (which
> seems to be the minimal value with divisor = 2) and 0, respectively, and
> never change. Since both fans are running at fast speed, it can't be.

Found why fan2 was reading 0 (input not activated.)

There are also 2 fan sensors alternatives (Digital or Analog), in the eval board
there are 2 switches (S1 and S2) that have to be set to TACH1 and TACH2 as the
default value for measurements is digital.

So will it be necessary to enable the user controlling the input type, by adding
a fan_input_type file to control analog / digital input.

> 
> Also, your driver doesn't export alarms?

Not yet, In order to add that, I'd like to know how it has to work.

In the ADM1031, the alarm status register is cleared when read, so reading the
alarm registers will clear the alarms. I wonder how to proceed.

Thanks for your feedbacks,

-- 
-------------------------------------------------
Alexandre d'ALTON
                              alex@alexdalton.org
