From: Uwe_Zeisberger@digi.com (Uwe Zeisberger)
Date: Thu, 02 Feb 2006 08:39:35 +0000
Subject: [lm-sensors] [PATCH] I2C: add new rx8025 driver
Message-Id: <20060202083935.GA28876@digi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060201102335.GA8223@digi.com>
In-Reply-To: <20060201102335.GA8223@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

thanks for all your suggestions, I'll go through them.  I agree to most
of your suggestions.  I don't comment on those and just prepare a new
patch.  Some of them are mortifying, sorry for them.  (Actually I put in
these to check how exact the reviews are.  You passed ;-)

Jean Delvare wrote:
> > below is a patch adding support for the Epson RX8025 SA/NB RTC module.
> 
> First of all: where is this chip found?
This is a driver I wrote for a custom SoC.  Otherwise Google found one
or two mails by people having ported the rtc8564 driver to the rx8025
chip.  

> Have you verified if this chip isn't compatible with other chips we
> have drivers for already?
I just compared with the rtc8564 driver as I didn't expect to match that
chip.  In retrospect this proofs true.  (I compared with the kconfig
symbols in drivers/i2c/chips that have [Rr][Tt][Cc] in their
description.  Did I miss anything?)

> >  - There exists a RTC driver interface in include/asm-arm/rtc.h by
> >    Russell King.  Should I use it even if it's ARM specific?
> >    For now I used the ioctl interface directly.
> 
> See with Alessandro Zummo, he is working on a unified RTC core. Maybe
> you can simplify your code by using it.
He answered my mail, too.  I'll look into it.
 
> Don't initialize a static global to NULL explicitly, the compiler will
> do it for you.
I'm not fluent in the different C variants, so I usually prefer to
explicitly initialize static global variables with NULL, too.

> > +	if(down_interruptible(&rx8025_lock))
> > +		return -ERESTARTSYS;
> [...], what exactly are you protecting with this mutex?
rx8025_clients and rx8025_rtcclient.  Maybe I can get rid of it when
using Alessandro's RTC core.
 
> > +	/* according to the documention read-only-bits read as 0 */
> > +#define CHECK_ROBITS(reg, mask)						\
> > +	if (unlikely(result[2 + (reg)] & ~(mask))) {			\
> > +		dev_warn(&rx8025_rtcclient->dev,			\
> > +				"value for " #reg " out of spec: %x\n",	\
> > +				result[2 + (reg)]);			\
> > +		result[2 + RX8025_REG_SEC] &= (mask);			\
> > +	}
> > +	CHECK_ROBITS(RX8025_REG_SEC, 0x7f);
> > +	CHECK_ROBITS(RX8025_REG_MIN, 0x7f);
> > +	CHECK_ROBITS(RX8025_REG_HOUR, 0x3f);
> > +	CHECK_ROBITS(RX8025_REG_WDAY, 0x07);
> > +	CHECK_ROBITS(RX8025_REG_MDAY, 0x3f);
> > +	CHECK_ROBITS(RX8025_REG_MONTH, 0x1f);
> 
> Since you end up checking all unused bits regardless of what the
> datasheet says, it would be more efficient - and more readble - to just
> mask the values you read.
While developping I observed that having some of these bits set results
in wrong transitions.  So I want to warn about it.  I put the masking in
the if body to have CHECK_ROBITS expand to one statement (without doing
do {...} while(0)).  Maybe it's sensible to move that check to the
detection phase as you suggested.
 
> Use "client" instead of "new_client" please. Another legacy we try to
> get rid of.
That was one that astonished me, too.  I just did that to be consistent.
 
> > +	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> > +		dev_dbg(&adapter->dev, "doesn't support full I2C\n");
> > +		goto errout;
> > +	}
> 
> Given that all block transfers you do are standard I2C block transfers,
> you may consider switching to i2c_smbus_{read,write}_i2c_block_data for
> SMBus compatibility. This would also make your code more simple, I
> think.
Well I just found out the SMBus interface may match my needs when I
posted the driver.  I'm not sure about the transfer in
rx8025_get_rtctime.  In the spec this is called "Simplified read method"
so I have to check if the interface suits.  (But OTOH the chips supports
the "Standard read method for I2C bus", too, so there should be no
problem.)  The difference is that I don't have to sent "restart",
slave address and read bit as part of the request.

> > +	new_client->flags = 0;
> 
> Not needed, as you've kzalloc'd the client structure.
That's a relict,  the driver was initially developped for 2.6.12.5.
kzalloc is newer.
 
> And feel free to add yourself in MAINTAINERS as the maintainer of this
> new driver if you want to take care of it in the future.
Yes, I want to, but I didn't hat the courage to do that when submitting
the first (non-trivial) patch.

Best regards and many thanks for your detailed review.
Uwe

-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com

