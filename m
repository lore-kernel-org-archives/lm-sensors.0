From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 28 Oct 2013 20:19:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: lm73: reset device during lm73_probe()
Message-Id: <20131028201954.GA13849@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 28, 2013 at 11:48:46AM -0700, Chris Verges wrote:
> On Mon, Oct 28, 2013 at 10:35:18AM -0700, Guenter Roeck wrote:
> > On Mon, Oct 28, 2013 at 09:05:05AM -0700, Chris Verges wrote:
> > > The LM73 datasheet recommends resetting the sensor at power-up to
> > > avoid certain VDD ramp-up problems.  The full sequence and rationale
> > > is described in the LM73 datasheet, May 2009 revision, page 19,
> > > section "Power Supply Ramp-Up Considerations."
> > 
> > common assumption is that the chip is enabled and pre-configured by
> > the BIOS or ROMMON.  If so, this code is unnecessary and just adds
> > 100+ ms to the system boot time for each LM73 sensor. I don't think
> > that would be a good idea.
> > 
> > The datasheet says "... In systems where there is a large amount of
> > capacitance on the VDD node, the LM73 power supply ramp-up time can
> > become excessively long", which is defined as "A linear power-on-ramp
> > of less than 0.7V/msec and an exponential ramp with an RC time
> > constant of more than 1.25 msec is categorized as a slow power-supply
> > ramp". The soft-reset is only required if this is the case.
> > 
> > Are there indications that this condition is actually seen on real
> > hardware, and not taken care of by the BIOS/ROMMON?
> 
> Yes, I encountered this problem on an embedded system and discovered the
> note in the datasheet as part of the debugging of that problem.  The
> LM73 started returning random, sporadic temperature readings as a result
> of VDD being ramped too slowly.  The app note's tone makes the
> recommendation sound like the TI-preferred methodology of device
> initialization for guaranteed behavior, and so modifying the probe()
> directly seemed like a better choice than relying on the user to know to
> enable this functionality via module params, platform data, or
> devicetree properties.
> 
It is not acceptable to affect everyone because one embedded system
vendor violates voltage ramp-up time for this chip.

The embedded system should have its well defined configuration, and support
devicetree and/or platform initialization code. So adding it through one
or both of those methods should be straightforward. The (end-)user should
not have to be involved; the company providing the system should.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
