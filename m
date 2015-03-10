From: Joe Perches <joe@perches.com>
Date: Tue, 10 Mar 2015 18:27:12 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] kernel.h: add find_closest() macro
Message-Id: <1426012032.18060.18.camel@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426008442-26236-1-git-send-email-bgolaszewski@baylibre.com>
	 <1426008442-26236-2-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426008442-26236-2-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <srostedt@redhat.com>

On Tue, 2015-03-10 at 18:27 +0100, Bartosz Golaszewski wrote:
> Searching for the member of an array closest to 'x' is
> duplicated in several places.
[]
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
[]
> @@ -116,6 +116,29 @@
>  }							\
>  )
>  
> +#define __find_closest(x, a, as, op)(					\
> +{									\
> +	typeof(as) _i, _as = (as) - 1;						\
> +	typeof(x) _x = (x);						\
> +	typeof(*a) *_a = (a);						\
> +	for (_i = 0; _i < _as; _i++) {					\
> +		if (_x op DIV_ROUND_CLOSEST(_a[_i] + _a[_i + 1], 2))	\
> +			break;						\
> +	}								\
> +	(_i);								\
> +}									\
> +)

Please use more descriptive variable names.

Most kernel statement expression macros consolidate
the "({" and "})" uses on single lines

#define sem(args) {(		\
	etc...			\
)}

> +
> +/*
> + * Given an array 'a' (sorted in ascending order) of size 'as' return
> + * the index of the element in that array closest to 'x'.
> + */

It'd be nice to use kernel-doc comments here.

> +#define find_closest(x, a, as) __find_closest(x, a, as, <=)
> +/*
> + * Similar to find_closest(), but 'a' is expected to be sorted
> + * in descending order.
> + */

And here.

> +#define find_closest_desc(x, a, as) __find_closest(x, a, as, >)

Shouldn't find_closest and find_closest_dest use
equivalent comparison?

>= ?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
