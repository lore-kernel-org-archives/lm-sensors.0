From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Mar 2013 12:24:00 +0000
Subject: Re: [lm-sensors] [PATCH v4 3/3] hwmon: add ST-Ericsson ABX500 hwmon driver
Message-Id: <20130312122400.GA24019@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1362730411-11112-4-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1362730411-11112-4-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 12, 2013 at 07:16:03PM +0800, Hongbo Zhang wrote:

[ .. ]

> 
> >> +             return -EINVAL;
> >
> > You'll want to return the original error code, which for example can be ENOMEM
> > where an error message is not needed. Also, I suspect abx500_hwmon_init might
> > at some point return -EPROBE_DEFER. If that ever happens, you definitely want
> > to fail silently and return the correct error code.
> >
> Yes, should return err in this probe function.
> Where to return -EPROBE_DEFER? when ab8500_gpadc_get() or
> ab8500_btemp_get() fails?
> In fact these two interfaces aren't so good, because we cannot tell
> the reason when they return fail.
> A solution I can imagine now is to send another separate patch for
> these two interfaces, letting them return -EPROBE_DEFER if they are
> not initialized when being called.
> 
Guess the point I am trying to make is that this is an external API (ie it calls
code in another module), and you don't know if and when -EPROBE_DEFER may be
returned. So you should always pass errors up the chain, unless there is a well
defined reason to not do so.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
