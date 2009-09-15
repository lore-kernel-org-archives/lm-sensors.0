From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Sep 2009 13:27:37 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <20090915152737.4d77623a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 15 Sep 2009 15:11:39 +0200, Martin MOKREJ=A6 wrote:
> Jean Delvare wrote:
> > This is exactly the symptom described in the blog post I sent you to.
> > http://hansdegoede.livejournal.com/7932.html
> > Did you read it?
>=20
> I did and therefore it seemed to me the problem is with the driver.
> I haven't figured out I am using a wrong one. :( So I should probably
> go and read the FAQ again. ;-)
>=20
> >=20
> >> $ dmesg
> >> [cut]
> >> i801_smbus 0000:00:1f.3: PCI INT B -> Link[LNKB] -> GSI 11 (level, low=
) -> IRQ 11
> >> [cut]
> >>
> >> $ sensors
> >> ds1621-i2c-4-4c
> >> Adapter: SMBus I801 adapter at e800
> >> temp:     +51.00=B0C  (low  =3D +51.0=B0C, high =3D +51.0=B0C)  ALARM =
(LOW)
> >=20
> > You don't really have a DS162x chip on your system, do you? The output
> > above is rather suspicious. Does the temperature value ever changes?
>=20
> At the moment I have under 2.6.30.6:
>=20
> # sensors
> ds1621-i2c-4-4c
> Adapter: SMBus I801 adapter at e800
> temp:     +64.00=B0C  (low  =3D +64.0=B0C, high =3D +64.0=B0C)  ALARM (HI=
GH)

Once again, input =3D low =3D high, this doesn't make any sense. This has
to be a misdetection. So I suggest that you stop loading the ds1621
driver.

As this was the only chip seen by sensors-detect on your system, this
simply means that lm-sensors' native drivers are of no use on your
system. The good news is that this means the ACPI conflicts policy
change in recent kernels doesn't affect you much.

> (...)
> Once again, it is ASUS L3C/S laptop.

On laptops, thermal management is almost always handled by ACPI. So
your best chances are the acpi "thermal" driver and its bridge driver
to lm-sensors (thermal_sys, CONFIG_THERMAL=3Dm or y and
CONFIG_THERMAL_HWMON=3Dy).

And there are also a number of drivers dedicated to Asus systems, such
as asus_atk0110, asus-laptop and asus_acpi. You should try them if you
haven't already.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
