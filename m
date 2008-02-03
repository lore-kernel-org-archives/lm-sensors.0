From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Feb 2008 17:04:55 +0000
Subject: Re: [lm-sensors] pwmconfig with k8temp
Message-Id: <20080203180455.1b012961@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47A27D33.2080805@gmx.de>
In-Reply-To: <47A27D33.2080805@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hallo Heinz,

On Fri, 01 Feb 2008 03:00:19 +0100, Heinz Schuster wrote:
> Hello!
>=20
> Congratulation for this nice program!
>=20
> But had problems with the pwmconfig configuration.
>=20
> In my system, the pwm's could not should down.

Err, what do you mean please?

>=20
> Then i had changed the line 191 in the pwmconfig file.
>=20
> from "if [ $? -ne 0 ]"  to "if [ $? -ne 1 ]".
>=20
> Now, its wunderfull!

Which version of lm-sensors are you running? the pwmconfig script has
seen a lot of improvements and fixes lately, so this might as well be
already fixed. Please try again with the pwmconfig script from
lm-sensors 3.0.1:

http://www.lm-sensors.org/browser/lm-sensors/tags/V3-0-1/prog/pwm/pwmconfig=
?format=3Draw

If the problem still exists there, I'll investigate.

>=20
> I used the Ubuntu 7.10 AMD_64 Version.
>=20
> My System ist a Asrock AM2NF3-VSTA=20
> <http://www.asrock.com/mb/overview.asp?Model=3DAM2NF3-VSTA&s=3D>
>=20
> with a AMD Athlon(tm) 64 X2 Dual Core Processor 3600+.
>=20
>=20
>=20
> SENSORS:
>=20
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>              +32=B0C
> Core1 Temp:
>              +35=B0C
>=20
> w83627ehf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.10 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:       +7.39 V  (min =3D +13.41 V, max =3D +13.46 V) ALARM
> AVCC:      +3.38 V  (min =3D  +4.05 V, max =3D  +1.78 V) ALARM
> 3VCC:      +3.38 V  (min =3D  +4.02 V, max =3D  +1.97 V) ALARM
> in4:       +1.71 V  (min =3D  +1.98 V, max =3D  +0.89 V) ALARM
> in5:       +1.74 V  (min =3D  +1.98 V, max =3D  +1.74 V) ALARM
> in6:       +5.96 V  (min =3D  +4.74 V, max =3D  +4.02 V) ALARM
> VSB:       +3.38 V  (min =3D  +3.55 V, max =3D  +3.95 V) ALARM
> VBAT:      +3.23 V  (min =3D  +4.08 V, max =3D  +3.57 V) ALARM
> in9:       +1.58 V  (min =3D  +2.02 V, max =3D  +1.53 V) ALARM
> Case Fan: 1704 RPM  (min =3D  672 RPM, div =3D 8)
> CPU Fan:  1278 RPM  (min =3D  664 RPM, div =3D 8)
> Aux Fan:     0 RPM  (min =3D    0 RPM, div =3D 128)
> fan5:        0 RPM  (min =3D    0 RPM, div =3D 128)
> Sys Temp:    +33=B0C  (high =3D    -5=B0C, hyst =3D  +123=B0C)=20
> CPU Temp:  +39.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)=20
> AUX Temp:  +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
