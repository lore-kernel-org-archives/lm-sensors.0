From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Aug 2007 12:19:02 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070820141902.634de608@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Mon, 20 Aug 2007 08:53:30 -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 19 Aug 2007, Henrique de Moraes Holschuh wrote:
> > On Sun, 19 Aug 2007, Jean Delvare wrote:
> > > Basically, two changes: add a "name" attribute to the device, and give
> > > the platform device an instance number.
> > >=20
> > > The name attribute is needed and must be added to the thinkpad_acpi
> > > driver now, otherwise it won't work with libsensors (neither current =
nor
> > > libsensors4). This is where libsensors gets the "prefix" part of a
> > > chip name.
> >=20
> > I will bake up a patch and send it for inclusion in 2.6.23-rc ASAP. If =
Len
> > and Linus will take it (they should, it is an obviously safe thing that
> > affects one driver only...).
>=20
> Ok, I have one tentative patch ready, but I better make sure I got it rig=
ht
> on the first try.
>=20
> First, is the "name" attribute documented anywhere?  I may have to change
> its contents later, if I break up thinkpad-acpi into various modules.  Do=
es
> anything else other than libsensors4 uses it?

The name attribute is also used by libsensors3 and pwmconfig.

> To avoid changing the contents of the "name" attribute, I'd have to creat=
e a
> second platform device and dedicate it to hwmon (and name it
> "thinkpad-sensors").  This is NOT a problem, but I am unsure if such a
> change would be accepted in-tree this late in the game.  I will probably =
try
> it anyway, at least it is future-proof.  It is probably safer to defer
> thinkpad-acpi libsensors4 support to 2.6.24 if the change is not accepted
> for -rc4.

I would aim at 2.6.24. As you can see there are still a number of
things to be discussed, and there's no point in rushing a patch in
2.6.23 anyway, given that the stable version of libsensors still lacks
support for the thinkpad_acpi driver anyway.

> Second, the libsensors configuration for thinkpad-acpi depends on the
> thinkpad model.  I *can* export its model to libsensors4 (I have that
> information), but how do I go about it?

Good question. Hans de Goede and myself had a heated discussion about
this some times ago about his abituguru3 driver. He finally decided to
let the driver export the labels to user-space (files are names
temp1_label, fan1_label etc...) because it was easier for him that way
in the case of the Abit =B5Guru. My own preference would be to handle it
in user-space: get the DMI data for the system, and download the right
configuration file for the given system. However it essentially depends
on whether the DMI data is OK to pick the right configuration file, or
not. If the configuration depends on bits encoded in the chip itself
(as is the case of the =B5Guru) then in-kernel labelling is probably
better. Ultimately, what we want is to lower the maintenance workload.

> See, that's why I'd really like BUS_HOST.  Unlike ISA which has port
> numbers, or PCI, which has PCI-IDs, BUS_HOST is suitable to model and
> version numbers as a way to differentiate various devices.

ISA port numbers and PCI IDs are unrelated. It's more PCI device number
and function which relate to ISA port numbers, in that they uniquely
identify a device within the running system (PCI IDs do not.) This is
what we use the address for in libsensors: unique device identification
in the system, so that you can have different configurations for two
similar devices in a given system. This problem doesn't exist for
devices like thinkpad_acpi, which are unique by nature, so there's no
problem to solve as far as I can see.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
