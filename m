From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Nov 2007 12:02:40 +0000
Subject: Re: [lm-sensors] libsysfs 2.x bug affects libsensors
Message-Id: <20071125130240.7dba206d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 28 Sep 2006 16:15:54 +0200, Jean Delvare wrote:
> I just noticed that libsysfs 2.x has a bug (or at least a serious
> mis-feature) which affects libsensors.
>=20
> Since lm_sensors 2.10.0, libsensors relies on sysfs_get_mnt_path() to
> find out whether sysfs is available or not, and fallbacks to procfs to
> get the sensors data if it isn't. With libsysfs 1.x it worked fine, as
> sysfs_get_mnt_path() would fail is sysfs wasn't mounted. However, since
> libsysfs 2.0.0, sysfs_get_mnt_path() appears to succeed even if sysfs
> isn't mounted. As a consequence, a sysfs-enabled libsensors will not
> work on a 2.4 kernel. So there is currently no way to build libsensors
> so that it'll work on both 2.4 and 2.6 kernels, unless you go back to
> libsysfs 1.3.0.
>=20
> I opened a bug on sourceforge:
> http://sourceforge.net/tracker/index.php?func=DEtail&aid=1567053&group_id=
D427&atidC9544

No news since then... Looks like the sysfsutils project is essentially
dead.

> There are several quick fixes possible... Testing the string returned
> by "uname -r", looking for sysfs in /proc/mounts, testing if /sys/bus
> exists, or the other way around, testing if /proc/sys/dev/sensors
> exists.

I implemented yet anther workaround: libsensors checks that the
returned mount point exists and has a link count which is more than 2.
The workaround is in the 3.x branch for quite some times already, and I
added it to the 2.x branch yesterday:
http://www.lm-sensors.org/changeset/5036

> Or we could stop using libsysfs altogether...

This is my plan for 3.0.1. libsysfs is seen as deprecated by many
distributions for being unmaintained and not really useful. And I
suspect that it has an important performance cost on the library
initialization. We will be much better without using it.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
