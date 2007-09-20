From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Sep 2007 11:02:58 +0000
Subject: Re: [lm-sensors] [patch lm-sensors 2.10.4] i2cdetect mislabels PEC
Message-Id: <20070920130258.7f87c2b9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 19 Sep 2007 14:55:37 -0700, David Brownell wrote:
> At some point, Jean Delvare wrote:
> > However, I don't think that what you proposed is the proper fix. We
> > don't care whether PEC is implemented in hardware or software. What
> > really matters is whether it is implemented at all, or not. So I'd
> > rather rename I2C_FUNC_SMBUS_HWPEC_CALC to I2C_FUNC_SMBUS_PEC, and have
> > i2c-algo-bit and other drivers declare that they support it. What do
> > you think?
> (...)
> Right ... then your suggestion above would seem to be The Answer,
> although rather than modify algo-bit etc I'd just add that flag
> into I2C_FUNC_SMBUS_EMUL.  Maybe that's what you meant.

That's not what I meant, but this seems to be the right thing to do,
yes. This should make the patch pretty simple.

> The "rename" would presumably involve leaving the old symbol around
> for a while, deprecated so gcc warns when it's used.

Inside the kernel, we do not care. For the user-space interface through
i2c-dev (i.e. lm-sensors' i2c-dev.h), well... I do not expect anyone to
actually use this flag, except "i2cdetect -F". There's simply no
real-world use case for the old semantic that bit had. So I think you
can just rename it and be done with it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
