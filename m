From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 07 Nov 2008 19:27:31 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] adt7462: New hwmon driver
Message-Id: <20081107112731.cec03a04.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com>
	<20081107185626.13022.59407.stgit@elm3a70.beaverton.ibm.com>
	<1226084691.11596.42.camel@brick>
In-Reply-To: <1226084691.11596.42.camel@brick>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: djwong@us.ibm.com, khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 07 Nov 2008 11:04:51 -0800
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> On Fri, 2008-11-07 at 10:56 -0800, Darrick J. Wong wrote:
> > New driver to play with.  As Jean mentioned a couple of years ago,
> > this
> > chip is a beast with odd combinations of 8 fans, 4 temperatures, and 
> > 13 voltage sensors.  This driver has been tested on an IntelliStation
> > Z30.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> > ---
> > +#define MASK_AND_SHIFT(value, prefix)	\
> > +	(((value) & prefix##_MASK) >> prefix##_SHIFT)
> > +
> 
> I'm not sure, but doesn't this exist somewhere in the common kernel
> headers.

No, core kernel doesn't have a macro which requires that the caller
previously defined foo_MASK and foo_SHIFT.  Only drivers are allowed to
get away with such fugliness ;)

> > +#define ROUND_DIV(x, divisor)  (((x) + ((divisor) / 2)) / (divisor))
> 
> DIV_ROUND_UP ?

That's different.  This one should be called ROUND_CLOSEST or something
like that.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
