From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 19 Dec 2012 21:47:21 +0000
Subject: Re: [lm-sensors] [PATCH v2] linux/kernel.h: Fix DIV_ROUND_CLOSEST with unsigned divisors
Message-Id: <20121219134721.bbde212f.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1355928015-26212-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1355928015-26212-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Juergen Beisert <jbe@pengutronix.de>, Jean Delvare <khali@linux-fr.org>

On Wed, 19 Dec 2012 06:40:15 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Commit 263a523 fixes a warning seen with W=1 due to change in
> DIV_ROUND_CLOSEST. Unfortunately, the C compiler converts divide operations
> with unsigned divisors to unsigned, even if the dividend is signed and
> negative (for example, -10 / 5U = 858993457). The C standard says "If one
> operand has unsigned int type, the other operand is converted to unsigned
> int", so the compiler is not to blame.
> As a result, DIV_ROUND_CLOSEST(0, 2U) and similar operations now return
> bad values, since the automatic conversion of expressions such as "0 - 2U/2"
> to unsigned was not taken into account.
> 
> Fix by checking for the divisor variable type when deciding which operation
> to perform. This fixes DIV_ROUND_CLOSEST(0, 2U), but still returns bad values
> for negative dividends divided by unsigned divisors. Mark the latter case as
> unsupported.

The changelog didn't describe the end-user visible effects of the bug. 
Please always include this information.  Because...

The patch is applicable to 3.7.x.  Should we backport it?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
