From: Len Brown <lenb@kernel.org>
Date: Wed, 12 Aug 2009 03:43:39 +0000
Subject: Re: [lm-sensors] Revert "ACPICA: Remove obsolete
Message-Id: <alpine.LFD.2.00.0908112331250.8449@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary_(ID_dPFgyiOmZstDEgehGlrF/w)"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LFD.2.00.0908021306270.3293@sony-vgn-z540>
 <20090803074620.GA2285@phenom2.trippelsdorf.de>
In-Reply-To: <20090803074620.GA2285@phenom2.trippelsdorf.de>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_dPFgyiOmZstDEgehGlrF/w)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: QUOTED-PRINTABLE

(cc: lm-sensors)

> >     Revert "ACPICA: Remove obsolete acpi_os_validate_address inte=
rface"
> >    =20
> >     This reverts commit f9ca058430333c9a24c5ca926aa445125f88df18.
> >    =20
> >     which caused a regression:
> >    =20
> >     http://bugzilla.kernel.org/show_bug.cgi?id=3D13620
> >    =20
>=20
> This revert breaks it8720 hardware monitoring on my machine:
>=20
> ACPI: I/O resource it87 [0x295-0x296] conflicts with ACPI region EC=
RE [0x290-0x2af]
> ACPI: Device needs an ACPI driver

Thanks for the report, but I don't have a simple answer for you.

The mechanism that is restored to 2.6.29 behaviour here
is intended to address an extremely severe bug in Linux
where native sensor drivers access the same registers
as AML, causing fun things like change of temperature units and
spurious critical thermal shutdowns.
The commit that we reverted here was an oversight in 2.6.30,
and so the current plan is to revert that commit in 2.6.30.stable too=
.

The mechanism prevents the sensor driver from loading when
such a potential conflict is detected.

If you can attach the output of acpidump from your machine
to a new bugzilla entry, we can verify that the mechanism
is indeed not mistaken on your box.

thanks,
Len Brown, Intel Open Source Technology Center

> Reverting the revert solves the problem:
>=20
> markus@phenom2 ~ % sensors
> it8720-isa-0290
> Adapter: ISA adapter
> in0:         +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
> in1:         +1.65 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in2:         +1.14 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in3:         +3.09 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in4:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
> in5:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
> in6:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
> in7:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
> in8:         +3.41 V
> fan1:       1175 RPM  (min =3D    0 RPM)
> fan2:       1175 RPM  (min =3D    0 RPM)
> fan3:        859 RPM  (min =3D    0 RPM)
> temp1:       +37.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  =
sensor =3D thermistor
> temp2:       +41.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  =
sensor =3D thermistor
> temp3:      -128.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  =
sensor =3D disabled
> cpu0_vid:   +1.550 V
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +37.8=B0C
>=20
> dmesg and .config is attached.
>=20
> --=20
> Markus
>=20


--Boundary_(ID_dPFgyiOmZstDEgehGlrF/w)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary_(ID_dPFgyiOmZstDEgehGlrF/w)--
