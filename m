From: kronos@kronoz.cjb.net (Kronos)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: I2C DDC display
Message-Id: <20040228182552.GA5124@dreamland.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
In-Reply-To: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Il Sat, Feb 28, 2004 at 06:54:08PM +0100, Jean Delvare ha scritto: 
> According to Jon, it's required only for some old monitors. BTW, Jon,
> where did you get this information from?

XFree driver.

> Frankly, I don't see the point in handling these old monitors. At least,
> I wouldn't support them unless someone specifically asks for it and
> provides enough information for us to do the right thing.

Agreed, I'll talk to Benh about this issue.

> As for where the code should be, I still think it is *not* possible to
> put it in the chip driver. If I understand it correctly, before the
> special sequence is send on the bus, the EDID does *not* respond to any
> I2C address. This means that the ddcmon driver will *never* be called.

That's not correct. You can remove the code that touches SDA/SCL but you
need to activate i2c bus first:

OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));

Btw, the voodoo code is the following:

radeon_gpio_setscl(chan, 1);
radeon_gpio_setsda(chan, 1);
/* Looks like a start */
radeon_gpio_setscl(chan, 1);
wait for radeon_gpio_getscl(chan); /* ack ? */
radeon_gpio_setsda(chan, 0);
radeon_gpio_setscl(chan, 0);
/* Stop ? */
radeon_gpio_setsda(chan, 1);

read EDID

radeon_gpio_setsda(chan, 0);
radeon_gpio_setscl(chan, 0);
/* Stop ? */
radeon_gpio_setscl(chan, 1);
wait for radeon_gpio_getscl(chan); /* ack ? */
radeon_gpio_setsda(chan, 1);
/* Start */
radeon_gpio_setsda(chan, 0);
radeon_gpio_setscl(chan, 0);
/* Stop again */

It seems pointeless to me, but it comes from XFree radeon driver. Can
you make any sense out of it?
                                                                                
> > Also, I don't think that is safe to attach a client to radeon DDC
> > busses (yet). During probe I fiddle directly with the adapter (without
> > any locking), if another client kicks in I fear that it will blow up.
> > radeonfb should register its own clients for probing EDID, it's in my
> > TODO list.
> 
> I have been trying it :) And it worked correctly. Anyway, the radeonfb
> driver only probes the EDID at startup, right? So accessing it later
> sounds safe.

radeonfb can be build as a module, and we have a preemptible kernel... doh!

> Thanks Kronos for entering the thread. I hadn't even realized you were
> subscribed to the list.

I'm not, but Jon put me on CC.

Luca
-- 
Home: http://kronoz.cjb.net
Let me make your mind, leave yourself behind
Be not afraid
