From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 20 Aug 2007 12:46:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070820124656.GA24206@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 20 Aug 2007, Jean Delvare wrote:
> On Mon, 20 Aug 2007 08:53:30 -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 19 Aug 2007, Henrique de Moraes Holschuh wrote:
> > > On Sun, 19 Aug 2007, Jean Delvare wrote:
> > > > Basically, two changes: add a "name" attribute to the device, and g=
ive
> > > > the platform device an instance number.
> > > >=20
> > > > The name attribute is needed and must be added to the thinkpad_acpi
> > > > driver now, otherwise it won't work with libsensors (neither curren=
t nor
> > > > libsensors4). This is where libsensors gets the "prefix" part of a
> > > > chip name.
> > >=20
> > > I will bake up a patch and send it for inclusion in 2.6.23-rc ASAP. I=
f Len
> > > and Linus will take it (they should, it is an obviously safe thing th=
at
> > > affects one driver only...).
> >=20
> > Ok, I have one tentative patch ready, but I better make sure I got it r=
ight
> > on the first try.
> >=20
> > First, is the "name" attribute documented anywhere?  I may have to chan=
ge
> > its contents later, if I break up thinkpad-acpi into various modules.  =
Does
> > anything else other than libsensors4 uses it?
>=20
> The name attribute is also used by libsensors3 and pwmconfig.

Better document it in Documentation/hwmon/sysfs-interface, then...  I'd do
it, but I don't know the specifics.

> > it anyway, at least it is future-proof.  It is probably safer to defer
> > thinkpad-acpi libsensors4 support to 2.6.24 if the change is not accept=
ed
> > for -rc4.
>=20
> I would aim at 2.6.24. As you can see there are still a number of

Agreed.  Scheduled for 2.6.24, then.

> > Second, the libsensors configuration for thinkpad-acpi depends on the
> > thinkpad model.  I *can* export its model to libsensors4 (I have that
> > information), but how do I go about it?
>=20
> Good question. Hans de Goede and myself had a heated discussion about
> this some times ago about his abituguru3 driver. He finally decided to
> let the driver export the labels to user-space (files are names
> temp1_label, fan1_label etc...) because it was easier for him that way

I was not really thinking about exporting labels, but rather to export
something that can be a match key in the libsensors config file.

> in the case of the Abit =B5Guru. My own preference would be to handle it
> in user-space: get the DMI data for the system, and download the right
> configuration file for the given system. However it essentially depends

Make it "get the DMI data and allow for AND matches in libsensors config",
and I will agree.  And I wouldn't even have to do anything in the kernel,
since there is already support for it both in sysfs, and directly through
userspace.

That would allow one to match a config to "thinkpad-sensors-*" AND "ThinkPad
T43", for example.  We even have a *good* template to use when constructing
such strings, see commit 4f5c791a850e5305a5b1b48d0e4b4de248dc96f9 (which is
already in 2.6.23).

> > See, that's why I'd really like BUS_HOST.  Unlike ISA which has port
> > numbers, or PCI, which has PCI-IDs, BUS_HOST is suitable to model and
> > version numbers as a way to differentiate various devices.
>=20
> ISA port numbers and PCI IDs are unrelated. It's more PCI device number

I know.  I was trying to convey the idea that what comes after the "name"
for BUS_HOST could be DMI data, instead of ISA port numbers (used in ISA
stuff) or PCI IDs (used in PCI stuff), or I2C IDs (used in I2C/smbus)...

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
