From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 30 Aug 2012 23:15:32 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] linux/kernel.h: Introduce IDIV_ROUND_CLOSEST
Message-Id: <20120830161532.0db909c9.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346171456-29255-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1346171456-29255-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On Tue, 28 Aug 2012 09:30:55 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> DIV_ROUND_CLOSEST returns a bad result for negative dividends:
> 	DIV_ROUND_CLOSEST(-2, 2) = 0
> 
> Most of the time this does not matter. However, in the hardware monitoring
> subsystem, it is sometimes used on integers which can be negative (such as
> temperatures). Introduce new macro IDIV_ROUND_CLOSEST which also supports
> negative dividends.
> 

Can't we just fix DIV_ROUND_CLOSEST?  That will make it a bit slower
but it's not exactly a speed demon right now.  And fixing
DIV_ROUND_CLOSEST() might just fix other bugs that we don't know about
yet.

Also, the name IDIV_ROUND_CLOSEST doesn't communicate much at all.


> +#define IDIV_ROUND_CLOSEST(x, divisor)(			\
> +{							\
> +	typeof(x) __x = x;				\
> +	typeof(divisor) __d = divisor;			\
> +	(((typeof(x))-1) >= 0 || (__x) >= 0) ?		\
> +		DIV_ROUND_CLOSEST((__x), (__d)) :	\
> +		(((__x) - ((__d) / 2)) / (__d));	\
> +}							\
> +)

And it doesn't help that the new "function" is undocumented.  Yes, we
screwed up with DIV_ROUND_CLOSEST(), but that doesn't mean we need to
keep screwing up!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
