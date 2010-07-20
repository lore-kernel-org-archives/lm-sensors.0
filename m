From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 20 Jul 2010 01:24:16 +0000
Subject: Re: [lm-sensors] W83667HG-B testing
Message-Id: <20100720012416.GA25825@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C42ED6C.9030903@preclik.de>
In-Reply-To: <4C42ED6C.9030903@preclik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Jul 18, 2010 at 08:02:52AM -0400, Tobias Preclik wrote:
> Hi,
>=20
> my Zotac board H55-ITX features the W83667HG-B chip. I downloaded and
> compiled the standalone kernel module today. Here's the sensors output:
>=20
> The module loads fine:
>=20
> # modprobe w83627ehf
> # tail -n 1 /var/log/messages
> Jul 18 13:42:58 leela kernel: [50378.028634] w83627ehf: Found W83667HG-B
> chip at 0xa10
> # sensors
> w83667hg-isa-0a10
> Adapter: ISA adapter
> in0:         +0.98 V  (min =3D  +0.00 V, max =3D  +1.74 V) =20
> in1:         +1.11 V  (min =3D  +0.10 V, max =3D  +0.20 V)   ALARM
> in2:         +3.36 V  (min =3D  +3.95 V, max =3D  +3.28 V)   ALARM
> in3:         +3.36 V  (min =3D  +1.57 V, max =3D  +2.10 V)   ALARM
> in4:         +1.10 V  (min =3D  +1.74 V, max =3D  +1.87 V)   ALARM
> in5:         +1.18 V  (min =3D  +1.02 V, max =3D  +1.30 V) =20
> in7:         +3.28 V  (min =3D  +3.23 V, max =3D  +2.62 V)   ALARM
> in8:         +3.34 V  (min =3D  +3.18 V, max =3D  +0.05 V)   ALARM
> fan1:          0 RPM  (min =3D 3515 RPM, div =3D 128)  ALARM
> fan2:       1022 RPM  (min =3D 1638 RPM, div =3D 8)  ALARM
> fan3:          0 RPM  (min =3D  958 RPM, div =3D 128)  ALARM
> fan4:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> fan5:          0 RPM  (min =3D 3515 RPM, div =3D 128)  ALARM
> temp1:       +30.0=B0C  (high =3D -56.0=B0C, hyst =3D -17.0=B0C)  ALARM  =
sensor > thermistor
> temp2:       +41.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> temp3:        -3.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> cpu0_vid:   +0.000 V
>=20
Actual values look mostly good, but the limits are really off.
Difficult to say, though, if those are wrong readings or just badly configu=
red.

Jean, any idea/thoughts ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
