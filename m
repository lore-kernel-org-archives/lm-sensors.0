From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Feb 2015 00:13:13 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] kernel.h: add find_closest() macro
Message-Id: <20150226001313.GA14592@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424799734-2170-1-git-send-email-bgolaszewski@baylibre.com>
 <1424799734-2170-2-git-send-email-bgolaszewski@baylibre.com>
 <CAAek22F3JzWRVqwf=QdaoowjTSkfHAiUP6orpHpcdt_gicaT=A@mail.gmail.com>
 <20150224205125.GB18025@roeck-us.net>
 <CAMpxmJVUcuyLJ9ju0U8kMg6AEFYijF8=_yHgYF7EMV63qbLCmg@mail.gmail.com>
In-Reply-To: <CAMpxmJVUcuyLJ9ju0U8kMg6AEFYijF8=_yHgYF7EMV63qbLCmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Phil Pokorny <ppokorny@penguincomputing.com>, LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Wed, Feb 25, 2015 at 11:59:51AM +0100, Bartosz Golaszewski wrote:
> 2015-02-24 21:51 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> > I think the lm85 conversion actually introduces a bug with such an
> > off-by-one mistake. And if it doesn't, there is still a unexplained
> > and not easy to understand '-1' in one of the calls to find_closest().
> >
> > So the question is if the new code really improves the situation in that
> > respect.
> 
> Yes, it's a mistake. I couldn't test this one and missed this '-1'.
> Sorry for that.
> 
> As for the size comparisons - at first glance it seems as if it adds bloat:
> 
> ina2xx:
> add/remove: 0/0 grow/shrink: 1/0 up/down: 24/0 (24)
> function                                     old     new   delta
> ina226_set_interval                          296     320     +24
> 
> lm85:
> add/remove: 0/0 grow/shrink: 3/0 up/down: 72/0 (72)
> function                                     old     new   delta
> set_temp_auto_temp_min                       364     388     +24
> set_temp_auto_temp_max                       336     360     +24
> set_pwm_freq                                 284     308     +24
> 
> w83795:
> add/remove: 0/0 grow/shrink: 1/0 up/down: 16/0 (16)
> function                                     old     new   delta
> store_pwm                                    496     512     +16
> 
> But this actually comes from DIV_ROUND_CLOSEST() since replacing it
> with a simple '/ 2' gives different results:
> 
> ina2xx.ko:
> add/remove: 0/0 grow/shrink: 1/0 up/down: 6/0 (6)
> function                                     old     new   delta
> __UNIQUE_ID_vermagic0                         73      79      +6
> 
> lm85.ko:
> add/remove: 0/0 grow/shrink: 1/0 up/down: 6/0 (6)
> function                                     old     new   delta
> __UNIQUE_ID_vermagic0                         73      79      +6
> 
> w83795.ko:
> add/remove: 0/0 grow/shrink: 2/0 up/down: 14/0 (14)
> function                                     old     new   delta
> store_pwm                                    496     504      +8
> __UNIQUE_ID_vermagic0                         73      79      +6
> 
> The idea however was to remove duplicated operations from source files
> and prevent off-by-one bugs (how ironic the lm85 patch...), not really
> to reduce size.
> 
I don't know, seems to me it can cause more trouble and potential for getting
something wrong than it is worth. I'll definitely want to see feedback (and
acceptance) from more senior maintainers than myself.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
