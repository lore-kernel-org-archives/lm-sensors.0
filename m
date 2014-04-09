From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 09 Apr 2014 07:15:13 +0000
Subject: Re: [lm-sensors] MCP68 SE not listed
Message-Id: <20140409091513.79ddd2bb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <14733-1396967453-397931@sneakemail.com>
In-Reply-To: <14733-1396967453-397931@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Lucas,

Please keep the list in Cc.

On Tue, 8 Apr 2014 17:24:04 +0200, Lucas Malor wrote:
> On 8 April 2014 16:47, Jean Delvare jdelvare-at-suse.de |
> lm-sensors@lm-sensors.org| <shoq7lb47t@sneakemail.com> wrote:
> >
> > Hi Lucas,
> >
> > On Tue, 8 Apr 2014 14:30:53 +0000, Lucas Malor wrote:
> > > Hi all. I have an old Asus M4N68T-M LE V2. For what I see in its
> documentation, its chip is the Nvidia MCP68 SE. Unfortunately it is not
> present in your device list.
> >
> > It's indeed not listed. But if the PCI ID of the SMBus block is the
> > same as a supported chip, it could still work. Please share the output
> > of:
> >
> > # lspci -nn | grep SMBus
>=20
> 00:01.1 SMBus [0c05]: NVIDIA Corporation MCP61 SMBus [10de:03eb] (rev a2)
> http://www.pcidatabase.com/vendor_details.php?id=3D606

OK, so that is the same SMBus component as the MCP61, already listed in
the wiki and already supported by sensors-detect and the kernel.

Actually I can't find any reference to an MCP68 in the PCI IDs
database. What makes you think this chip exists in the first place and
that your board doesn't just have an MCP61?

Anyway, it doesn't really matter, read below...

> > You can't compare it87 to i2c-nforce2. The former is a driver for the
> > integrated sensors in a Super-I/O (LPC) chip. The latter is a driver
> > for the SMBus controller in nVidia's south bridges.
>=20
> Interesting, thank you.
>=20
> > if you think some inputs
> > are missing with just it87, then maybe you need i2c-nforce2 + another
> > driver.
>=20
> I get two different results from two different drivers:
>=20
> atk0110-acpi-0
> [...]
> CPU Temperature:    +33.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:     +32.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +45.6=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +99.5=B0C, hyst =3D +97.5=B0C)

Ah. This is one of these boards with the ATK0110 ACPI virtual device.
Look no further, you don't need it87 nor i2c-nforce2, the ACPI device
takes precedence over native devices. You already have the drivers you
need (asus_atk0110 for the motherboard and k10temp for the CPU.)

> As you see, k10temp gives me only the CPU temp, and furthermore the value
> is different. And I don't know what "hyst" does means.

This is not surprising, for several reasons.

The "CPU temperature" from ATK0110 may come from a thermistor in the
CPU socket rather than the CPU itself. That would explain the lower
temperature. Even if the "CPU temperature" from ATK0110 is from an
analog diode inside the CPU, it's still a different sensor from the
digital reading k10temp gets directly from the CPU.

Also, k10temp really reports a thermal margin from the maximum
temperature supported by the CPU. It's not reporting actual degrees
Celsius, and loses accuracy quickly as the temperature lowers. Read the
driver documentation for more details:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documen=
tation/hwmon/k10temp

"hyst" means "hysteresis" [1]. "crit" tells you over which temperature an
alarm would trigger, "hyst" tells you below which temperature that
alarm would clear.

[1] https://en.wikipedia.org/wiki/Hysteresis

--=20
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
