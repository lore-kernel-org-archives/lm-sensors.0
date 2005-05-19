From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: it87 pwm patch for 2.6.6
Message-Id: <20040608194427.4346e1fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516205100.GA9996@nemo.sby.abo.fi>
In-Reply-To: <20040516205100.GA9996@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Nice catching for TEMP_TO_REG, I completely missed that one. BTW,
> > now that I took a longer look at it, I really wonder how a negative
> > temperature limit could ever been set with this. Looks like it'll
> > end up with 0. OTOH, asking for a temperature higher than 127.5
> > degrees will most likely lead to "random" negative values. This is
> > probably true for both the 2.4 and the 2.6 driver as of now. Could
> > you please test and confirm? Most likely nobody cares about setting
> > negative limits, but while we're at cleaning up this part of the
> > driver...
> 
> Yep, testing (on 2.6) confirms this, fixed it.

Care to provide a similar fix for 2.4?

> Btw, "grep SENSORS_LIMIT drivers/i2c/chips/*.c|grep 127" shows that
> lm85.c has a rounding error in it's TEMP_TO_REG() macro (and probably
> in at least one other place).

Correct. BTW, the same grep shows that rounding is probably missing in
EXTTEMP_TO_REG and OFFSET_TO_REG of the same driver. Feel free to submit
a patch to Greg that fixes this. If a similar fix is required for 2.4
(and most likely it is), a patch will of course be welcome as well.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
