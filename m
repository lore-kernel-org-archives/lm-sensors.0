From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Sep 2008 07:50:42 +0000
Subject: Re: [lm-sensors] EVGA nForce 750i motherboard
Message-Id: <20080908095042.0f35b34a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C49CDE.7090800@gmail.com>
In-Reply-To: <48C49CDE.7090800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Dean,

On Sun, 07 Sep 2008 20:32:46 -0700, Dean Loros wrote:
> I have just setup a EVGA nForce 750i motherboard for Ubuntu (8.10
> testing) & have several ALARM sections. Question is how do I just report
> the voltages/fan speeds without alarms?

There is no option to hide alarms. What you must do is
adjust /etc/sensors3.conf to match your motherboard. After adding "set"
statements to set proper sensor limits, and running "sensors -s", the
alarms should vanish. It can take some time and tries before you get
things right, due to the motherboard-specific nature of the settings
and the fact that most motherboard vendors don't document the sensor
wiring. The easiest way in my experience is to compare with either what
the BIOS prints or what the monitoring software provided by the board
vendor prints.

> I am using 3.02 supplied by Ubuntu--listed as sensors are:
>=20
> lm78-i2c-1-2d, w83627dhg-isa-0290, coretemp & acpitz-virtual-0
>=20
> The coretemp & acpitz-virtual-0 are working in range--most of the
> readings for the lm78 & w83627dhg are throwing alarms even after I
> spread the voltage/fanspeed ranges. Output follows:
>=20
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +40.0=B0C  (crit =3D +60.0=B0C)
>
> lm78-i2c-1-2d
> Adapter: SMBus nForce2 adapter at 1c80
> VCore 1:     +2.53 V  (min =3D  +2.18 V, max =3D  +3.25 V)
> VCore 2:     +2.10 V  (min =3D  +1.86 V, max =3D  +3.25 V)   ALARM
> +3.3V:       +3.31 V  (min =3D  +2.30 V, max =3D  +3.47 V)   ALARM
> +5V:         +3.31 V  (min =3D  +3.50 V, max =3D  +4.08 V)   ALARM
> +12V:        +2.56 V  (min =3D  +4.08 V, max =3D  +4.08 V)   ALARM
> -12V:        +3.10 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> -5V:         +3.66 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> fan1:       2986 RPM  (min =3D 2657 RPM, div =3D 2)  ALARM
> fan2:       2556 RPM  (min =3D  998 RPM, div =3D 8)  ALARM
> fan3:       4963 RPM  (min =3D 10714 RPM, div =3D 2)  ALARM
> temp1:       +98.0=B0C  (high =3D +100.0=B0C, hyst =3D +120.0=B0C)  ALARM
> cpu0_vid:   +3.100 V

This is highly improbable that you actually have an LM78 chip on a
recent motherboard. This most certainly is a misdetection. Could be
that the W83627DHG chip is connected to both the LPC bus and the SMBus.
Did sensors-detect tell you to load the lm78 driver? Which kernel are
you running? Please unload the lm78 and w83627ehf drivers and provide
the following dumps:

isadump 0x295 0x296
i2cdump 1 0x2d b

Maybe sensors-detect needs to be taught that the W83627DHG can also
live on the SMBus.

Then you can reload the w83627ehf driver, but you should NOT load the
lm78 driver again.

>=20
> w83627dhg-isa-0290
> Adapter: ISA adapter
> VCore:       +1.26 V  (min =3D  +1.09 V, max =3D  +1.62 V)
> in1:         +6.86 V  (min =3D  +6.12 V, max =3D +10.72 V)
> AVCC:        +3.31 V  (min =3D  +2.30 V, max =3D  +3.47 V)
> 3VCC:        +3.31 V  (min =3D  +3.50 V, max =3D  +4.08 V)   ALARM
> in4:         +1.28 V  (min =3D  +2.04 V, max =3D  +2.04 V)   ALARM
> in5:         +1.55 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in6:         +5.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> VSB:         +3.31 V  (min =3D  +1.57 V, max =3D  +0.02 V)   ALARM
> VBAT:        +3.02 V  (min =3D  +0.10 V, max =3D  +1.54 V)   ALARM
> Case Fan:   3000 RPM  (min =3D 2657 RPM, div =3D 2)
> CPU Fan:    2556 RPM  (min =3D  998 RPM, div =3D 8)
> Aux Fan:    1240 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
> fan4:       1622 RPM  (min =3D  912 RPM, div =3D 8)
> fan5:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> Sys Temp:    +98.0=B0C  (high =3D +100.0=B0C, hyst =3D +120.0=B0C)  senso=
r =3D thermistor

This one is a bit frightening. What does the BIOS say?

> CPU Temp:    +52.5=B0C  (high =3D +127.0=B0C, hyst =3D  +0.0=B0C)  sensor=
 =3D transistor
> AUX Temp:    +37.0=B0C  (high =3D +127.0=B0C, hyst =3D  +0.0=B0C)  sensor=
 =3D thermistor
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +60.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +61.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +64.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +65.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
