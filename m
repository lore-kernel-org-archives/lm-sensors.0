From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 May 2007 14:51:21 +0000
Subject: Re: [lm-sensors] Any chances to get THMC50 driver into 2.6.22?
Message-Id: <20070521165121.0589aecf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4649ac914ece8@wp.pl>
In-Reply-To: <4649ac914ece8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Wed, 16 May 2007 08:16:03 +0200, Krzysztof Helt wrote:
> Dnia 15-05-2007 o godz. 18:38 Jean Delvare napisa=C5=82(a):
> > * Help the project with something else. The time you save us,
> >   we can put in reviewing your code.
>=20
> Can you point me these issues?

Well, user support to start with, both on this mailing list and
http://www.lm-sensors.org/report . Some tickets are pretty simple, for
example everyone should be able to solve #2208. And review or testing
of any patch posted to the list, that's always welcome.

You can also test 2.6.22-rc2 or later on your systems and confirm that
there are no regressions concerning lm-sensors.

If you tell us which drivers you can test, I can also look at these
drivers for needed cleanups. For example lots of drivers are still
using ugly macros instead of "dynamic" sysfs attributes so there is
room for improvement.

Then we have a number of big projects in progress at the moment:

* Conversion of i2c-isa-based drivers to platform drivers. Six drivers
remain to be converted. w83627ehf is handled by David Hubbard and is
almost done, it87 and pc87360 are supposedly handled by Corentin Labbe
and Jim Cromie respectively, but I didn't see anything yet. vt8231,
sis5595 and via686a are PCI-based, how we convert them depends on
possible changes to the pci subsystem so I was delaying them a bit, but
we want them in 2.6.23 so I will have to decide quickly. So if you have
access to a device supported by any of these 6 drivers, you could help
with the conversion, either doing it yourself or reviewing or testing.

* Addition of individual alarm files to all hardware monitoring
drivers. A small number of drivers are already converted but there are
still many left. Individual alarm files are required for the future
libsensors. The naming scheme for these files is described in
Documentation/hwmon/sysfs-interface. To figure out the bit mapping of
the alarms, you need to refer to either the datasheet or the 2.4 driver
(in lm-sensors, under kernel/chips).

* We're also working on the new libsensors in branch "3.0.0" of
lm-sensors SVN. The new version scans sysfs for supported files
automatically so you no longer need to add support for every new
driver. Help is needed with reviewing the new code, and testing how it
works with as many drivers and devices as possible. Hans de Goede
posted about this some times ago and didn't receive any answer.

Oh, and if you have experience with writing drivers for serial (RS232)
devices, please let me know, I am trying to write such a driver for an
evaluation module but am going nowhere.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
