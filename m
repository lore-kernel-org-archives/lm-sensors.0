From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Feb 2009 21:33:49 +0000
Subject: Re: [lm-sensors] AMD 690G motherboards?
Message-Id: <20090208223349.1933e98b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1LUlss-0003yf-U8@mendel.bio.caltech.edu>
In-Reply-To: <E1LUlss-0003yf-U8@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 08 Feb 2009 12:42:15 -0800, David Mathog wrote:
> Jean Delvare <khali@linux-fr.org>, wrote:
> > On Wed, 04 Feb 2009 09:49:58 -0800, David Mathog wrote:
> > >=20
> > > Here is the full output of "sensors"
> > > acpitz-virtual-0
> > > Adapter: Virtual device
> > > temp1:        +8.0 =B0C  (crit =3D +75.0 =B0C)                 =20
> >=20
> > Apparently the ACPI thermal zone reads the temperature from the
> > IT8716F's temp1, but it happens to be incorrect. Note that accessing
> > the sensors from both ACPI and native drivers is dangerous, so you
> > should load either thermal or it87 but not both.
>=20
> How does one disable this acpitz-virtual-0 method?  sensors is reporting
> it, but I don't see that sensors configured it.  /etc/modules only has:
>=20
> fuse
> lp
> it87
> k8temp
>=20
> None of which seem related to acpitz-virtual-0

The thermal driver is usually loaded by distribution scripts. Or
maybe it is auto-loaded by now. In the former case, you must find a
distribution-specific way to prevent the module from loading. In the
latter case you have to blacklist the driver, usually by adding
"blacklist thermal" in any file under /etc/modprobe.d.

That being said, you should only do that if ACPI doesn't take care of
thermal management on your system. It usually doesn't on desktop and
does on laptops, but YMMV.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
