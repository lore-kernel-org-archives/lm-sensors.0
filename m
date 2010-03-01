From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 01 Mar 2010 10:35:48 +0000
Subject: Re: [lm-sensors] ASUS CUSL2: sensors work with 2.6.30,
Message-Id: <20100301113548.7551be7d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100301033233.66b4f25f@natsu>
In-Reply-To: <20100301033233.66b4f25f@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Roman,

On Mon, 1 Mar 2010 03:32:33 +0500, Roman Mamedov wrote:
> On Mon, 1 Mar 2010 03:25:08 +0500
> Roman Mamedov <roman@rm.pp.ru> wrote:
>=20
> > I have a Pentium III with ASUS CUSL2 motherboard. When it is booted into
> > the kernel 2.6.30, the sensors are detected and work fine. But when the
> > kernel is 2.6.33, no sensors are detected. I did not try any kernel ver=
sions
> > in between for now. Any idea what could be the cause? Attaching
> > sensors-detect outputs from under both kernels.
>=20
> Hm, looking at the driver's history, I believe it is caused by the second
> change in that commit:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dbl=
obdiff;f=3Ddrivers/hwmon/w83781d.c;h=D38b9ede3abd1851b72d47ba0088678d01ecff=
b4;hp=E0fa7520400d8c565f0b7c77034a6c0e35cf4a1a;hbg22feada7f6213ba06d510ef85=
3e57ddcd59dae;hpb=7Fce084a0b3e2bb8caef919f8f36065953655bb5
> (shorter URL in case the above one breaks: http://ur1.ca/nwxs )

I don't think so. The commit in question basically dropped support for
I2C addresses 0x20-0x27, but according to sensors-detect, your chip
lives at I2C address 0x2d:

> Driver `w83781d':
>   * Bus `SMBus I801 adapter at e800'
>     Busdriver `i2c_i801', I2C address 0x2d
>     Chip `as99127f' (confidence: 6)

The output of sensors-detect on 2.6.33 shows that the SMBus is not even
scanned, even though the PCI device is present. So the problem is not
with the w83781d driver (hardware monitoring chip) but with the
i2c-i801 driver (SMBus controller).

That being said, there are no relevant changes to the i2c-i801 driver
between kernels 2.6.30 and 2.6.33. So most likely the problem is
elsewhere. Could be the common ACPI resource conflict issue, even
though I am surprised that such an old mainboard would be affected.

Please provide:
* The contents of /proc/ioports
* The output of "isadump -f 0x290 16"
* The kernel log messages when cycling the i2c-i801 driver ("rmmod
  i2c-i801 && modprobe i2c-i801" as root)
* The output of "dmidecode -t baseboard -t system"

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
