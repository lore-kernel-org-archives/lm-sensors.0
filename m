From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 11 Nov 2008 23:20:07 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Create a DIV_ROUND_CLOSEST macro to do
Message-Id: <20081111152007.ff508e26.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
	<Pine.LNX.4.64.0811111459300.24267@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0811111459300.24267@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trent Piepho <tpiepho@freescale.com>
Cc: djwong@us.ibm.com, khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 11 Nov 2008 15:05:02 -0800 (PST)
Trent Piepho <tpiepho@freescale.com> wrote:

> On Mon, 10 Nov 2008, Darrick J. Wong wrote:
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index fba141d..fb02266 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -48,6 +48,12 @@ extern const char linux_proc_banner[];
> > #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
> > #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> > #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
> > +#define DIV_ROUND_CLOSEST(x, divisor)(			\
> > +{							\
> > +	typeof(divisor) __divisor = divisor;		\
> > +	(((x) + ((__divisor) / 2)) / (__divisor));	\
> > +}							\
> > +)
> 
> Maybe you can do away with the statement-expression extension?  I've seen
> cases where it cases gcc to generate worse code.  It seems like it
> shouldn't, but it does.  I know DIV_ROUND_CLOSEST (maybe DIV_ROUND_NEAR?)
> uses divisor twice, but all the also divide macros do that too, so why does
> this one need to be different?

The others need fixing too.

> Note that if divisor is a signed variable, divisor/2 generates worse code
> than divisor>>1.

yup.  I wonder why the compiler doesn't do that for itself - is there a
case where it will generate a different result?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
