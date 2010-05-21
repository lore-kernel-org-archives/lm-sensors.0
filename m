From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 21 May 2010 14:47:57 +0000
Subject: Re: [lm-sensors] [RFC] [PATCH] TMP105 : Driver support for the
Message-Id: <20100521164757.50186c8f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <0680EC522D0CC943BC586913CF3768C003B32B3AC4@dbde02.ent.ti.com>
	<4BF687A0.4040203@jic23.retrosnub.co.uk>
	<4BF687DC.7090108@jic23.retrosnub.co.uk>
In-Reply-To: <4BF687DC.7090108@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, 21 May 2010 14:17:16 +0100, Jonathan Cameron wrote:
> cc'ing lm-sensors (where this should have gone, this has nothing to do with input).
> > On 05/21/10 13:17, Datta, Shubhrajyoti wrote:
> >>
> >> Adds the driver support for the TMP105 temperature sensor device. The interface is I2C.The driver supports the read of the temperature values.
> >>
> >> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > This device looks at first glance to be pretty similar to the TMP101 as supported
> > by the lm75 driver.  Would it make more sense to merge this support into that
> > driver?
> > 
> > I've not read the data sheets that closely so may have missed something!

We also have a brand new driver for the TMP102, so it might be worth
comparing with that one too.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
