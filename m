From: Joe Perches <joe@perches.com>
Date: Thu, 19 Mar 2015 15:15:09 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] util_macros.h: add find_closest() macro
Message-Id: <1426778109.21142.9.camel@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426775420-31350-1-git-send-email-bgolaszewski@baylibre.com>
	 <1426775420-31350-2-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426775420-31350-2-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <srostedt@redhat.com>

On Thu, 2015-03-19 at 15:30 +0100, Bartosz Golaszewski wrote:
> Searching for the member of an array closest to 'x' is
> duplicated in several places.
[]
> diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
[]
> @@ -0,0 +1,39 @@
> +#ifndef _LINUX_HELPER_MACROS_H_
> +#define _LINUX_HELPER_MACROS_H_
> +
> +#define __find_closest(x, a, as, op)(					\
> +{									\
> +	typeof(as) _i, _as = (as) - 1;					\
> +	typeof(x) _x = (x);						\
> +	typeof(*a) *_a = (a);						\
> +	for (_i = 0; _i < _as; _i++) {					\
> +		if (_x op DIV_ROUND_CLOSEST(_a[_i] + _a[_i + 1], 2))	\
> +			break;						\
> +	}								\
> +	(_i);								\
> +})

Please use consistent statement expression start/top whitespace.

> +
> +/*

This should be /** for proper kernel-doc style

> + * find_closest - locate the closest element in a sorted array
> + * @x: The reference value.
> + * @a: The array in which to look for the closest element. Must be sorted
> + *  in ascending order.
> + * @as: Size of 'a'.
> + *
> + * Returns the index of the element closest to 'x'.
> + */
> +#define find_closest(x, a, as) __find_closest(x, a, as, <=)
> +
> +/*
> + * find_closest_descending - locate the closest element in a sorted array
> + * @x: The reference value.
> + * @a: The array in which to look for the closest element. Must be sorted
> + *  in descending order.
> + * @as: Size of 'a'.
> + *
> + * Similar to get_closest() but 'a' is expected to be sorted in descending
> + * order.
> + */
> +#define find_closest_descending(x, a, as) __find_closest(x, a, as, >)

Again, why is this > not >= ?




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
