From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <20030925233238.45025c20.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > My position is that the driver should change as few things as
> > possible. Hardware monitoring chips are a sensible realm. Enabling
> > or disabling an interrupt line or the like can cause the hardware to
> > react (fan to full speed or even shutdown) and we have had many
> > reports that this happened. So I think that the chip drivers should,
> > by default, consider that the chip is well configured for the
> > hardware/bios settings, and initialize very few things. My drivers
> > work that way (not for the limits yet, but for the rest).
> 
> I agree, this should be our policy.  Any current 2.6 drivers that
> violate this?

Any does *not*? ;)

I took a look and here I go. When I say "this should/shouldn't be done",
I'm refering to "if we follow the policy described above", this is not
the Absolute Truth (TM). Bits counted from 0 (LSB) to 7.

adm1021:
Bit 7 of the configuration register (ALERT mask) should be preserved.

it87:
Chip should not be reset (configuration register bit 7). Bits 5-1 of
the configuration register should be preserved. Also, I would leave
the voltage channel enable register untouched (same goes for the
fans). I also would add extra checks to make sure that the
temperature channel enable register is valid (but that's another
point).

lm75:
Bits 1-2 of the configuration register should be left untouched.
Ideally, fault queue should be configurable, if not it should also
be left untouched (bits 3-4 of the configuration register).

lm78:
Chip should not be reset (configuration register bit 7). Bits 1-2,5
should be left untouched.

lm85:
This one is OK.

via686a:
Chip should not be reset (configuration register bit 7). Bit 1
(interrupt enable register) should be left untouched.

w83781d:
Chip should not be reset (configuration register bit 7). Maybe some
other writes should be avoided, but this driver is too complicated
for a quick review. Will need to be analyzed in deep.

So, as you can see, most drivers would need to be changed. However, the
policy I propose is only the way I see the things, but some people here
are much more experienced with evil monitoring chips than I am myself.
Although chip initialization has proven to cause problems, I guess it
may be even worse without it in some cases. I may provide a patch
against 2.6.0-test5 that converts initialization routines as described
above, but I just can't promise the conversions are what we all want.

One possible compromise would be to provide an init parameter for all
module, ranging from 0 to N, where N is 3 (but could depend on the
module after all). 0 wouldn't initialize anything. 1 would initialize
the configuration registers. 2 would be 1 plus initialize limits to
default value. 3 would reset the chip plus 1 and 2. Or we may decide
that init is a bit vector, where 1<<0 resets the chip, 1<<1 sets the
limits, 1<<2 sets the configuration, (order to be defined) and so on.
I'd like to hear opinions about that. My purpose here is to provide a
standard way for the user to force a given init if the default (which
would probably depend on the driver) doesn't for for him/her. This would
make me feel more comfortable with changing the default initialization.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
