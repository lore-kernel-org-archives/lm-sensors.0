From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Nov 2008 10:04:54 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Create a DIV_ROUND_CLOSEST macro to do
Message-Id: <20081111110454.073a6d94@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Darrick,

On Mon, 10 Nov 2008 17:01:32 -0800, Darrick J. Wong wrote:
> 
> Create a helper macro to divide two numbers and round the result to the
> nearest whole number.  This is a helper macro for hwmon drivers that
> want to convert incoming sysfs values per standard hwmon practice, though
> the macro itself can be used by anyone.
> 
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
> 

I don't get why you implement this as a macro rather than an inline
function? A function would look much better.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
