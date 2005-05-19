From: pavel@suse.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: sensors in 2.5.54!!!
Message-Id: <20030106112038.GF27239@atrey.karlin.mff.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E17A4B8.8060706@paradyne.com>
In-Reply-To: <3E17A4B8.8060706@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

> The patch for i2c-amd756, i2c-amd8111, adm1021, and lm75,
> submitted by Pavel Machek, has been included,
> with modifications, in kernel 2.5.54 by Cristoph Hellwig.
> As you can see from the patch notes below, there were
> several modifications to the drivers and to the i2c core.
> 
> Any volunteers to work with Cristoph to feed more drivers in?
> Pavel?

I'm slowly catching up on email flood. I'm unlikely to be mass-porting
drivers, but I might port those needed for my boxes, in 4 weeks or so.

> Also note that the drivers went into i2c/busses and i2c/chips,
> so I think that solves that debate. I'll update our
> makefiles and mkpatch to put them there and remove
> old modules in i2c/ and sensors/ .

Heh, that was probably me who did that... I did not know I was doing
decision ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
