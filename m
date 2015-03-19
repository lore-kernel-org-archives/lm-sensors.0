From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 19 Mar 2015 16:36:09 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] util_macros.h: add find_closest() macro
Message-Id: <CAMpxmJVaw_77v8ordpPBP+9YThPoBYLSQeqym+_hXTqx7NB00w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426775420-31350-1-git-send-email-bgolaszewski@baylibre.com>
	<1426775420-31350-2-git-send-email-bgolaszewski@baylibre.com>
	<20150319120323.375ff43c@gandalf.local.home>
	<CAMpxmJUWWVi3wWBBjJOAs=VM0q_Q4+HSBj+n6cMObePwN8LDzQ@mail.gmail.com>
	<20150319123224.5cbef752@gandalf.local.home>
In-Reply-To: <20150319123224.5cbef752@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>

2015-03-19 17:32 GMT+01:00 Steven Rostedt <rostedt@goodmis.org>:
>
>> Definitely a good idea - it should probably be added to section 12 of
>> the CodingStyle doc. What does 'fc' stand for?
>
> fc = "find_closest" ;-)

Alright, I thought you proposed some global naming convention with fc
standing for something like 'function context'. :)

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
