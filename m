From: "Jean Delvare" <khali@linux-fr.org>
Date: Tue, 25 Dec 2007 21:31:26 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <Va0NwseF.1198618285.6089960.khali@gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200712231614.58724.bjorn.helgaas@hp.com>
In-Reply-To: <200712231614.58724.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: bjorn.helgaas@hp.com
Cc: Shaohua Li <shaohua.li@intel.com>, Mike Houston <mikeserv@bmts.com>, Adrian Bunk <bunk@stusta.de>, Elvis Pranskevichus <el@prans.net>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org


Hi Bjorn,

Le 23/12/2007, "Bjorn Helgaas" <bjorn.helgaas@hp.com> a =E9crit:
>On Sunday 23 December 2007 2:28:05 am Jean Delvare wrote:
>> The problem is that the it87 driver is used on a variety of motherboards,
>> some where the hardware monitoring device I/O ports are reserved by the
>> BIOS, some where they aren't. How am I supposed to deal with this?
>
>I assume you mean some boards describe those ports in ACPI, and some
>don't?

Yes, that's what I meant.

>(...) I think the ideal solution would be to figure out how the
>BIOS writers intended the device to be used, and do that.  But the
>documentation may be lacking, and it degenerates into an OEM-specific
>mess.  Second-best seems like a PNP quirk that pokes enough to determine
>that a Super I/O device is present, and then reserves resources for
>it.  Then we avoid the collision even if it87 isn't present.

I'm not sure what you mean here exactly. We have two different cases:
either the ACPI code did declare the PNP device, or it did not. How do
you unify both? And what "collision" are you talking about?

>> PCI is an entirely different beast. With PCI you know the PCI device ID
>> that is associated with the resources, and for a given device, the
>> resources are always declared (if standard BARs are used) or never
>> declared; there's no "may be". So it's much easier to handle the
>> resources properly.
>
>That's the way PNP is supposed to work, too (more about this below).

Not really. PNP devices may or may not be declared. PCI devices are
always declared. This is a fundamental difference. I'm also not sure
about the PNP IDs, see below.

>> That's not really safe, no. They may overlap with other device resources
>> and prevent those drivers from loading.
>
>True.  If that happens, I think we definitely need some kind of DMI-
>based quirk to fix the resources.  My points are (a) the quirk needs
>to be at the PNP level; it can't be in a driver, and (b) I'm lazy and
>would wait until a problem happens before implementing it, because I
>know so little about PNP and the specific board, and by waiting, there's
>a chance I'll learn enough to avoid a mistake :-)

But we _do_ have a problem to solve! That's what started this thread.
And we need to solve it before 2.6.24 is released. I'd rather (try to)
do the right thing now rather than going in one direction today and
doing something different next month.

I do agree that the quirks should be done at the PNP level and not in the
it87 driver.

>> Another problem is how do I connect this specific I/O port range of the
>> PNP0C02 device with the it87 driver? I am by far no PNP expert but it
>> looks to me like this PNP device covers more than one actual device, and
>> I/O port ranges do not have labels nor identifiers that would let me
>> find the one that corresponds to the IT87xxF device (if it exists at
>> all.)
>
>The general rule is that you have a PNP device with an identifier
>like PNP0500 that means "16550 UART" and some resources underneath
>it.  The PNP ID ("PNP0500") tells the OS which driver to bind to the
>device, and the resources tell the driver where the device is.  The
>serial driver in drivers/serial/8250_pnp.c is a good example of the
>"normal" way PNP drivers work.
>
>it87 doesn't fit the model very well because usually the BIOS
>doesn't describe the device explicitly.  I think the expectation
>is that the OS will get sensor readings some other way, such as
>by evaluating ACPI "_TMP" methods, or by using some OEM-specific
>ACPI device.

If the IT87xxF device is declared, will it always the same PNP ID on
every system? I fear that the answer is no, in which case I see no
simple way to implement the it87 driver as a PNP driver.

>It's very irritating when ACPI is used to take some device that
>would otherwise be nicely generic and machine-independent, and
>wrap it up into some abstract device that requires an OEM-specific
>driver, but I think that's what's happening here.  I suspect it
>has to do with the fact that the BIOS wants to retain some
>control over the device so it can deal with things like thermal
>emergencies, even if the OS driver is missing or broken.

Yes, very irritating. Especially when the ACPI way is not only
system-specific, but also very poor in terms of features compared to
what a native driver can do. This is the main reason why we still write
native drivers for hardware monitoring drivers despite the conflicts
with ACPI that arise on some systems.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
