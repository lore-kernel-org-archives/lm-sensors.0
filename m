From: kronos@kronoz.cjb.net (Kronos)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: I2C DDC display
Message-Id: <20040228172816.GA909@dreamland.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
In-Reply-To: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Il Sat, Feb 28, 2004 at 08:02:00AM -0800, Jon Smirl ha scritto: 
> --- Jean Delvare <khali@linux-fr.org> wrote:
> > > I see that I can replace the probe function in the monddc driver with
> > > this probe function. But I don't know enough about DDC and I2C to
> > > really under what it's trying to do to the I2C bus. Can this probe
> > > function be turned into a generic form where it uses something like
> > > i2c_smbus_xfer() instead of directly playing with the bus ioports?
> > 
> > In fact I don't think you can do anything at all at the chip driver
> > level. I guess that the strange procedure in radeonfb_i2c.c is there to
> > "activate" the DDC eeprom, i.e. make it appear on the bus. As long as
> > nothing appears on the bus, the chip driver's detect function won't be
> > called at all! This is due to the i2c subsystem architecture we have in
> > the Linux kernel. So you cannot hope to be able to reproduce the trick
> > in the chip driver. It belongs to the bus driver (unless we change the
> > architecture).
> 
> The wake up should go in the chip driver not the bus driver. It's not a problem
> with the bus, it a problem with the chip on the bus. Putting it in the bus
> driver means we need to add it to the bus driver for every video card instead if
> just once in the chip driver.
> 
> This gets called once per bus so the code to wake up the chip could be put here.
> 
> 
> int ddcmon_attach_adapter(struct i2c_adapter *adapter)
> {
> 	return i2c_detect(adapter, &addr_data, ddcmon_detect);
> }
> 
> 
> But now I don't know enough about i2c to rewrite the following code in generic
> terms using the i2c_adapter operations instead of direct IO port actions.

Hum, I can rewrite it using sda/scl operation, it's quite simple. But I
don't think that the code is generic. When I wrote the adapter I decided
to leave that stuff around just to be sure, but it does work without
that black magic (ie. with only radeon_do_probe_i2c_edid), al least on
my setup (R300 + analog LCD).

Also, I don't think that is safe to attach a client to radeon DDC busses (yet). 
During probe I fiddle directly with the adapter (without any locking),
if another client kicks in I fear that it will blow up. radeonfb should
register its own clients for probing EDID, it's in my TODO list.

Luca
-- 
Home: http://kronoz.cjb.net
La differenza fra l'intelligenza e la stupidita`?
All'intelligenza c'e` un limite.
