From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Aug 2008 19:45:09 +0000
Subject: Re: [lm-sensors] acpitz-virtual
Message-Id: <20080820214509.67061382@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200808201620.23166.michel@milk-it.net>
In-Reply-To: <200808201620.23166.michel@milk-it.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 20 Aug 2008 16:20:23 -0300, Michel Filipe wrote:
> Hi! I want know about my acpitz-virtual sensors. See what it shows:
>=20
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +55.0=B0C  (crit =3D +85.0=B0C)
> temp2:       +26.8=B0C  (crit =3D +105.0=B0C)
>=20
> I don't know what are the devices. In my dsdt.dsl file I don't search the=
 _TZD=20
> method. My dsdt.dsl file is at http://files.milk-it.net/michel/dsdt.dsl. =


The acpi to hwmon bridge driver exposes the exact same temperatures
that you can already see under /proc/acpi/thermal_zone.

We could probably update the code so that the labels default to the
ACPI thermal zone names. Sometimes these names are useful... but
sometimes not.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
