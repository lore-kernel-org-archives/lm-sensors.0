From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Fri, 13 Mar 2015 08:53:08 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (lm85) replace x_TO_REG() functions with find_closest()
Message-Id: <87fv99cm8b.fsf@rasmusvillemoes.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426008442-26236-1-git-send-email-bgolaszewski@baylibre.com>
	<1426008442-26236-4-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426008442-26236-4-git-send-email-bgolaszewski@baylibre.com>
	(Bartosz Golaszewski's message of "Tue, 10 Mar 2015 18:27:21 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <srostedt@redhat.com>

On Tue, Mar 10 2015, Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:

> Replace RANGE_TO_REG() and FREQ_TO_REG() functions with calls
> to find_closest().
>

I think the other functions you've replaced only had a single caller,
but RANGE_TO_REG is called in two places. It's not a huge function and 2
is not a big number, but maybe it's better to let gcc decide whether to
inline the code. So how about leaving the *_TO_REG functions in place
and just replace their bodies with the appropriate macro invocation?

Rasmus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
