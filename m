From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 13 Jul 2007 00:28:37 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <20070713002836.GR3435@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5830463835621025860=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============5830463835621025860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dLXnlYbDJNCwF3YM"
Content-Disposition: inline


--dLXnlYbDJNCwF3YM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2007 at 11:42:43AM +0200, Hans de Goede wrote:
> Darrick J. Wong wrote:
> >Resend with correct title and patch included just once.
> >---
> >adt7470: new hwmon driver for adt7470 chip.
> >
> >Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
>=20
> Looks good now, as far I'm concerned this is ready to get merged.
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>=20
> Mark, any chance you can pick this up soonish, maybe it can make 2.6.23=
=20
> then.
>=20
> Darrick, have you already written support for this driver for libsensors=
=20
> and sensors? If not could you please do that ASAP? Then I'll review it an=
d=20
> with some luck and Jean's permission we can still get support for this ch=
ip=20
> included into lm_sensors 2.10.4

I ... can't say that I have a working config.  I've added this into /etc/se=
nsors.conf:
chip "adt7470-*"
        label fan1 "CPU0 Fan"
        label fan2 "CPU1 Fan"
        label temp1 "CPU0 Temp"
        label temp3 "CPU1 temp"
        label pwm1 "CPU0 Fan Control"
        label pwm2 "CPU1 Fan Control"

(There are more pwm/fan/temp widgets but on the Z30 they're not
connected to anything.)

But every time I run sensors (from svn) I see only this:
root@elm3a181:/usr/local/src/lm_sensors/prog# sensors/sensors -c
/tmp/sensors.conf=20
adt7470-i2c-0-2f
Can't get adapter name for bus 0

I _think_ this has to do with i2c-i801 not exporting something in sysfs
correctly, though I'm not sure.  Below is the strace output from sensors
after it finishes probing the hwmon devices.

--D

lstat("/sys/class/i2c-adapter/i2c-0", {st_mode=3DS_IFLNK|0777, st_size=3D0,=
 ...}) =3D 0
lstat("/sys/class/i2c-adapter/i2c-0", {st_mode=3DS_IFLNK|0777, st_size=3D0,=
 ...}) =3D 0
readlink("/sys/class/i2c-adapter/i2c-0", "../../devices/pci0000:00/0000:00:=
1f.3/i2c-adapter/i2c-0", 256) =3D 55
readlink("/sys/devices/pci0000:00/0000:00:1f.3/i2c-adapter/i2c-0/subsystem"=
, "../../../../../class/i2c-adapter", 256) =3D 32
lstat("/sys/class/i2c-adapter", {st_mode=3DS_IFDIR|0755, st_size=3D0, ...})=
 =3D 0
lstat("/sys/devices/pci0000:00/0000:00:1f.3/i2c-adapter/i2c-0/device", {st_=
mode=3DS_IFLNK|0777, st_size=3D0, ...}) =3D 0
readlink("/sys/devices/pci0000:00/0000:00:1f.3/i2c-adapter/i2c-0/device", "=
=2E./../../../../devices/pci0000:00/0000:00:1f.3", 256) =3D 46
lstat("/sys/devices/pci0000:00/0000:00:1f.3", {st_mode=3DS_IFDIR|0755, st_s=
ize=3D0, ...}) =3D 0
lstat("/sys/devices/pci0000:00/0000:00:1f.3/bus", 0x7fff146427e0) =3D -1 EN=
OENT (No such file or directory)
lstat("/sys/devices/pci0000:00/0000:00:1f.3/driver", {st_mode=3DS_IFLNK|077=
7, st_size=3D0, ...}) =3D 0
readlink("/sys/devices/pci0000:00/0000:00:1f.3/driver", "../../../bus/pci/d=
rivers/i801_smbus", 256) =3D 35
lstat("/sys/devices/pci0000:00/0000:00:1f.3/subsystem", {st_mode=3DS_IFLNK|=
0777, st_size=3D0, ...}) =3D 0
readlink("/sys/devices/pci0000:00/0000:00:1f.3/subsystem", "../../../bus/pc=
i", 256) =3D 16
lstat("/sys/devices/pci0000:00/0000:00:1f.3/name", 0x7fff14642d60) =3D -1 E=
NOENT (No such file or directory)
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7fff14642ea0) =3D -1 ENOTTY (Inap=
propriate ioctl for device)
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D458, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x2ad196483000
read(3, "chip \"adt7470-*\"\n\tlabel fan1 \"CP"..., 8192) =3D 458
read(3, "", 4096)                       =3D 0
read(3, "", 8192)                       =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7fff146417b0) =3D -1 ENOTTY (Inap=
propriate ioctl for device)
close(3)                                =3D 0
munmap(0x2ad196483000, 4096)            =3D 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D25460, ...}) =3D 0
mmap(NULL, 25460, PROT_READ, MAP_SHARED, 3, 0) =3D 0x2ad196483000
close(3)                                =3D 0
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\300\4\0"..., 832) =
=3D 832
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D10200, ...}) =3D 0
mmap(NULL, 2105392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0x2ad1970a7000
mprotect(0x2ad1970a9000, 2093056, PROT_NONE) =3D 0
mmap(0x2ad1972a8000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_=
DENYWRITE, 3, 0x1000) =3D 0x2ad1972a8000
close(3)                                =3D 0
fstat(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 2), ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x2ad1972aa000
write(1, "adt7470-i2c-0-2f\n", 17adt7470-i2c-0-2f
)      =3D 17
write(2, "Can\'t get adapter name for bus 0"..., 33Can't get adapter name f=
or bus 0
) =3D 33
write(1, "\n", 1
)                       =3D 1
exit_group(0)                           =3D ?

--dLXnlYbDJNCwF3YM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlsc0a6vRYYgWQuURAhhqAKCBfh+4e325gP8cbyd7LkkU/RbofACeMz7M
98GDgNP1Ilfp+PwOVp4jaDU=
=/XlL
-----END PGP SIGNATURE-----

--dLXnlYbDJNCwF3YM--


--===============5830463835621025860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5830463835621025860==--
