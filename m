From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Jan 2009 10:59:45 +0000
Subject: Re: [lm-sensors] VRM 11.0 needed for it8718 chip
Message-Id: <20090127115945.29737d07@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <495FD5F5.70103@free.fr>
In-Reply-To: <495FD5F5.70103@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Salut Vincent,

D=E9sol=E9 pour cette r=E9ponse un peu tardive.

On Sat, 03 Jan 2009 22:17:41 +0100, Vincent Danjean wrote:
>   Hi,
>=20
>   I'm trying to use lm-sensors with a Gigabyte EG45M-DS2H motherboard
> and a Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz (from /proc/cpuinfo)
>   sensor-detect asks me to load it87 and coretemp modules
>=20
>   I'm using Debian lenny versions of lm-sensors: 1:3.0.2-1+b2
> (ie 3.0.2 upstream)
>=20
>   My chips is a it8718F. When loading my modules, I get:
> [   15.646427] it87: Found IT8718F chip at 0x290, revision 5
> [   15.646427] it87: in3 is VCC (+5V)
> [   15.654427] coretemp coretemp.0: Using relative temperature scale!
> [   15.654427] coretemp coretemp.1: Using relative temperature scale!
> [   15.654427] coretemp coretemp.2: Using relative temperature scale!
> [   15.654427] coretemp coretemp.3: Using relative temperature scale!
>=20
>   The default configuration file did have have anything for a it8718.
> I wrote a section based on the one found here:
> http://www.lm-sensors.org/wiki/Configurations/Gigabyte/G33-DS3R
> I had to change low/over to min/max and to comment out "set sensor3 0"
>=20
> I also add a problem with in0_(min|max): vid was not valid and cpu0_vid
> was always 0. At first, I put a explicit value here. Then, I read
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/vid
> (pointed by your FAQ)
> It tells:
> 109     The following chip drivers support only VRM 8.2 and cannot be cha=
nged:
> 110 =09
> 111 	        adm1024, it87, mtp008, adm9240, gl520sm, lm78
> 112 =09
> 113 	If you have a board with one of these chips which needs advanced
> 114 	VRM support please email us.

You are quoting an old version of this document, which only applies to
the Linux 2.4 drivers. In Linux 2.6, all the drivers pick the right VRM
value based on the CPU model. Some drivers let the user change the
value after that, some don't (the it87 driver does.)

> So, I'm emailing you. Indeed, my /sys/class/hwmon/hwmon0/device/vrm had
> by default a value of 110. The intel website has a document for VRM 11.0.

We already have support for VRM 11.0 (since kernel 2.6.18.)

> If I put the value 100 in /sys/class/hwmon/hwmon0/device/vrm, then
> I got a non zero value for cpu0_vid (the value seems non absurd, ie
> sensors reports 1.063V for cpu_vid0)

I seem to remember that VRM 11 has a VRM 10 compatibility mode. It
didn't make much sense to me and we didn't implement that, but maybe
that's what your system does. It would be interesting to see the raw VID
code. Please provide the output of:

isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7

> Note that "set vrm 100" in my it8718 section is refused by "sensors -s":
> # sensors -s
> Error: Line 1429: Unknown feature name
> it8718-isa-0290: No such subfeature known

Since lm-sensors 3.0.0, libsensors no longer knows about VRM, because
the kernel is supposed to handle it automatically.

>   If you need more information, please, ask me (but I'm not subscribed to
> this ML, so CC me)
>=20
>=20
>   Last remark: lm-sensors seems to work with my config but I'm not sure
> that the CPU temp is correctly computed. I've:
> NBr Temp:    +37.0=B0C  (low  =3D +10.0=B0C, high =3D +50.0=B0C)  sensor =
=3D transistor
> CPU Temp:    +21.0=B0C  (low  =3D +10.0=B0C, high =3D +60.0=B0C)  sensor =
=3D thermal diode
> and then
> Core 0:      +31.0=B0C  (high =3D +82.0=B0C, crit =3D +100.0=B0C)
> Core 1:      +32.0=B0C  (high =3D +82.0=B0C, crit =3D +100.0=B0C)
> Core 2:      +28.0=B0C  (high =3D +82.0=B0C, crit =3D +100.0=B0C)
> Core 3:      +31.0=B0C  (high =3D +82.0=B0C, crit =3D +100.0=B0C)

The values returned by the coretemp driver seem reasonable. The CPU
temperature value returned by the on-board sensor chip is suspiciously
low, probably it needs an offset of some sort.

If you have come up with a configuration file which works for your
board, please contribute it and we'll add it to the wiki.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
