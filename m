From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 05 Dec 2014 16:47:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Strengthen detect function
Message-Id: <20141205164724.GA2633@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Dec 05, 2014 at 04:15:41PM +0100, Jean Delvare wrote:
> On Fri, 05 Dec 2014 06:14:00 -0800, Guenter Roeck wrote:
> > > Did sensors-detect misdetect that chip as an LM75 too, or was the
> > > extended detection logic there good enough already?
> > 
> > sensors-detect is fine. Easy to test -load i2c-stub and see what
> > happens.
> 
> That doesn't always work because the value returned for some
> non-existent register addresses depend on the previous read. You can

Good point.

> only test that with a real chip. Plus I didn't know which chip was
> being misdetected for you ;-)
> 
I was trying to run a module test for tmp421 while having the lm75 driver
loaded. Loading the i2c-stub driver with address 0x4c caused lm75 detection
to run, which detected the simulated chip at 0x4c as lm75 (because all
registers in i2c-stub are initially set to 0) and instantiated it. This of
course was a bit of a bummer when I tried to manually instantiate the tmp421
afterwards, causing my module test to fail. So it wasn't a real chip, just
an annoying side effect of trying to use i2c-stub while the lm75 driver
was loaded.

> > I assume that is due to the "All registers hold same value"
> > test. Should I use that test instead ? I kind of prefer it.
> 
> The tests are different and thus may result in different outcomes for
> various chips. It's very hard to predict which is better. All I can say
> is that the sensors-detect code needs the value of the current
> temperature register, which isn't read during detection currently, so
> using that logic would make driver loading slightly slower. Not sure if

Good point.

> it really matters.
> 
> All in all, I think that having the same detection code on both side is
> important, as it avoids unexpected results. I don't really care which
> one you pick, it can always be adjusted later (as is has already been
> over the years) if misdetections are reported.
> 
Guess I'll apply the patch as-is. If anything I wonder if it would make sense
to add the same test to sensors-detect (in addition to the comparison).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
