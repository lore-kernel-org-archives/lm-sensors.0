From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 12 Nov 2008 00:08:54 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Create a DIV_ROUND_CLOSEST macro to do
Message-Id: <20081111160854.3027c50d.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
	<Pine.LNX.4.64.0811111459300.24267@t2.domain.actdsltmp>
	<20081111152007.ff508e26.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0811111539480.24267@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0811111539480.24267@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trent Piepho <tpiepho@freescale.com>
Cc: djwong@us.ibm.com, khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 11 Nov 2008 15:42:09 -0800 (PST)
Trent Piepho <tpiepho@freescale.com> wrote:

> On Tue, 11 Nov 2008, Andrew Morton wrote:
> > On Tue, 11 Nov 2008 15:05:02 -0800 (PST)
> > Trent Piepho <tpiepho@freescale.com> wrote:
> >> On Mon, 10 Nov 2008, Darrick J. Wong wrote:
> >>> #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
> >>> #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> >>> #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
> >>> +#define DIV_ROUND_CLOSEST(x, divisor)(			\
> >>> +{							\
> >>> +	typeof(divisor) __divisor = divisor;		\
> >>> +	(((x) + ((__divisor) / 2)) / (__divisor));	\
> >>> +}							\
> >>> +)
> >>
> >> Maybe you can do away with the statement-expression extension?  I've seen
> >> cases where it cases gcc to generate worse code.  It seems like it
> >> shouldn't, but it does.  I know DIV_ROUND_CLOSEST (maybe DIV_ROUND_NEAR?)
> >> uses divisor twice, but all the also divide macros do that too, so why does
> >> this one need to be different?
> >
> > The others need fixing too.
> 
> Is it worth generating worse code for these simple macros?

Well that's an interesting question.

The risks with the current code are

a) It will introduce straightforward bugs, where pointers are
   incremented twice, etc.

   Hopefully these things will be apparent during testing and we'll
   fix them up in the usual fashion.

b) It will introduce subtle slowdowns due to needlessly executing
   code more than once, as in the hugepage case which I identified.
   These problems will hang around for long periods.

So they're good reasons to fix the macros.  If these fixes cause the
compiler to generate worse code then we should quantify and understand
that.  Perhaps it is only certain compiler versions.  Perhaps we can
find a test case (should be easy?) and send it over to the gcc guys to
fix.  Perhaps we can find some C-level construct which prevents the
compiler from going into stupid mode without reintroducing the existing
problems.

> >> Note that if divisor is a signed variable, divisor/2 generates worse code
> >> than divisor>>1.
> >
> > yup.  I wonder why the compiler doesn't do that for itself - is there a
> > case where it will generate a different result?
> 
> main()
> {
>      int x = -5;
>      printf("%d %d\n", x>>1, x/2);
> }
> $ a.out
> -3 -2

ah, thanks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
