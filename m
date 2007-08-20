From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Aug 2007 13:50:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070820155046.6c323864@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Sun, 19 Aug 2007 16:21:37 -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 19 Aug 2007, Jean Delvare wrote:
> > Thanks for pointing this out, indeed we need to make sure that the new
> > libsensors will work properly with the thinkpad_acpi driver and other
> > similar drivers. However I do not think that we need a special bus type
> > for these. The thinkpad_acpi driver instantiates a platform device (as
> > you mentioned yourself), and platform drivers are covered by the "ISA"
> > bus type in libsensors (for historical reasons mainly.)
> 
> This sounds a bit of an ugliness that might be best fixed, since it is a
> rare time window where one can actually do those.  If it is not too painful,
> why not add BUS_HOST to attach stuff that is not on PCI/PCIe, nor ISA, nor
> I2C/SMBUS?

I agree that it's the right time to fix things, however I'm not sure
what problem we are trying to solve here. The only purpose of the bus
types in libsensors is to qualify the bus numbers and addresses that
follow them in a chip name (e.g. lm78-i2c-1-2d means the LM78 chip that
is connected to the I2C bus #1 and lives at address 0x2d). The whole
purpose of these chip names being to be able to have different
configurations for similar chips (for example one W83781D chip on the
motherboard connected to ISA and one W83781D chip on the graphics
adapter connected to I2C, or two LM90 chips on the motherboard's
SMBus). In the case of "host" devices such as thinkpad_acpi, the device
is unique almost by definition, so there is no need to differentiate.
Thus naming it thinkpad-isa-0000 or thinkpad-host-0000 or
thinkpad-foo-42 doesn't make any difference.

> I mean, it is weird enough with ACPI, but there is also on-die sensors in
> CPUs, and their ilk... and attaching those to BUS_ISA or BUS_PCI sounds like
> something out of an acid trip IMHO, never mind that it would work just fine
> (unlike most stuff that could come out of an acid trip, I suppose) :-)

The K8 thermal sensors are actually reported through a PCI device, so
k8temp-pci-00c3 is a perfectly correct name.

For Core thermal sensors, admittedly, the coretemp-isa-0000 name has no
physical sense. This is the exact same "problem" as for the thinkpad
driver, with the exception that there can actually be more than one
Core temperature sensor, so we use the "ISA address" to distinguish
between them.

> I'm glat to know it is only a mostly cosmetic thing, but still, if it is not
> too painful to fix...

Actually, this isn't trivial. To build a chip name, libsensors uses the
device's subsystem in sysfs. i2c -> i2c, pci -> pci, platform -> isa.
"Host" sensors are implemented as platform drivers, and this is the
reason why libsensors names them foo-isa-0000. So having libsensors
differentiate between host devices and ISA devices would require that
we add a brand new mechanism. We could, of course... if it was solving
a problem. BTW, most "ISA" hardware monitoring chips these days are
actually connected through the LPC bus and not the ISA bus, but we
have been reporting all of them as isa because it's more simple that
way.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
