From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [PATCH] ds1337 4/4
Message-Id: <20050410231006.0469a472.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407231904.GE27226@orphique>
	<FxPJVIPZ.1112958526.4787880.khali@localhost>
	<20050408123545.GA4961@orphique>
	<4256C315.3000902@katalix.com>
	<20050410195120.GA5422@linux-mips.org>
In-Reply-To: <20050410195120.GA5422@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <greg@kroah.com>, James Chapman <jchapman@katalix.com>

Hi Ladislav,

> Driver has no chance to know about hardware design.

If you want the driver to somehow interact with the battery charging
register, it will have to. We just can't let the user write random value
to this register.

> Based on your and Jean's input, following so far sounds reasonable:
> Create "charge" sysfs entry for ds1339 when it is detected. Do not
> write any value to Trickle Charge register, until its value is written
> to this entry.

While I admit I had this in mind in the first place, the more I think of
it and the less I like it. It's slightly better than changing the
charging rate right when loading the driver, but that's still dangerous.
Users could write a value which doesn't match the hardware design, and
bad things could happen.

> Agree, but with probability near the certainty I can tell that device
> works a bit differently than described in datasheet. Anyway, new 100%
> reliable test is done, so it could be eventually used if ds1339
> support finds its way into driver.

"100% realiable" here means that it works for you, which isn't enough.
At least James would have to check how it works with his DS1337, and
there might be other revisions of both chips which behave differently.
There might be other mostly-compatible chips in the game too.

> > > Eh? Register is 8bit, that's 256 combinations.
> > 
> > Reserved bits have fixed values that you can test for.
> 
> Think about this register as about NVRAM address. It can have any
> value, but only certain values will enable charge.

Most of which nobody has any interest in writing. Some I2C devices are
hard to detect and the DS1337/DS1339 are of these. We use the tricks we
find. Sure, a strict check on this register might miss a DS1339, but
that's better than detecting a different chip as a DS1339.

> How are you using this driver? There is non-static function
> ds1337_do_command which expects id. How do you know which id belongs
> to which chip?

I second this question, as it stroke me too. This function doesn't sound
exactly usable to me. Identifying the device by bus and address would
make more sense than an arbitrary id you have no way to learn about.

> Do you actually have machine with more than one ds1337?
> Chip has fixed address, so only one can hang on one bus (am I right?)

You are.

> PS. I'm sorry about some formulations I used in earlier mails. I was
> overworked and tired and that affected my otherwise (hopefully) good
> decorum :)

I'm really happy to read this :) You are of course forgiven. We all have
bad days.

Back to the issue, some random thoughts summarizing my opinion:

1* Initializing the battery charge register is a firmware/bios issue, as
you underlined earlier. It would make sense (and would be easier) to
just ignore it at the driver level.

2* If it makes sense to stop the charge, then we should provide a simple
*switch* to the user, from the default charging register value (as
previously set by the firmware/bios) to 0 and back. The switch would
probably be a sysfs file unless a different API already exists.

3* Having the driver write an arbitrary non-0 value to the register
should not be done unless the system has been identified. I have no idea
how your system can be identified (DMI?), but if it can't, then I'd
better see the register ignored altogether.

4* Remember that you can always write a simple C tool relying on the
i2c-dev interface to do the job. The advantage of this approach is that
you can put big fat warnings and request user confirmation before any
action.

Hope that helps,
-- 
Jean Delvare
