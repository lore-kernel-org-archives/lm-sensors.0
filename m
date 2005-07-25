From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 25 Jul 2005 19:28:36 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers
Message-Id: <20050725192827.0b166d1e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050719233902.40282559.khali@linux-fr.org>
	<20050719234843.14cfb1ec.khali@linux-fr.org>
	<20050720042755.GD26552@kroah.com>
	<20050720234603.2b66560d.khali@linux-fr.org>
	<20050725003551.GE9824@kroah.com>
In-Reply-To: <20050725003551.GE9824@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Greg,

> Ah, much better, thanks.  Sounds like a great plan, I'll go apply your
> patches in a day or so when I catch up from my travels.

OK, thanks.

Note that there are a few patches which you should apply before this
series, in particular Mark Hoffman's 3 hwmon class patches. There are no
hard dependencies between both series but applying them in order is
likely to ease your work.

You can take a look at my current stack here for reference:
http://khali.linux-fr.org/devel/i2c/linux-2.6/series

Not everything is i2c or hwmon related, but that should give you an idea
of which order you should apply them in to keep the noise to a minimum
level. There might be a number of individual patches that I did not post
yet, because I was waiting for you to apply Mark's stuff first. Just let
me know when you're done with the hwmon class patches and everything
else you might have on your end, and I'll post all other patches - after
I checked that they properly apply on top of what you have.

Thanks,
-- 
Jean Delvare
