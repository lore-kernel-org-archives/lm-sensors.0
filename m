From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 19 Mar 2015 16:03:23 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] util_macros.h: add find_closest() macro
Message-Id: <20150319120323.375ff43c@gandalf.local.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426775420-31350-1-git-send-email-bgolaszewski@baylibre.com>
	<1426775420-31350-2-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426775420-31350-2-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>


BTW, it's best to email this account and not my Red Hat one.


On Thu, 19 Mar 2015 11:53:06 -0400
Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:

> Searching for the member of an array closest to 'x' is
> duplicated in several places.
> 
> Add a new include - util_macros.h - and two macros that
> implement this algorithm for arrays sorted both in ascending
> and descending order.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  include/linux/util_macros.h | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 include/linux/util_macros.h
> 
> diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
> new file mode 100644
> index 0000000..f2097ce
> --- /dev/null
> +++ b/include/linux/util_macros.h
> @@ -0,0 +1,39 @@
> +#ifndef _LINUX_HELPER_MACROS_H_
> +#define _LINUX_HELPER_MACROS_H_
> +
> +#define __find_closest(x, a, as, op)(					\
> +{									\
> +	typeof(as) _i, _as = (as) - 1;					\
> +	typeof(x) _x = (x);						\
> +	typeof(*a) *_a = (a);						\

The above variables are not very unique. I've been thinking about all
the variables that are defined in macros, and we may want to establish
some kind of naming convention to keep from having name space
collisions.

Maybe something like...

	typeof(as) __fc_i_, __fc_a_ = (as) -1;
	typeof(__fc_x_) = (x);
	typeof(*a) *__fc_a_ = (a);

-- Steve


> +	for (_i = 0; _i < _as; _i++) {					\
> +		if (_x op DIV_ROUND_CLOSEST(_a[_i] + _a[_i + 1], 2))	\
> +			break;						\
> +	}								\
> +	(_i);								\
> +})

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
