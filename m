From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Feb 2009 17:50:50 +0000
Subject: Re: [lm-sensors] Intel DQ45CB motherboard and weird sensors output
Message-Id: <20090217185050.6094e9a9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <499372A3.6080803@frugalware.org>
In-Reply-To: <499372A3.6080803@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Gabriel,

On Thu, 12 Feb 2009 01:51:47 +0100, Gabriel C wrote:
> (...)
> sensors-detect detects an LM96000 chip ( with lm85 driver ? ) on
> smbus but all temperatures are empty ?;/
> (...)
> The sensors output after loading coretemp and lm85 is :
>=20
> lm85-i2c-0-2e
> Adapter: SMBus I801 adapter at f000
> V1.5:        +0.00 V  (min =3D  +0.00 V, max =3D  +3.32 V)
> VCore:       +0.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +0.00 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> V5:          +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:         +0.00 V  (min =3D  +0.00 V, max =3D +15.94 V)
> CPU_Fan:       0 RPM  (min =3D    0 RPM)  ALARM
> fan2:          0 RPM  (min =3D    0 RPM)  ALARM
> fan3:          0 RPM  (min =3D    0 RPM)  ALARM
> fan4:          0 RPM  (min =3D    0 RPM)  ALARM
> CPU Temp:     +0.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> Board Temp:   +0.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> Remote Temp:  +0.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> cpu0_vid:   +2.050 V
> (...)
> Any idea what is wrong here ?

Seems to be the same as:
http://www.lm-sensors.org/ticket/2182

Please try to find out what your Super-I/O chip is. My current theory
is that the above output is from a WPCD377I, which is compatible with
the PC8374L except that it doesn't include hardware monitoring
features. Why the designers would have made the chip still answer on
the SMBus is beyond me.

So, please try to figure out if your Intel DQ45CB board has a PC8374L
or WPCD377I or something else. If it is confirmed that the WPCD377I
present itself as a disabled LM96000 I'll fix sensors-detect to no
longer report it as an LM96000.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
