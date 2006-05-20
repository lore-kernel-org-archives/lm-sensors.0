From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 20 May 2006 09:03:13 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <20060520110313.ac25eab9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <446DF157.80805@t-online.de>
In-Reply-To: <446DF157.80805@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harald,

> > I didn't look at the datasheet for your chip yet (no time for this
> > sorry) so I can't tell you exactly which driver to start from. But this
> > should be an i2c-only driver (no platform driver, and no i2c-isa
> > trick.) Maybe lm90 will do, as it's both simple and up-to-date with
> > regards to recent changes. And you can always peek at other drivers for
> > the features your chip has and lm90 doesn't.
> 
> I have started working on this (but please don't expect too much).
> One question about the I2C_DRIVERID_* macros in i2c-id.h: Where
> could I get an ID for the f75387 driver?

You don't need any. id is an optional field, just set it to 0 (the
default for a statically declared structure anyway) and it'll be fine.

-- 
Jean Delvare

