From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 07 Jun 2006 08:03:49 +0000
Subject: [lm-sensors] Black box flight recorder for Linux
Message-Id: <20060607100349.a990e054.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44379AB8.6050808@superbug.co.uk>
	<m3psjqeeor.fsf@defiant.localdomain>
	<443A4927.5040801@warmcat.com>
	<m3zmgqxjs8.fsf@defiant.localdomain>
In-Reply-To: <m3zmgqxjs8.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Andy Green <andy@warmcat.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Krzysztof, Andy,

Andy Green writes:
> > Just an additional thought on this idea... both VGA and DVI connectors
> > on modern video cards appear to have DDC-2 connections, which is in
> > fact I2C.  This would provide an (inherently bidirectional :-) ) 3-pin
> > digital interface out of a mostly dead box even on laptops and so on
> > with no serial, parallel or legacy keyboard/mouse, so long as they had
> > reasonably modern VGA or DVI out.  You would need to get access to the
> > two I2C pins and Gnd somehow in that scenario.   Since I2C has a
> > concept of addressing it should be possible to choose I2C addresses
> > for this communication that doesn't address whatever may be listening
> > on the same bus in the monitor.

Krzysztof Halasa  answers:
> I think I like the idea and have some (not yet finished but working)
> code. Any comments?
> 
> The first part is the "console" driver (obvious parts removed). It works
> with both my Asus A7V333 (VIA KT333, VIA SMBUS driver) and with VGA DDC
> interface on a Cirrus Logic GD 5446 VGA chip (simplified source attached
> as well). Using respectively 2464 and 24512 set to ID 0x57.

How do you intend to connect your device to the DDC channel if there's
already a monitor connected to the VGA or DVI port?

Beware that many monitors have EDID EEPROMs responding to all I2C
addresses within the 0x50 - 0x57 range, so it'll be hard to add an
EEPROM on the bus for your own purpose without hitting an address
conflict.

> The following is an adapter for Cirrus Logic 5446 VGA on my old R440LX
> test machine:
> 
> There is a locking problem - the VGA is (can be) shared between VT console,
> X11 and the driver. I'll look at CL FB driver to see how/if it's done.

The current trend is to merge the DDC access driver into the
framebuffer driver. This solves one of the conflicts, and also makes
sense because the EDID data can be used to automatically setup the
framebuffer. We still have a few standalone DDC access drivers
(i2c-i810, i2c-savage4...) but they are considered deprecated and will
probably be deleted in a near feature.

This will be a second problem for you though. Most distributions don't
make use of hardware-specific framebuffer drivers by default, but use
the VESA framebuffer driver. This driver doesn't have DDC support.

Note that I am not trying to dicourage you, Andy's idea has merit for
sure. I just mean that it won't be usable by everyone out of the box.
People will have to use the right driver and pay attention to address
conflicts.

-- 
Jean Delvare

