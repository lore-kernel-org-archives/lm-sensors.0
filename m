From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 05 Feb 2011 19:15:25 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110205191525.GA26760@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Feb 05, 2011 at 02:00:09PM -0500, Andrea Rizzolo wrote:
> hi,
> thank you very much, here on intel DH57JG it works. `sensors` output:
>=20
> nct6775-isa-0680
> Adapter: ISA adapter
> in0:         +0.93 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:         +0.78 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in2:         +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in3:         +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in4:         +1.26 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in5:         +0.78 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in6:         +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in7:         +3.36 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in8:         +3.30 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> fan1:          0 RPM  (min =3D    0 RPM, div =3D 2)  ALARM
> fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)  ALARM
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 2)  ALARM
> fan4:          0 RPM  (div =3D 2)  ALARM
> temp1:       +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D diode
> temp2:       +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> temp3:       +23.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> cpu0_vid:   +2.050 V
>=20
Hi Andrea,

excellent - that matches the output I get. Now all we have to do is to matc=
h the values
to actual voltages. in2 and in3 match the 3.3V seen in the BIOS, but for th=
e others
I have no idea.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
