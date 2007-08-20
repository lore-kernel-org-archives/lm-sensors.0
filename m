From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Aug 2007 14:38:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070820163847.1a4dab17@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Mon, 20 Aug 2007 09:46:56 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 20 Aug 2007, Jean Delvare wrote:
> > On Mon, 20 Aug 2007 08:53:30 -0300, Henrique de Moraes Holschuh wrote:
> > > First, is the "name" attribute documented anywhere?  I may have to ch=
ange
> > > its contents later, if I break up thinkpad-acpi into various modules.=
  Does
> > > anything else other than libsensors4 uses it?
> >=20
> > The name attribute is also used by libsensors3 and pwmconfig.
>=20
> Better document it in Documentation/hwmon/sysfs-interface, then...  I'd do
> it, but I don't know the specifics.

Good idea. There was nothing to document originally because i2c devices
get this file automatically, and until recently almost all hardware
monitoring drivers were using (or abusing) i2c. Now that a good load of
hardware monitoring drivers are platform drivers, documenting the name
attribute makes a lot of sense. Patch follows.

> > > Second, the libsensors configuration for thinkpad-acpi depends on the
> > > thinkpad model.  I *can* export its model to libsensors4 (I have that
> > > information), but how do I go about it?
> >=20
> > Good question. Hans de Goede and myself had a heated discussion about
> > this some times ago about his abituguru3 driver. He finally decided to
> > let the driver export the labels to user-space (files are names
> > temp1_label, fan1_label etc...) because it was easier for him that way
>=20
> I was not really thinking about exporting labels, but rather to export
> something that can be a match key in the libsensors config file.

Except that libsensors4 is totally chip-agnostic by design, and I'd
like it to stay that way. We already have two mechanisms to label the
inputs (label files in sysfs and sensors.conf), I'd rather not add a
3rd one.

> > in the case of the Abit =B5Guru. My own preference would be to handle it
> > in user-space: get the DMI data for the system, and download the right
> > configuration file for the given system. However it essentially depends
>=20
> Make it "get the DMI data and allow for AND matches in libsensors config",
> and I will agree.  And I wouldn't even have to do anything in the kernel,
> since there is already support for it both in sysfs, and directly through
> userspace.

There's no need for AND matching as you described. The idea is to have
one specific configuration file per Thinkpad model. The setup to
support this isn't yet in place but people have been working on it.
I'll look into it more closely after lm-sensors 3.0.0 is released.

> That would allow one to match a config to "thinkpad-sensors-*" AND "Think=
Pad
> T43", for example.  We even have a *good* template to use when constructi=
ng
> such strings, see commit 4f5c791a850e5305a5b1b48d0e4b4de248dc96f9 (which =
is
> already in 2.6.23).

The mechanism introduced by this commit is useful to autoload drivers
based on DMI data. This isn't what we are discussing here.

> > > See, that's why I'd really like BUS_HOST.  Unlike ISA which has port
> > > numbers, or PCI, which has PCI-IDs, BUS_HOST is suitable to model and
> > > version numbers as a way to differentiate various devices.
> >=20
> > ISA port numbers and PCI IDs are unrelated. It's more PCI device number
>=20
> I know.  I was trying to convey the idea that what comes after the "name"
> for BUS_HOST could be DMI data, instead of ISA port numbers (used in ISA
> stuff) or PCI IDs (used in PCI stuff), or I2C IDs (used in I2C/smbus)...

And I was trying to explain why using the "address" field of
libsensors' chip name wasn't a good idea, because this field is there
to differentiate between similar chips on a given machine, and not to
identify a unique chip configuration. Using one field for different
purposes could quickly lead to confusion IMHO.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
