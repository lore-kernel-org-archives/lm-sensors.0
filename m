From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 21 Aug 2012 15:01:14 +0000
Subject: Re: [lm-sensors] Chassis fan is reported incorrectly with M5A78L motherboard
Message-Id: <20120821150114.GA25732@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20531.32769.603792.771925@freddi.uddeborg>
In-Reply-To: <20531.32769.603792.771925@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Aug 21, 2012 at 04:02:32PM +0200, Luca Tettamanti wrote:
> On Tue, Aug 21, 2012 at 03:43:24PM +0200, G=F6ran Uddeborg wrote:
> > Luca Tettamanti:
> > > Hum, this is likely a bug in ACPI code, please send me a copy of
> > > /sys/firmware/acpi/tables/DSDT
> >=20
> > Sent off list.  In case anyone else also would be interested, I placed
> > it at ftp://ftp.uddeborg.se/pub/DSDT too.
>=20
> Yep, broken BIOS:
>=20
> Method (FGET, 1, NotSerialized)
> {
>     If (LEqual (Arg0, Zero))
>     {
>         Return (^^SIOR.HWF1 ())
>     }
>=20
>     If (LEqual (Arg0, One))
>     {
>         Return (^^SIOR.HWF1 ())
>     }
> }
>=20
> It always reads the same sensor. The other ("new") monitoring interface
> seems fine though. Unload the module and try reloading it with
> "new_if=3D1", like this:
>=20
> modprobe asus_atk0110 new_if=3D1
>=20
> And see if everything looks good.
>=20
If it does, should we add the board to atk_force_new_if[] ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
