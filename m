From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Nov 2005 10:53:43 +0000
Subject: [lm-sensors] Re: [PATCH] hwmon : Fix W83627THF VID reading
Message-Id: <708XLy0L.1132565965.3759540.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB7@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB7@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

On 2005-11-20, Mark M. Hoffman wrote:
> * Jean Delvare [2005-11-15 12:16:52 +0200]:
> > While checking the W83627THF datasheet, I noticed that there is an
> > additional GPIO configuration register, CRF5, named "inversion
> > register". Wouldn't it make sense to check the value of this register
> > and make sure all pins supposedly used as VID inputs are not inverted?
> > Mark, can you please confirm that your system which does use GPIO5 for
> > VID would pass that test? Proposed patch attached, comments and testers
> > welcome.
>
> Your patch does work on my system, but... no, I don't think it means
> anything if the inputs are inverted or not.  The BIOS might set the inputs
> to inverted if the VID signals are inverted by hardware... which I would
> not consider to be unusual or unexpected.

I do consider it to be unexpected. The W83627HF cannot invert these pins
as far as I know, so if the W83627THF is supposed to be used as a
replacement for the W83627HF, the GPIO pins shouldn't be inverted.
Additionally, the VID signals are supposed to come directly from the
CPU, and if they do they cannot be inverted.

> Of course, it might just as well leave them *not* inverted *despite* that
> they are inverted in hardware... which suggests a new module option if
> anyone ever discovers such a board.

That would be a different problem (getting the proper value, as opposed
to properly guessing if the pins are used as VID inputs), although the
same reasons I gave above make me doubt this could actually happen.

> BTW: I tested by applying your current quilt stack (up to and including
> the improve-gpio5-test patch) to 2.6.15-rc2.

Great, thanks. I'll probably push upwards a part of it this week so that
it gets a broader testing in -mm.

--
Jean Delvare
