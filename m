From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Aug 2013 11:59:52 +0000
Subject: Re: [lm-sensors] why does # of temperature sensors decrease in 3.11 (thinkfan config related)
Message-Id: <20130825135952.38008c25@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <52074F4B.5020003@gmx.de>
In-Reply-To: <52074F4B.5020003@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rafael,

Thanks for the quick reply.

On Sun, 25 Aug 2013 03:54:08 +0200, Rafael J. Wysocki wrote:
> On 8/24/2013 11:19 PM, Jean Delvare wrote:
> > Bisection pointed to:
> >
> > commit ac212b6980d8d5eda705864fc5a8ecddc6d6eacc
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Date:   Fri May 3 00:26:22 2013 +0200
> >
> >      ACPI / processor: Use common hotplug infrastructure
> >     =20
> > Rafael, any hint as to why the auto-loading of driver coretemp would be
> > broken by the aforementioned commit?
>=20
> Essentially, that is a udev issue.
>=20
> There is a line like this in the udev rules:
>=20
> DRIVER!=3D"?*", ENV{MODALIAS}=3D"?*", IMPORT{builtin}=3D"kmod load=20
> $env{MODALIAS}"
>=20
> which causes modalias to be matched only for devices that have no=20
> drivers (usually, that line is located in the 80-drivers.rules file=20
> under /lib/udev/rules.d/ or /usr/lib/udev/rules.d/).  After the commit=20
> above the CPU devices have a driver and the modalias matching is not=20
> used for them, unfortunately.
>=20
> The easiest way to fix this is to remove the driver check from that line =

> so that it looks like this:
>=20
> ENV{MODALIAS}=3D"?*", IMPORT{builtin}=3D"kmod load $env{MODALIAS}"
>=20
> That change has been made in the upstream udev already as far as I can=20
> say, so it should propagate through updates.

Indeed it is:
http://cgit.freedesktop.org/systemd/systemd/commit?id=BF7f800f2b3e93ccd1229=
d4717166f3a4d3af72f

I can confirm that this solved my issue. Toralf, please give it a try.
If you don't want to touch udev rules files under /lib or /usr/lib, you
can copy 80-drivers.rules to /etc/udev/rules.d and edit it there.

I'll try to get this change integrated into openSUSE 12.3.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
