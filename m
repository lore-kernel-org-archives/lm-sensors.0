From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 23 Sep 2006 20:58:23 +0000
Subject: [lm-sensors] Intel DG956RY motherboard with LPC47M182
Message-Id: <20060923225823.bd26a578.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1158983695.9242.3.camel@ubuntu.gghcwest.com>
In-Reply-To: <1158983695.9242.3.camel@ubuntu.gghcwest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeffrey,

> On Sat, 2006-09-23 at 13:32 +0200, Jean Delvare wrote:
> > Hi Jeffrey,
> > 
> > > > I have an Intel DG965RY motherboard, which the lm-sensors in Ubuntu Edgy
> > > > does not seem to support.  I received a message from Rudolf Marek by way
> > > > of Andrew Barr that I should examine the chips near the floppy connector
> > > > and mail it here.
> > > > 
> > > > The chip near the floppy connector is an SMSC LPC47M182.  I did not see
> > > > any other integrated circuits in that area of the motherboard.
> > 
> > This is your Super-I/O chip. I found datasheets on www.smsc.com for the
> > LPC47M112, LPC47M172 and LPC47M182 (thanks SMSC!). It appears that the
> > latter two only support minimalist fan speed monitoring - two 16-bit
> > fan speed values, no low limit, no control. This chip may or may not be
> > used for actual fan speed monitoring on your specific system.
> > 
> > Do you see any fan speed or temperature values in your BIOS setup
> > screen?
> 
> Yes, actually there are four fan tachometers in the BIOS, in addition to
> the CPU temperature, the MCH temperature, the ICH temperature, and three
> ambient air temperature sensors.

The LPC47M182 only supports 2 fans, so I'm pretty certain it isn't
actually used for hardware monitoring on your machine.

> I tried to take a photograph of the motherboard.  This is the best
> result I could get:
> 
> Warning: 15.5MB TIFF image!
> http://tastic.brillig.org/~jwb/DG965RY.tiff

Ever heard of JPEG compression? ;)

> I've identified every significant integrated circuit in that photo.
> There's an IDT clock generator, an On Semi PWM voltage reg for the CPU,
> a TI RS232 chip, a TI 1394a controller, a Sigmatel audio CODEC, the
> Intel NIC, a Marvell PATA controller, and the aforementioned SMSC super
> i/o.  I checked under all three heat sinks, and there's nothing under
> there aside from the CPU, the MCH, and the ICH.

I suspect that the sensors are inside (or at least driven by) the ICH
itself. The ICH8 datasheet mentions 4 fan tachometer inputs, 3 fan
control outputs (PWM), and two new busses to connect thermal sensors
(SST and PECI).

The bad news is that we don't support any of these bleeding edge
technologies at the moment.

-- 
Jean Delvare

