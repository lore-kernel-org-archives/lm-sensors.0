From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 12 Mar 2015 23:07:00 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] kernel.h: add find_closest() macro
Message-Id: <20150312160700.c0a64288f6726ba517318bc2@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426008442-26236-1-git-send-email-bgolaszewski@baylibre.com>
	<1426008442-26236-2-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426008442-26236-2-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Steven Rostedt <srostedt@redhat.com>

On Tue, 10 Mar 2015 18:27:19 +0100 Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:

> +/*
> + * Similar to find_closest(), but 'a' is expected to be sorted
> + * in descending order.
> + */
> +#define find_closest_desc(x, a, as) __find_closest(x, a, as, >)

description?  descriptor? descendent?  oh, it's "descending".  So
let's use "descending"!

I think it's good to put possibly-useful stuff like this into
includes/linux, particularly when we already have several usage sites. 
But we don't _have_ to keep putting things into kernel.h.  Maybe a new
include/linux/handy-macros.h or include/linux/find_closest.h?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
