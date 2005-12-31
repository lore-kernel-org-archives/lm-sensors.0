From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 31 Dec 2005 19:12:16 +0000
Subject: [lm-sensors] w83627ehf fan controll?
Message-Id: <20051231201216.0db828bd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051230143805.GA21201@Apollo>
In-Reply-To: <20051230143805.GA21201@Apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan & all,

> I have add some entries to test the chip (in my local CVS), But I have
> not finished the test. Did anyone do the same work on this driver?

A number of persons are supposedly working on improving this driver.
Cadu said he would improve the driver back in July but we didn't hear
back since. I think Rudolf has a W83627EHF chip and may be willing to
help too. And I also seem to remember that Aurelien has such a chip and
wanted to help with the driver some times ago.

It's rare to have that many persons working on the same driver, so it's
quite sad that nothing has been merged into the driver yet :(

If you have a patch to contribute, please do! :)

> Actually I'm quiet confusing about the naming rule of device file, it
> did not cover all the PWM/SmartFan functions.

Same old story. We tried to standardize the PWM interface, but in the
end nobody seems to be happy with that standard. I'm a bit tired of all
this, so just implement any interface you like as long as it makes
sense. All I am asking for is that fan stopped is PWM=0 and fan at full
speed is PWM%5.

> And how about to backport w83627ehf driver to lm_sensors2 , Or there's
> no need to do it....

Until a user asks for it, I consider there is no need. If several users
do ask for it and someone wants to work on backporting it, fine with
me. But this is a recent chip and the 2.4 kernel is aging, so I
wouldn't be surprised if we had no request for a backport, ever.

As far as I am concerned, I started working on the w83627ehf driver
long ago because I happened to have some spare time and someone needed
support for that chip, but as I do not have a chip to test this driver,
it's really better is someone else goes on working on the driver. And I
also don't have that much spare time these days, as most of you
probably have noticed already.

Thanks,
-- 
Jean Delvare

