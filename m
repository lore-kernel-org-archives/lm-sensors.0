From: Alexander Bruns <mailinglisten@alexander-bruns.de>
Date: Mon, 30 Mar 2015 07:12:40 +0000
Subject: Re: [lm-sensors] Call for testing: Driver for IT8620E, IT8790E
Message-Id: <5518F768.9080201@alexander-bruns.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <5518F02A.9000703@roeck-us.net>
In-Reply-To: <5518F02A.9000703@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

so for me, who tested it for Guenther, it looks ok.

Here the outcome of sensors:

holodeck ~ # sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +27.8=B0C  (crit =3D +105.0=B0C)
temp2:        +29.8=B0C  (crit =3D +105.0=B0C)

it8620-isa-0a30
Adapter: ISA adapter
in0:          +0.01 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in1:          +2.03 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in2:          +2.03 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in3:          +2.00 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in4:          +0.01 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in5:          +1.73 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in6:          +1.51 V  (min =3D  +0.00 V, max =3D  +3.06 V)
3VSB:         +3.38 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:         +2.98 V
+3.3V:        +2.83 V
fan1:         614 RPM  (min =3D   10 RPM)
fan2:         594 RPM  (min =3D   10 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
fan4:           0 RPM  (min =3D    0 RPM)
fan5:           0 RPM  (min =3D    0 RPM)
temp1:        +33.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
temp2:        +50.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
temp3:       -128.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
Intel PECI
intrusion0:  ALARM

it8790-isa-0a40
Adapter: ISA adapter
in0:          +0.06 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in1:          +0.06 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in2:          +0.06 V  (min =3D  +0.00 V, max =3D  +3.06 V)
+3.3V:        +3.70 V  (min =3D  +0.00 V, max =3D  +6.12 V)
in4:          +0.06 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in5:          +1.08 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in6:          +3.06 V  (min =3D  +0.00 V, max =3D  +3.06 V)  ALARM
3VSB:         +3.67 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:         +3.43 V
fan1:         453 RPM  (min =3D   10 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D   10 RPM)  ALARM
temp1:        +23.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
Intel PECI
temp2:        +33.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
temp3:        +51.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
intrusion0:  ALARM


MB like sensors-detects it:

holodeck ~ # sensors-detect
# sensors-detect revision 6170 (2013-05-20 21:25:22 +0200)
# System: Gigabyte Technology Co., Ltd. Z97X-Gaming G1 WIFI-BK


Many thx an Guenther for his good work.

Alex

Am 30.03.2015 um 08:41 schrieb Guenter Roeck:
> Greetings:
>
> We now have an experimental driver which supports both IT8620E and IT8790=
E.
> The driver is available from the following url.
>
>      https://github.com/groeck/it87
>
> This driver supports IT8620E and IT8790E with all known chip specialties.
> New features are:
>
> - Support for IT8620E, including up to 6 fan tachometers and up to 6 pwm
> controls
> - Support for IT8790E
> - Support for Super-IO chips at SIO address 0x4e (needed for some
> Gigabytye boards)
> - Support for two Super-IO chips in the system at the same time (needed
> for some
>    Gigabyte boards)
>
> This code will need extensive testing to be able to upstream it.
> I would kindly ask everyone who has a board with IT8620E and/or IT8790E
> to install the driver and test it, and to report the results on the
> lm-sensors mailing list.
>
> Thanks,
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
