From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Dec 2011 17:41:47 +0000
Subject: Re: [lm-sensors] Sabertooth 990FX strange sensors reading in
Message-Id: <20111203184147.244814df@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPVzhpzUgRXPcPi7JHOoppC86UgoesJv18t+Mjd+41FXrfnWdQ@mail.gmail.com>
In-Reply-To: <CAPVzhpzUgRXPcPi7JHOoppC86UgoesJv18t+Mjd+41FXrfnWdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Reartes,

On Sat, 3 Dec 2011 09:02:21 -0300, Reartes Guillermo wrote:
> I am having problems with the sensors command on Fedora 16 X86_64. There
> are to many 'alarmed' sensors. Also there are problems with the temperatu=
re
> ranges, or at least this mobo is really weird.
>=20
> The mobo is an Asus Sabertooth 990FX (BIOS 0813), I boot in non-efi mode =
for
> now (since i upgraded the mobo and the cpu some), will try uefi with f16 =
in
> the
> future. I run sensor-detect when i first replaced the mobo and then when i
> replaced the cpu.
>=20
> it8721-isa-0290
> Adapter: ISA adapter
> in0:          +2.81 V  (min =3D  +1.84 V, max =3D  +2.29 V)  ALARM
> in1:          +2.74 V  (min =3D  +2.58 V, max =3D  +2.41 V)  ALARM
> in2:          +0.90 V  (min =3D  +2.65 V, max =3D  +1.04 V)  ALARM
> +3.3V:        +3.26 V  (min =3D  +0.00 V, max =3D  +2.28 V)  ALARM
> in4:          +2.66 V  (min =3D  +2.87 V, max =3D  +1.91 V)  ALARM
> in5:          +2.52 V  (min =3D  +1.12 V, max =3D  +3.05 V)
> in6:          +1.54 V  (min =3D  +3.05 V, max =3D  +3.01 V)  ALARM
> 3VSB:         +2.28 V  (min =3D  +0.00 V, max =3D  +3.74 V)
> Vbat:         +3.34 V
> fan1:        1534 RPM  (min =3D   15 RPM)
> fan2:           0 RPM  (min =3D   10 RPM)  ALARM
> fan3:         832 RPM  (min =3D   10 RPM)
> temp1:        +46.0=B0C  (low  =3D +94.0=B0C, high =3D  -5.0=B0C)  ALARM =
 sensor =3D thermistor
> temp2:        +38.0=B0C  (low  =3D +121.0=B0C, high =3D -41.0=B0C)  ALARM=
  sensor =3D thermistor
> temp3:       -128.0=B0C  (low  =3D  -1.0=B0C, high =3D  -7.0=B0C)  sensor=
 =3D disabled
> intrusion0:  OK

You need to write a configuration file for you board. It's all
explained in the FAQ:
http://www.lm-sensors.org/wiki/FAQ/Chapter2#Theminandmaxforthereadingsinsen=
sorsareincorrect

> The sensors config file and other info was uploaded to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D759667

Please change the attachment type to text/plain so that it can be
viewed on-line.

If you want help writing the configuration file, please write down and
report all monitoring information provided by the BIOS (labels and
values, in order, including multiple values where they oscillate.)

That being said... Desktop boards from Asus normally use the
asus_atk0110 driver rather than native monitoring drivers. As the
asus_atk0110 driver needs no configuration file, it would be wiser to
not waste your time on the configuration file, and instead try the
asus_atk0110 driver (and investigate if it does not work.)

> About the fans, there 2 chassis TT ISCG200, with rpm set to
> minimum manually. The cpu fan is the stock FX6100.
>=20
> kernel             2.6.41.1-1.fc15.x86_64
> lm_sensors.x86_64  3.3.1-1.fc15

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
