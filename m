From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 19 Mar 2015 16:28:47 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] util_macros.h: add find_closest() macro
Message-Id: <CAMpxmJUWWVi3wWBBjJOAs=VM0q_Q4+HSBj+n6cMObePwN8LDzQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426775420-31350-1-git-send-email-bgolaszewski@baylibre.com>
	<1426775420-31350-2-git-send-email-bgolaszewski@baylibre.com>
	<20150319120323.375ff43c@gandalf.local.home>
In-Reply-To: <20150319120323.375ff43c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>

2015-03-19 17:03 GMT+01:00 Steven Rostedt <rostedt@goodmis.org>:
>
> The above variables are not very unique. I've been thinking about all
> the variables that are defined in macros, and we may want to establish
> some kind of naming convention to keep from having name space
> collisions.
>
> Maybe something like...
>
>         typeof(as) __fc_i_, __fc_a_ = (as) -1;
>         typeof(__fc_x_) = (x);
>         typeof(*a) *__fc_a_ = (a);
>
> -- Steve

Definitely a good idea - it should probably be added to section 12 of
the CodingStyle doc. What does 'fc' stand for?

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
