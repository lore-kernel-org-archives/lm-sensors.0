From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 May 2013 00:36:17 +0000
Subject: Re: [lm-sensors] Getting correct temperature information from Intel 945GSE/ICH7M
Message-Id: <20130507003617.GA23710@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CE0521C9E8FCC646A7D4D5C05886A095604FFD4A@SHDEXMBX1.shd-online.de>
In-Reply-To: <CE0521C9E8FCC646A7D4D5C05886A095604FFD4A@SHDEXMBX1.shd-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, May 06, 2013 at 12:31:11PM +0000, Sebastian Werner wrote:
> Hello,
>=20
> I am trying to get the right temperature from two different pieces of har=
dware.
> The first, newest piece (http://www.jetwaycomputer.com/ITX-JBC362F36.html=
) works right out of the box. Got lm-sensor on the debian system, sensors-d=
etect tells me to modprobe lm78 and the temperature is roughly the same as =
the one shown in the bios.
>=20
> Acpitz-virtual-0
> Adapter: Virtual device
> Temp1:              +40.0=B0C  (crit =3D +127.0=B0C)
> Temp2:              +26.8=B0C  (crit =3D +127.0=B0C)
> Temp3:              +26.8=B0C  (crit =3D +100.0=B0C)
>=20
This output is not from the lm78 driver.

The "coretemp" driver works with this CPU (Atom N2600). Load it and see wha=
t it reports.

> Not temp2 and temp3 though. Both temperatures never change and they have =
no connection to anything I can read in the bios.
> I presumed that those are 'dead wires' and I am at the moment ignoring th=
ose, since temp1 is good enough for me.
>=20
The temperatures are reported by ACPI. No idea how that translates to hardw=
are
temperatures. If the temperature never changes, there may be a bug in the
ACPI tables. Those are controlled by the board manufacturer, and would be
updated with the BIOS. Do you have the latest BIOS versions installed ?

> The second, the older piece (http://www.jetwaycomputer.com/ITX-JBC360F33-=
B.html) does not seem to work. Sensors-detect tells me to load coretemp, us=
ing the latest version of sensors-detect from the site wants to also me to =
load the f71882fg driver. That doesn't work out with a 'No such device' err=
or.
>=20
What is your kernel version, and what exactly does sensors-detect report ?

If I interpret the information I find on the web correctly, the board might
be MI812 or MI810 from iBT. If so, the Fintek chip on the board is only used
for COM ports. Try loading the w83627ehf driver instead.

> Acpitz-virtual-0
> Adapter: Virtual device
> Temp1:              +30.0=B0C  (crit =3D +100.0=B0C)
> Coretemp-iso-0000
> Core 0:               +30.0=B0C  (crit =3D +90.0=B0C)
>=20
The CPU is Atom N270, so the reported critical core temperature is correct.
CPU temperature measurements are highly inaccurate that far below the maxim=
um
temperature, so the reported value is as good as it gets. Accuracy is better
with higher temperatures.

> Both are no realistic values. Temp1 never changes. The Core 0 temperature=
 seems too low (both systems feel roughly the same to the touch from the ou=
tside), it does change if I put a ventilator beside it.

temp1 is reported through ACPI. Possibly there is a bug in the ACPI tables,=
 but
all you can do is to ignore the value if it never changes.

Regarding the core temperature inaccuracies, you'll have to complain to Int=
el.

> I feel quite out of my field in this, could someone give me a pointer or =
two what might be going on or where I could read up to understand this weir=
d situation?

Not really weird at all, but quite common.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
