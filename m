From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Dec 2008 08:53:12 +0000
Subject: Re: [lm-sensors] Help with configuration on k7s41
Message-Id: <20081203095312.07e7a0bc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Noel,

On Mon, 24 Nov 2008 20:27:12 +0100, Noel David Torres Ta=F1o wrote:
> Please CC me, I'm not suscribed.
>=20
> I'm using your program with almost no problem in one of my computers (man=
y thanks), but I have these results in the other one:
>=20
> w83697hf-isa-0290
> Adapter: ISA adapter
> VCore:       +1.57 V  (min =3D  +1.71 V, max =3D  +1.89 V)   ALARM
> +3.3V:       +3.22 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +5V:         +4.89 V  (min =3D  +4.76 V, max =3D  +5.24 V)
> +12V:       +11.49 V  (min =3D +10.82 V, max =3D +13.19 V)
> -12V:        +0.72 V  (min =3D -13.18 V, max =3D -10.80 V)   ALARM
> -5V:         +1.94 V  (min =3D  -5.25 V, max =3D  -4.75 V)   ALARM
> V5SB:        +5.38 V  (min =3D  +4.76 V, max =3D  +5.24 V)   ALARM
> VBat:        +3.36 V  (min =3D  +2.40 V, max =3D  +3.60 V)
> fan1:          0 RPM  (min =3D 2163 RPM, div =3D 8)  ALARM
> fan2:       2812 RPM  (min =3D 1875 RPM, div =3D 8)
> temp1:       +35.0=B0C  (high =3D +70.0=B0C, hyst =3D +64.0=B0C)  sensor =
=3D thermistor
> temp2:       +37.5=B0C  (high =3D +120.0=B0C, hyst =3D +120.0=B0C)  senso=
r =3D thermistor
> beep_enable:enabled
>=20
> It is running, so I suppose all these ALARMs are false.

These alarms simply mean that the measured value is outside of the
programmed range. To make them go away, you must add suitable limits to
the libsensors configuration file in the form of "set" statements, then
run "sensors -s" to write the new limits to the chip.

> Could you help me configuring the /etc/sensors3.conf ?
>=20
> The motherboard is an ASROCK K7S41

Writing motherboard-specific configuration files isn't trivial, and we
do not have a configuration file ready for this model. A few comments
though:

* in0_min and in0_max need to be adjusted based on the nominal voltage
  of your CPU. So you must find this information about your CPU and
  then edit the "set in0_min" and "set in0_max" statements.

* in5 and in6 are either not -12V and -5V, or different resistors are
  used for scaling. Not surprising, as -12V and -5V are almost unused
  in modern computers, monitoring them isn't that useful. Maybe these
  lines are used to monitor something else. You can comment out the
  "compute in5" and "compute in6" statements to see the raw readings.
  Also compare with what your BIOS and/or vendor-provided Windows tool
  is displaying.

* V5SB is a little high. Either non-standard resistors are used, or it
  is really that high and you can increase in7_max to 5*1.10 to make the
  alarm go away. Again, compare with the BIOS value if possible.

* If you only have one monitored fan in your system, you can add
    ignore fan1
  to your configuration file.

* If fan2 is your CPU fan, you can add=20
    label fan2 "CPU Fan"
  to your configuration file.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
