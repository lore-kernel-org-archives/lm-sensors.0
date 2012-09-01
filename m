From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 01 Sep 2012 17:02:54 +0000
Subject: Re: [lm-sensors] [PATCH v4] linux/kernel.h: Fix DIV_ROUND_CLOSEST to support negative dividends
Message-Id: <20120901190254.108e3f6b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346425339-17138-1-git-send-email-linux@roeck-us.net>
	<20120831123812.62729e1c.akpm@linux-foundation.org>
In-Reply-To: <20120831123812.62729e1c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, lm-sensors@lm-sensors.org

Hi Andrew, Guenter,

On Fri, 31 Aug 2012 12:38:12 -0700, Andrew Morton wrote:
> On Fri, 31 Aug 2012 08:02:19 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > DIV_ROUND_CLOSEST returns a bad result for negative dividends:
> > 	DIV_ROUND_CLOSEST(-2, 2) = 0
> > 
> > Most of the time this does not matter. However, in the hardware monitoring
> > subsystem, DIV_ROUND_CLOSEST is sometimes used on integers which can be
> > negative (such as temperatures).
> > 
> > ...
> >
> > +
> > +/*
> > + * Divide positive or negative dividend by positive divisor and round
> > + * to closest integer. Result is undefined for negative divisors.
> > + */
> >  #define DIV_ROUND_CLOSEST(x, divisor)(			\
> >  {							\
> > -	typeof(divisor) __divisor = divisor;		\
> > -	(((x) + ((__divisor) / 2)) / (__divisor));	\
> > +	typeof(x) __x = x;				\
> > +	typeof(divisor) __d = divisor;			\
> > +	(((typeof(x))-1) >= 0 || (__x) >= 0) ?		\
> > +		(((__x) + ((__d) / 2)) / (__d)) :	\
> > +		(((__x) - ((__d) / 2)) / (__d));	\
> >  }							\
> 
> Looks good to me.

My testing looks good too.

Acked-by: Jean Delvare <khali@linux-fr.org>

> The patch causes no change in text size for
> kernel/sched/fair.o and drivers/cpuidle/governors/menu.o, so it seems
> that the cc trickery is working.

Indeed. I looked for test size increase, and for my config, besides
hwmon, I only spotted the following ones:

drivers/media/rc/mceusb.o
drivers/gpu/drm/i915/intel_pm.o
drivers/tty/serial/pch_uart.o

These don't look like hot paths, so I'd say we don't care. Plus the
intel_pm one can probably be solved by using an unsigned int, I don't
see why/how ia_freq could be negative (negative frequency anyone?) And
for mceusb it can be solved easily by changing "1" to "1U".

For hwmon drivers, we typically only use DIV_ROUND_CLOSEST when the
user changes a setting, this isn't a frequent event. Plus, this is
exactly the case we are fixing here, as temperature limits, and to a
lesser extent voltage limits, can be negative.

> I'll add it to my tree for testing - please merge this via your tree.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
