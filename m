From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Sep 2007 07:59:45 +0000
Subject: Re: [lm-sensors] [patch lm-sensors 2.10.4] i2cdetect mislabels PEC
Message-Id: <20070919095945.2d2263bb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Tue, 18 Sep 2007 15:45:36 -0700, David Brownell wrote:
> > > -	  .name = "SMBus PEC" },
> > > +	  .name = "SMBus PEC in Hardware" },
> >
> > I agree that the current situation is confusing, I had noticed this
> > already when reworking the PEC support in 2.6.15, but postponed fixing
> > it.
> >
> > However, I don't think that what you proposed is the proper fix. We
> > don't care whether PEC is implemented in hardware or software. What
> > really matters is whether it is implemented at all, or not. So I'd
> > rather rename I2C_FUNC_SMBUS_HWPEC_CALC to I2C_FUNC_SMBUS_PEC, and have
> > i2c-algo-bit and other drivers declare that they support it. What do
> > you think?
> 
> How about just not exposing that capability from i2cdetect at all?
> 
> There's a software implementation that's always available.  Whether
> that's used, or a (presumably accelerated) hardware one is used is
> purely an implementation issue, not an interface issue that a driver
> would have any reason to care about.

This is not true. Software PEC support is only available for adapters
emulating SMBus support using I2C-level messaging (e.g. i2c-algo-bit.)
For non-I2C SMBus masters, PEC support is there only if the hardware
explicitly supports it, it cannot be emulated. For example the Intel
ICH3 can't do PEC. That's the reason why having a functionality bit for
SMBus PEC makes sense.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
