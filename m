From: "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
Date: Mon, 22 Apr 2013 01:14:26 +0000
Subject: Re: [lm-sensors] [NEW DRIVER V6 6/7] drivers/hwmon: DA9058 HWMON driver
Message-Id: <24DF37198A1E704D9811D8F72B87EB514191F1F7@NB-EX-MBX02.diasemi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201304191712.r3JHCEmr017829@latitude>
 <51718BFE.7060409@metafoo.de> <20130420173513.GA8275@roeck-us.net>
In-Reply-To: <20130420173513.GA8275@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>, Jean Delvare <khali@linux-fr.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Randy Dunlap <rdunlap@xenotime.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>

> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: 20 April 2013 18:35
> To: Lars-Peter Clausen
> Cc: Opensource [Anthony Olech]; Jean Delvare; Mark Brown; Randy Dunlap;
> lm-sensors@lm-sensors.org; LKML; David Dajun Chen
> Subject: Re: [NEW DRIVER V6 6/7] drivers/hwmon: DA9058 HWMON driver
> On Fri, Apr 19, 2013 at 08:25:02PM +0200, Lars-Peter Clausen wrote:
> > Same comment as before, I'd like to see this using the generic IIO to
> > HWMON bridge instead of recreating it.
> ... and I agree. Seems we are getting more and more of those, and at some
> point it makes really sense to find a generic solution.
> Anthony, can you please look into that ?
> Thanks,
> Guenter

OK -- generic IIO to HWMON bridge

I will investigate - but if you know any prototypes or any useful starting point could you let me know as I don't want to re-invent the wheel.

Thanks,

Anthony Olech

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
