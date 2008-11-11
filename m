From: Trent Piepho <tpiepho@freescale.com>
Date: Tue, 11 Nov 2008 23:05:02 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Create a DIV_ROUND_CLOSEST macro to do
Message-Id: <Pine.LNX.4.64.0811111459300.24267@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Mon, 10 Nov 2008, Darrick J. Wong wrote:
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index fba141d..fb02266 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -48,6 +48,12 @@ extern const char linux_proc_banner[];
> #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
> #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
> +#define DIV_ROUND_CLOSEST(x, divisor)(			\
> +{							\
> +	typeof(divisor) __divisor = divisor;		\
> +	(((x) + ((__divisor) / 2)) / (__divisor));	\
> +}							\
> +)

Maybe you can do away with the statement-expression extension?  I've seen
cases where it cases gcc to generate worse code.  It seems like it
shouldn't, but it does.  I know DIV_ROUND_CLOSEST (maybe DIV_ROUND_NEAR?)
uses divisor twice, but all the also divide macros do that too, so why does
this one need to be different?

Note that if divisor is a signed variable, divisor/2 generates worse code
than divisor>>1.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
