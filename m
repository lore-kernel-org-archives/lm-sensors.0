From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 31 Aug 2011 15:27:55 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (pmbus) Fix the logic of
Message-Id: <1314804475.2455.17.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314766699.3960.1.camel@phoenix>
	 <20110831120513.31bb62ee@endymion.delvare>
	 <CAF+7xWnDSTOJh9cs9tUJdF=k=TD56JN1cMvfNM_ng4vw5Gntyg@mail.gmail.com>
In-Reply-To: <CAF+7xWnDSTOJh9cs9tUJdF=k=TD56JN1cMvfNM_ng4vw5Gntyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "axel.lin@gmail.com" <axel.lin@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, 2011-08-31 at 10:30 -0400, Axel Lin wrote:
> 2011/8/31 Jean Delvare <khali@linux-fr.org>:
> > Hi Alex,
> It's Axel.
> 
> >
> > On Wed, 31 Aug 2011 12:58:19 +0800, Axel Lin wrote:
> >> If no id is matched, the mid pointer is not NULL in current implementation.
> >
> > The NULL check is presumably there to catch the (impossible) case
> > ARRAY_SIZE(ucd9000_id) = 0 (array of ids is empty), not the case "no
> > id is matched". The initialization of mid to NULL is for the same
> > reason. Both should be unnecessary but may have been motivated by a
> > compiler warning (although I would think gcc is smart enough to not
> > emit these when it can check that the array isn't empty.) Guenter
> > should be able to tell more.
> >
Yes, that was the idea, and as far as I recall I did get a compiler
warning at the time. The loop aborts at the last entry due to the
strncasecmp() match on the zero length string. Axel's patch won't work,
since i = ARRAY_SIZE(ucd9000_id) is never true for the same reason.

> > The check for "no id is matched" is !strlen(mid->name), which works as
> > intended as far as I can see. Did you actually hit a bug with the
> > current code? I bet not.
> No, I didn't hit the bug. Just reading the code.
> 
Finally someone else looking into that code ... thanks, I really
appreciate that.

> >
> > Now I would agree that the current code is somewhat misleading because
> > mixing null-terminated arrays with ARRAY_SIZE() is unusual (and
> > inefficient - the last iteration always fails.) Also, strlen() is
> > relatively slow and would rather be avoided when only testing if a
> > string is empty or not: it's faster to test for mid->name[0].
> >
> > So if anything I would propose the following changes (for performance
> > and readability, NOT bug fix), untested:
> Your fix looks good to me. ( Although I don't have the h/w for testing ).
> 
I like it too. I'll dig out my test boards and test it. Jean, care to
submit complete patches ? Otherwise I'll create a set myself and send it
out for review once I tested it.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
