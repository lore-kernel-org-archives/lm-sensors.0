From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 05 Dec 2014 15:15:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Strengthen detect function
Message-Id: <20141205161541.1be749a3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 05 Dec 2014 06:14:00 -0800, Guenter Roeck wrote:
> > Did sensors-detect misdetect that chip as an LM75 too, or was the
> > extended detection logic there good enough already?
> 
> sensors-detect is fine. Easy to test -load i2c-stub and see what
> happens.

That doesn't always work because the value returned for some
non-existent register addresses depend on the previous read. You can
only test that with a real chip. Plus I didn't know which chip was
being misdetected for you ;-)

> I assume that is due to the "All registers hold same value"
> test. Should I use that test instead ? I kind of prefer it.

The tests are different and thus may result in different outcomes for
various chips. It's very hard to predict which is better. All I can say
is that the sensors-detect code needs the value of the current
temperature register, which isn't read during detection currently, so
using that logic would make driver loading slightly slower. Not sure if
it really matters.

All in all, I think that having the same detection code on both side is
important, as it avoids unexpected results. I don't really care which
one you pick, it can always be adjusted later (as is has already been
over the years) if misdetections are reported.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
