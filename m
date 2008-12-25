From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Dec 2008 14:29:07 +0000
Subject: Re: [lm-sensors] lm-sensors 2.10.1 with newer 2.6.x.x kernel can't
Message-Id: <200812251529.07541.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
In-Reply-To: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi John,

Le Lundi 22 D=E9cembre 2008 23:50, John Brier a =E9crit=A0:
> [root@tb303 ~]# sensors
> Can't access procfs/sysfs file
> Kernel interface access error
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
>=20
> I have Debian 4.0 with 2.10.1-3 lm-sensors and libsensors3. I read
> http://www.lm-sensors.org/wiki/Kernel2.6
>=20
> "In kernel 2.6.22, the way the I2C adapters are presented in sysfs
> changed, and this affects libsensors. You will need lm_sensors version
> 2.10.3 or later. Alternatively, the kernel can be compiled with
> CONFIG_SYSFS_DEPRECATED=3Dy, then version 2.10.2 will work too. Older
> versions of lm_sensors will complain that the I2C adapter names can't
> be read. This is only a warning though. "
>=20
> So in my kernel 2.6.26.5 I have
>=20
> # grep CONFIG_SYSFS_DEPRECATED /boot/config-2.6.26.5
> CONFIG_SYSFS_DEPRECATED=3Dy
> CONFIG_SYSFS_DEPRECATED_V2=3Dy

Preliminary note: using something as old as lm-sensors 2.10.1 with
a kernel as recent as 2.6.26.5 doesn't make much sense IMHO. We do
our best to preserve compatibility but it's hard to always get it
right.

> yet I still get this "warning" If it's only a warning why don't I get
> the actual readings from my hardware?

The warning documented above is unrelated to your problem, this is
why.

> I looked into upgrading to=20
> lm-sensors 3 and libsenseors4 packages from Debian testing tree but
> the dependencies were pretty bad, I might as well upgrade the whole
> system to testing.

Shouldn't be. For one thing you should be able to install libsensors3
and libsensors4 in parallel. Once this is done you should be able to
upgrade lm-sensors (and only lm-sensors) from version 2.x to version
3.x. I am no Debian expert though, maybe I'm missing something.

> I have run sensors-detect and have the proper modules loaded.

Which modules are these?

Please provide the full output of sensors-detect.

Did this system ever work with a different combination of lm-sensors
version and kernel version? And what system is this?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
