From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 07 Nov 2008 19:34:33 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] adt7462: New hwmon driver
Message-Id: <20081107193433.GA8800@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com> <20081107185626.13022.59407.stgit@elm3a70.beaverton.ibm.com> <1226084691.11596.42.camel@brick> <20081107112731.cec03a04.akpm@linux-foundation.org>
In-Reply-To: <20081107112731.cec03a04.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, Nov 07, 2008 at 11:27:31AM -0800, Andrew Morton wrote:
> > > +#define ROUND_DIV(x, divisor)  (((x) + ((divisor) / 2)) / (divisor))
> > 
> > DIV_ROUND_UP ?
> 
> That's different.  This one should be called ROUND_CLOSEST or something
> like that.

Actually, there _is_ such a macro in include/linux/kernel.h, but it does
a double-eval naughty just like mine.  That said, no need to bloat the
source tree, so I can reroll, and possibly even fix the kernel macro.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
