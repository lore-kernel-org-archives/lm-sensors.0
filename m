From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 03 Aug 2009 11:57:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Create a DIV_ROUND_CLOSEST macro to do
Message-Id: <1249300672.7924.53.camel@twins>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Julia Lawall <julia@diku.dk>

On Mon, 2008-11-10 at 17:01 -0800, Darrick J. Wong wrote:
> Create a helper macro to divide two numbers and round the result to the
> nearest whole number.  This is a helper macro for hwmon drivers that
> want to convert incoming sysfs values per standard hwmon practice, though
> the macro itself can be used by anyone.

Its too late to rename this now isn't it :-/

DIV_ROUND_{UP,CEIL}
DIV_ROUND_{DOWN,FLOOR}

I get.

The proposed thing is simply DIV_ROUND, but this DIV_ROUND_CLOSEST name
is just wonky.

Also, shouldn't it be something like ?

  DIV_ROUND(x, y) (((x) + (((y)+1)/2)) / (y))

Also, do we want the default rounding to be symmetric or asymmetric?

I think round to half even or something would be nice, but would add an
extra conditional, not sure its worth it (round away from zero only
works for signed numbers and it would also cost one conditional).

> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  include/linux/kernel.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index fba141d..fb02266 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -48,6 +48,12 @@ extern const char linux_proc_banner[];
>  #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
>  #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
>  #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
> +#define DIV_ROUND_CLOSEST(x, divisor)(			\
> +{							\
> +	typeof(divisor) __divisor = divisor;		\
> +	(((x) + ((__divisor) / 2)) / (__divisor));	\
> +}							\
> +)
>  
>  #define _RET_IP_		(unsigned long)__builtin_return_address(0)
>  #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
