From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 31 Aug 2012 21:05:57 +0000
Subject: Re: [lm-sensors] [PATCH v4] linux/kernel.h: Fix DIV_ROUND_CLOSEST to support negative dividends
Message-Id: <20120831210557.GA3645@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346425339-17138-1-git-send-email-linux@roeck-us.net>
 <20120831123812.62729e1c.akpm@linux-foundation.org>
In-Reply-To: <20120831123812.62729e1c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On Fri, Aug 31, 2012 at 12:38:12PM -0700, Andrew Morton wrote:
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
> Looks good to me.  The patch causes no change in text size for
> kernel/sched/fair.o and drivers/cpuidle/governors/menu.o, so it seems
> that the cc trickery is working.
> 
> I'll add it to my tree for testing - please merge this via your tree.
> 
Will do.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
