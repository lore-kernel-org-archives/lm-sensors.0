From: Joe Perches <joe@perches.com>
Date: Tue, 11 Nov 2008 18:51:50 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Create a DIV_ROUND_CLOSEST macro to do
Message-Id: <1226429510.10478.1061.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
	 <20081111110454.073a6d94@hyperion.delvare>
	 <20081111090702.94be2a19.akpm@linux-foundation.org>
In-Reply-To: <20081111090702.94be2a19.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jean Delvare <khali@linux-fr.org>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Tue, 2008-11-11 at 09:07 -0800, Andrew Morton wrote:
> On Tue, 11 Nov 2008 11:04:54 +0100 Jean Delvare <khali@linux-fr.org> wrote:
> > On Mon, 10 Nov 2008 17:01:32 -0800, Darrick J. Wong wrote:
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > > index fba141d..fb02266 100644
> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> > > @@ -48,6 +48,12 @@ extern const char linux_proc_banner[];
> > >  #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
> > >  #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> > >  #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
> > > +#define DIV_ROUND_CLOSEST(x, divisor)(			\
> > > +{							\
> > > +	typeof(divisor) __divisor = divisor;		\
> > > +	(((x) + ((__divisor) / 2)) / (__divisor));	\
> > > +}							\
> > > +) 
> > I don't get why you implement this as a macro rather than an inline
> > function? A function would look much better.
> The idea is that DIV_ROUND_CLOSEST() can be used with arguments of any
> size (char, short, ...  long long) and will do all the suitable
> promotion and will return a type of the appropriate width and
> signedness.

Perhaps the macro should be placed directly after
DIV_ROUND_UP and should use the same argument naming.

Perhaps HALF_UP is more descriptive and fairly common.
http://java.sun.com/j2se/1.5.0/docs/api/java/math/RoundingMode.html



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
