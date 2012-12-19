From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Dec 2012 22:41:22 +0000
Subject: Re: [lm-sensors] [PATCH v2] linux/kernel.h: Fix DIV_ROUND_CLOSEST with unsigned divisors
Message-Id: <20121219224122.GA26863@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1355928015-26212-1-git-send-email-linux@roeck-us.net>
 <20121219134721.bbde212f.akpm@linux-foundation.org>
In-Reply-To: <20121219134721.bbde212f.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Juergen Beisert <jbe@pengutronix.de>, Jean Delvare <khali@linux-fr.org>

On Wed, Dec 19, 2012 at 01:47:21PM -0800, Andrew Morton wrote:
> On Wed, 19 Dec 2012 06:40:15 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Commit 263a523 fixes a warning seen with W=1 due to change in
> > DIV_ROUND_CLOSEST. Unfortunately, the C compiler converts divide operations
> > with unsigned divisors to unsigned, even if the dividend is signed and
> > negative (for example, -10 / 5U = 858993457). The C standard says "If one
> > operand has unsigned int type, the other operand is converted to unsigned
> > int", so the compiler is not to blame.
> > As a result, DIV_ROUND_CLOSEST(0, 2U) and similar operations now return
> > bad values, since the automatic conversion of expressions such as "0 - 2U/2"
> > to unsigned was not taken into account.
> > 
> > Fix by checking for the divisor variable type when deciding which operation
> > to perform. This fixes DIV_ROUND_CLOSEST(0, 2U), but still returns bad values
> > for negative dividends divided by unsigned divisors. Mark the latter case as
> > unsupported.
> 
> The changelog didn't describe the end-user visible effects of the bug. 
> Please always include this information.  Because...
> 
One observed effect is that the s2c_hwmon driver reports a value of 4198403
instead of 0 if the ADC reads 0.

Other impact is unpredictable. Problem is seen if the divisor is an unsigned
variable or constant and the dividend is less than (divisor/2).

> The patch is applicable to 3.7.x.  Should we backport it?
> 
Yes. DIV_ROUND_CLOSEST is used throughout the kernel, and impact is
unpredictable.

3.6 needs it as well.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
