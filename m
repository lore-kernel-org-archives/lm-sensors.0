From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Jun 2012 17:15:05 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <20120627171505.GB12712@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com>
In-Reply-To: <4FEA4C10.2060904@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michael Zintakis <michael.zintakis@googlemail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org

On Wed, Jun 27, 2012 at 12:56:00AM +0100, Michael Zintakis wrote:
> Hello,
>=20
> I hope this is the right place to place my query!
>=20
> I am trying to take control and initialise my fan censors and
> "sensors-detect" is telling me that the chip on the board is "Fintek
> f71869a at 0x290, revision 32". However, when I run sensors (the
> service) this driver is not loaded (I can't see any of the fan
> sensors either) and dmesg is showing me the following:
>=20
> [ 2312.804747] f71882fg: Found f71869a chip at 0x290, revision 32
> [ 2312.804902] ACPI Warning: 0x00000290-0x00000297 SystemIO
> conflicts with Region \_TZ_.IP__ 1 (20120111/utaddress-251)
> [ 2312.804919] ACPI Warning: 0x00000290-0x00000297 SystemIO
> conflicts with Region \_SB_.PCI0.LPCB.SIO1.RNTR 2
> (20120111/utaddress-251)
> [ 2312.804934] ACPI: If an ACPI driver is available for this device,
> you should use it instead of the native driver
>=20
> Could anybody tell me what the above means please? Is there a
> conflict between ACPI and the Fintek kernel module sensors (the
> service) is trying to load? Is there a separate "ACPI driver" I
> should be using instead? If so, how can I activate it so that I
> could get to read my fan sensors?
>=20
> When I run "sensors" (the program) I see very limited information,
> like this:
>=20
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +48.0=B0C  (crit =3D +127.0=B0C)
> temp2:        +26.8=B0C  (crit =3D +127.0=B0C)
> temp3:        +26.8=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +51.0=B0C  (crit =3D +100.0=B0C)
> Core 1:       +51.0=B0C  (crit =3D +100.0=B0C)
>=20
> This is not OK because I don't have any RPMs of any of the fans (I
> have 3 fans running) and various voltages I have on this board. I am
> using Fedora Core 17 with kernel version 3.3.4 with the latest
> version of lm_sensors (3.3.2, I think).
>=20
> Many thanks!
>=20
Hi Michael,

Please see http://hansdegoede.livejournal.com/7932.html; it should explain =
what
is going on.

Unfortunately, the generic ACPI driver does not permit much fan control.
There are some board specific ACPI drivers, providing better support (eg AS=
US
and Thinkpad), but for the most part you either get no or very limited fan
monitoring/control support.

I don't know if generic support for ACPI based hardware monitoring can be
improved. Since it might be useful to know, I am copying the ACPI maintainer
and the ACPI mailing list. Maybe they can provide some additional informati=
on or
pointers.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
