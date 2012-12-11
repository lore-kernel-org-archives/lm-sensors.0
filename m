From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Dec 2012 09:26:07 +0000
Subject: Re: [lm-sensors] Fwd:  Driver for Bulldozer
Message-Id: <20121211102607.20eb3e83@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH3ou4U_v5oFGivFPKMKKWKG7guueS=byF5pTqB8Q9VuDQ@mail.gmail.com>
In-Reply-To: <CAMcsHH3ou4U_v5oFGivFPKMKKWKG7guueS=byF5pTqB8Q9VuDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Vahid,

On Tue, 11 Dec 2012 04:19:17 -0500, Vahid Keykhaey wrote:
> When I try to install cpufreqmodules, I get a fail on "loading cpufreq
> kernel modules".

I don't know what your distribution is doing and I don't know if your
CPU supports frequency scaling. Without detailed error messages, we
can't help. Plus this is unrelated to lm-sensors anyway.

> and the result of my sensors-detect command is enclosed.
>=20
> thank you for your help. I do not need power monitoring modules but therm=
al
> monitoring modules.
> (...)
> fam15h_power-pci-00c4
> Adapter: PCI adapter
> power1:      119.40 W  (crit =3D 124.95 W)
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +26.0=B0C  (high =3D +70.0=B0C)
>=20
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:        +1.30 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:          +0.38 V  (min =3D  +0.98 V, max =3D  +1.94 V)  ALARM
> AVCC:         +3.36 V  (min =3D  +3.25 V, max =3D  +1.26 V)  ALARM
> +3.3V:        +3.36 V  (min =3D  +2.53 V, max =3D  +0.18 V)  ALARM
> in4:          +1.68 V  (min =3D  +0.03 V, max =3D  +1.82 V)
> in5:          +1.74 V  (min =3D  +1.68 V, max =3D  +1.21 V)  ALARM
> in6:          +1.88 V  (min =3D  +1.96 V, max =3D  +1.38 V)  ALARM
> 3VSB:         +3.47 V  (min =3D  +1.31 V, max =3D  +3.63 V)
> Vbat:         +3.42 V  (min =3D  +2.82 V, max =3D  +2.86 V)  ALARM
> fan1:           0 RPM  (min =3D 6026 RPM, div =3D 16)  ALARM
> fan2:           0 RPM  (min =3D 1757 RPM, div =3D 16)  ALARM
> fan3:        3375 RPM  (min =3D  700 RPM, div =3D 8)
> fan5:           0 RPM  (min =3D 12053 RPM, div =3D 16)  ALARM
> temp1:        +34.0=B0C  (high =3D  -6.0=B0C, hyst =3D +15.0=B0C)  ALARM =
 sensor =3D thermistor
> temp2:        +46.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D thermistor
> temp3:        +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D thermistor
> intrusion0:  ALARM

So, everything works just fine. What are you complaining about exactly,
please?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
