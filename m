From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Jan 2011 22:11:59 +0000
Subject: Re: [lm-sensors] aftermarket PCI or ISA monitoring board?
Message-Id: <20110109231159.3c92e0cb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D28AA8D.7080902@hardwarefreak.com>
In-Reply-To: <4D28AA8D.7080902@hardwarefreak.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 9 Jan 2011 09:41:11 -0800, Guenter Roeck wrote:
> On Sun, Jan 09, 2011 at 06:44:08AM -0500, Jean Delvare wrote:
> > Hi Stan,
> > 
> > On Sat, 08 Jan 2011 12:18:53 -0600, Stan Hoeppner wrote:
> > > Please CC me as I'm not subscribed to the list.  I'd like to know if
> > > there are any PCI or ISA boards designed for thermal monitoring on the
> > > market that work with lm-sensors.  My Googling so far has been fruitless.
> > > 
> > > Basically I'm looking for an (inexpensive, and by this I mean less than
> > > the price of a consumer mobo) add in PCI/ISA card that will work with
> > > lm-sensors, one that has thermistor wires one can attach to a north
> > > bridge chip heatsink, hard drive, etc.  There are many examples on the
> > > market of such thermal monitoring devices, but all I've seen simply
> > > provide an LCD display and mount in a drive bay.  This may be fine for a
> > > desktop PC, but I'm wanting to monitor some temps remotely, temps of
> > > components not monitored by the motherboard monitoring chip.
> > 
> > I don't know of any such board, sorry.
> > 
> I think that will require two steps - interface to i2c first, then to sensors.

Not necessarily. The SMBus is routed over PCI, so it would be possible
to simply use the motherboard's SMBus controller.

> One could use something like Calibre PCI93LV/C (expensive) and write a driver
> for it (if the vendor is willing to release the card specification), Quancom
> PCIPROTO or similar, or use a USB-I2C interface card such as Diolan U2C-12.
> Either would require some additional work to add actual sensors.

USB or parallel port solutions certainly exist and are already
supported, but that would be external when it seems Stan is after an
internal solution.

> I use Diolan U2C-12 and made a little board with a max6696 using Schmartboard
> test boards. That was quite straightforward.

If soldering things is an option, then many recent boards have an SMBus
header, so it would be possible to choose any supported SMBus-based
hardware monitoring device and wire up everything manually.

Still, I am curious why nobody thought of manufacturing a hardware
monitoring system in PCI format. This would be very easy to implement,
and I'm sure computer enthusiasts would be interested.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
