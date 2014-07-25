From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 25 Jul 2014 15:45:30 +0000
Subject: Re: [lm-sensors] Sensors configuration for Intel D201GLY2 motherboard
Message-Id: <20140725174530.6d006b5e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
In-Reply-To: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Eric,

Please leave the list Cc'd.

On Fri, 25 Jul 2014 15:55:06 +0200, =C9ric Le Bras wrote:
> 2014-07-25 9:31 GMT+02:00 Jean Delvare <jdelvare@suse.de>:
> > On Wed, 23 Jul 2014 11:08:14 +0200, =C9ric Le Bras wrote:
> > >     label temp1 "Sys temp"
> > >     label temp2 "unknown"
> > >     label temp3 "unknown"
> >
> > If you don't know, just don't put labels, "unknown" doesn't add much
> > value. One of these is most certainly the CPU temperature, I'm
> > surprised it's not obvious. What does the output of "sensors
> > -c /dev/null" say?
>=20
> temp2 sensor is labeled as CPU diode, so it is somewhat related to CPU
> temp. However there is another measure reported by "coretemp" circuit,
> which reports the exact temperature displayed by the BIOS. So what is
> exactly temp2?

Coretemp is a digital reading straight from the CPU. Reacts very fast,
good accuracy at high temperatures, but very poor accuracy at low
temperatures. The readings from the W83627DHG chip, OTOH, are analog
temperature measurements using diodes or thermistors. So both coretemp
and temp2 are the CPU temperature, just measured differently.

> Temp3 has a weird behaviour. It lowers when the CPU load increases. I
> enclosed a graph generated with sensord. The curve for temp3 has an
> "inversed" profile, compared to other temps.

That does not mean it's wrong. You should draw the fan speed together
with the temperatures. Higher CPU temperature will typically result in
a faster spinning fan, which in turn can lower the temperature of
other parts of the system. This is even more likely for a system
without a CPU fan where the CPU cooling is achieved by the case fan.

20.5=B0C could well be the ambient temperature inside the case, if case
cooling is very good and the room temperature is cool too.

> eric@tangha /etc/sensors.d % sensors -c /dev/null
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +55.0=B0C  (high =3D +100.0=B0C, crit =3D +100.0=B0C)
>=20
> w83627dhg-isa-0290
> Adapter: ISA adapter
> in0:          +1.34 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:          +1.74 V  (min =3D  +1.66 V, max =3D  +1.83 V)
> in2:          +3.25 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in3:          +3.25 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:          +1.81 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
> in5:          +0.10 V  (min =3D  +1.41 V, max =3D  +1.72 V)  ALARM
> in6:          +1.57 V  (min =3D  +1.35 V, max =3D  +1.65 V)
> in7:          +3.25 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in8:          +3.09 V  (min =3D  +2.70 V, max =3D  +3.63 V)

in5 is way too low to be a scaled +5V. This strongly suggests that in4
is +5V (assuming in1 is really +12V - how do you know that?) If
anything, in5 could only be a negative voltage, but even then it is way
too close to 0V to be plausible. So I think it's not connected, and is
reporting noise.

If we assume that in4 is 5V then the scaling factor would be around
2.76. I used to have an Intel board with a similar monitoring chip
where +5V was on in4 and the scaling factor was:

   compute in4  @*(1+18/10),  @/(1+18/10)

That might work for you. If you have a good multimeter, you can check
on a molex connector if the resulting +5V reading is realistic (keep in
mind that the monitoring chip value is typically not more accurate than
+/- 2%.)

> fan1:        3013 RPM  (min =3D 1607 RPM, div =3D 8)
> fan2:           0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> fan3:           0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> fan4:           0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> temp1:        +43.0=B0C  (high =3D +95.0=B0C, hyst =3D +60.0=B0C)  sensor=
 =3D thermistor
> temp2:        +49.5=B0C  (high =3D +110.0=B0C, hyst =3D +75.0=B0C)  senso=
r =3D CPU diode
> temp3:        +20.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D thermistor
> cpu0_vid:    +0.000 V
> intrusion0:  ALARM

You can add an ignore statement for cpu0_vid too, as it is apparently
not connected.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
