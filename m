From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Sep 2009 13:04:17 +0000
Subject: Re: [lm-sensors] Need help in deciphering sensors output (BIOS
Message-Id: <20090902150417.70ea09cc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 18 Aug 2009 17:17:22 -0400 (EDT), Artem Tashkinov wrote:
> Hi!
>=20
> With the recent BIOS update, my lm_sensors no longer correctly show many =
readings (or I don't know how to set up /etc/sensors.conf correctly).
>=20
> Hardware info:
>=20
> Motherboard: Gigabyte M61P-S3, monitoring chip it87, BIOS revision F7f.
>=20
> lm_sensors: lm_sensors-3.1.0-1.fc11.i586
> Kernel: 2.6.30.1 (vanilla)
>=20
> # sensors-detect output:
>=20
> Driver `it87':
> * ISA bus, address 0x290
> Chip `ITE IT8716F Super IO Sensors' (confidence: 9)
>=20
> Driver `adt7473':
> * Bus `NVIDIA i2c adapter '
> Busdriver `nvidia', I2C address 0x2e
> Chip `Analog Devices ADT7473' (confidence: 5)
>=20
> Driver `k8temp':
> * Chip `AMD K8 thermal sensors' (confidence: 9)
>=20
> $ sensors output:
>=20
> sensors
> it8716-isa-0290
> Adapter: ISA adapter
> in0: +1.10 V (min =3D +0.00 V, max =3D +4.08 V)
> in1: +1.89 V (min =3D +0.00 V, max =3D +4.08 V)
> in2: +3.33 V (min =3D +0.00 V, max =3D +4.08 V)
> in3: +3.34 V (min =3D +0.00 V, max =3D +4.08 V)
> in4: +3.02 V (min =3D +0.00 V, max =3D +4.08 V)
> in5: +3.22 V (min =3D +0.00 V, max =3D +4.08 V)
> in6: +1.15 V (min =3D +0.00 V, max =3D +4.08 V)
> in7: +3.34 V (min =3D +0.00 V, max =3D +4.08 V)
> Vbat: +3.04 V
> fan1: 1394 RPM (min =3D 0 RPM)
> fan2: 1344 RPM (min =3D 0 RPM)
> temp1: +40.0=B0C (low =3D +127.0=B0C, high =3D +60.0=B0C) sensor =3D ther=
mistor
> temp2: +40.0=B0C (low =3D +127.0=B0C, high =3D +127.0=B0C) sensor =3D the=
rmistor
> temp3: +26.0=B0C (low =3D +127.0=B0C, high =3D +60.0=B0C) sensor =3D ther=
mal diode
> cpu0_vid: +0.538 V
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp: +37.0=B0C
> Core1 Temp: +30.0=B0C
>=20
> I wonder where +12V and +5V lines are, which were shown before BIOS updat=
e. Gigabyte own utility shows that data correctly.

I'm fairly certain this doesn't have anything to do with the BIOS
update. The labels must have gone away after an upgrade of the
lm-sensors package. We're removed most labels by default on purpose
because the actual wiring is mainboard dependent and we prefer to
display raw values rather than mislabeled or misscaled values.

You can revert to the old behavior by pointing "sensors" to the old
configuration file, which is still distributed as etc/sensors.conf.eg
in our source package.

But of course, even better is to come up with a custom configuration
file for your mainboard model. Apparently we do not have one for this
model yet. If you compare the values displayed by the BIOS with the
values displayed by "sensors", it is possible to come up with a mapping
and scaling factors.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
