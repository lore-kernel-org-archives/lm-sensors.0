From: Joe Perches <joe@perches.com>
Date: Thu, 19 Mar 2015 23:22:35 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/5] documentation: update CodingStyle on local variables naming in macro
Message-Id: <1426807355.21142.21.camel@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426786065-9798-1-git-send-email-bgolaszewski@baylibre.com>
	 <1426786065-9798-3-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426786065-9798-3-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>

On Thu, 2015-03-19 at 18:27 +0100, Bartosz Golaszewski wrote:
> Describe proper naming convention for local variables in macros
> resembling functions.
[]
> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
[]

> +5) namespace collisions when defining local variables in macros resembling
> +functions:
> +
> +#define FOO(x)				\
> +({					\
> +	typeof(x) ret;			\
> +	ret = calc_ret(x);		\
> +	(ret);				\

trivia: ret wouldn't need parentheses here.

> +)}
> +
> +ret is a common name for a local variable - __foo_ret is less likely
> +to collide with an existing variable.

Is shadowing really much of a problem here?

These are statement expression macros and names
have local scope anyway.

It's similar to function arguments using the same
names as parameters.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
