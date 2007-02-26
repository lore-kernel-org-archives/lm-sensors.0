From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 26 Feb 2007 16:39:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: Request the I/O regions in platform
Message-Id: <20070226173919.494e119a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070221201208.0420dc7d.khali@linux-fr.org>
In-Reply-To: <20070221201208.0420dc7d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Sat, 24 Feb 2007 15:06:16 -0600, David Hubbard wrote:
> Hi Jean, Juerg,
> 
> On 2/21/07, Jean Delvare <khali at linux-fr.org> wrote:
> > My understanding of the resource management in the Linux 2.6 device
> > driver model is that the devices should declare their resources, and
> > then when a driver attaches to a device, it should request the
> > resources it will be using, so as to mark them busy. This is how the
> > PCI and PNP subsystems work, you can clearly see the two levels of
> > resources (declaration and request) in /proc/ioports for these
> > devices.
> >
> > So I believe that our platform hardware monitoring drivers should
> > follow the same logic. At the moment, we only declare the resources
> > but we do not request them. This patch adds the I/O regions request
> > and release calls.
> 
> Would this have any effect with the discussion Rudolf Marek started
> about ACPI Thermal monitoring and a race condition with a hwmon driver
> (e.g. w83627ehf), resulting in an invalid reading (which sets off the
> ACPI alarm and shuts down the system)?
> 
> Would requesting the resources prevent the ACPI Thermal AML from
> accessing the chip? Perhaps I have not understood the ioports region
> code correctly, but it would not make sense to allow something like
> the AML parser to access IO regions marked busy.

It is probably one step in the right direction. However it won't solve
the problem per se, because as far as I know, the ACPI/AML code doesn't
check for regions at all at the moment. But it definitely should one
way or another, so we must do our part of the job and properly declare
the regions we are using.

One problem which will certainly arise soon though, is that the ACPI
thermal module does more than just reporting temperatures, it can also
control thermal throttling, emergency shutdown etc. In that sense, some
may argue that it should get a prioritary access over hwmon drivers.
This can only be done if the ACPI/AML code doesn't only check for busy
regions, but actually request the regions it'll be using - pretty much
how every other driver is supposed to do. Not being familiar with ACPI,
I don't know how feasable this is.

Ideally we would be able to synchronize accesses between ACPI/AML and
the other drivers, I think Rudolf made a proposal in that sense. But I
see this as a second step. The first step would be to just prevent
collisions because they are hard to diagnose and the results are
impossible to predict. If drivers would cleanly lock each other out, at
least we would know when conflicts exist.

-- 
Jean Delvare

