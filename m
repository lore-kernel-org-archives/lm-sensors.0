From: Michiel <michiel@ettema.net>
Date: Wed, 16 Mar 2011 09:49:20 +0000
Subject: Re: [lm-sensors] [PATCH v5 00/11] hwmon: (w83627ehf) Add support
Message-Id: <1300268960.2000.12.camel@zolder>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I installed the stand alone module you created for the nct6775f and
basic functionality seems OK. Although the voltage sensor readings seem
a bit nonsensical. This is on an ASRock 870iCafe motherboard.
( http://www.asrock.com/mb/overview.asp?Model=870iCafe )

It has 2 4pin fan connectors and 1 3pin connector. I'm still trying to
configure those for use with fancontrol. But I'm not there yet..

Thanks for all time and hard work you punt in to lm-sensors ! :-)
=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +17.5=EF=BF=BD=EF=BF=BDC  (high =3D +70.0=EF=BF=BD=EF=BF=BDC=
)                 =20
>=20
> nct6775-isa-0290
> Adapter: ISA adapter
> in0:         +0.99 V  (min =3D  +0.00 V, max =3D  +1.74 V)  =20
> in1:         +1.85 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in2:         +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in3:         +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in4:         +0.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in5:         +1.67 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in6:         +1.70 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in7:         +3.44 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in8:         +3.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> fan1:       1095 RPM  (min =3D    0 RPM, div =3D 8)  ALARM
> fan2:       1095 RPM  (min =3D    0 RPM, div =3D 8)  ALARM
> fan3:       1180 RPM  (min =3D    0 RPM, div =3D 8)  ALARM
> SYSTIN:      +30.0=EF=BF=BD=EF=BF=BDC  (high =3D  +0.0=EF=BF=BD=EF=BF=BDC=
, hyst =3D  +0.0=EF=BF=BD=EF=BF=BDC)  ALARM  sensor =3D thermistor
> CPUTIN:      +26.5=EF=BF=BD=EF=BF=BDC  (high =3D +80.0=EF=BF=BD=EF=BF=BDC=
, hyst =3D +75.0=EF=BF=BD=EF=BF=BDC)  sensor =3D thermistor
> AUXTIN:      -12.5=EF=BF=BD=EF=BF=BDC  (high =3D +80.0=EF=BF=BD=EF=BF=BDC=
, hyst =3D +75.0=EF=BF=BD=EF=BF=BDC)  sensor =3D thermistor
> cpu0_vid:   +0.375 V




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
