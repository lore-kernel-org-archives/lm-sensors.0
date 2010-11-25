From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Thu, 25 Nov 2010 09:40:17 +0000
Subject: Re: [lm-sensors] Winbond Super I/O chip - Sensor values
Message-Id: <49437.75.142.173.238.1290678017.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikbWvzdVA-zSVO0zx7iENffinQhbdcNLZWLy1EQ@mail.gmail.com>
In-Reply-To: <AANLkTikbWvzdVA-zSVO0zx7iENffinQhbdcNLZWLy1EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Hi
>
> When I executed the sensor program from my server, I got following O/P .
>
> OS : CentOS
> Kernel : 2.6.18
>
> VcoreA:      +1.07 V  (min =3D  +0.92 V, max =3D  +1.38 V)
> VcoreB:      +1.24 V  (min =3D  +0.00 V, max =3D  +2.05 V)
> in2:         +1.10 V  (min =3D  +0.99 V, max =3D  +1.33 V)
> in3:         +0.51 V  (min =3D  +0.40 V, max =3D  +0.67 V)
> in4:         +1.79 V  (min =3D  +1.62 V, max =3D  +1.98 V)
> in5:         +3.36 V  (min =3D  +2.96 V, max =3D  +3.63 V)
> in6:         +0.98 V  (min =3D  +0.90 V, max =3D  +1.10 V)
> +5V:         +5.05 V  (min =3D  +4.64 V, max =3D  +5.65 V)
> 5VSB:        +5.02 V  (min =3D  +4.64 V, max =3D  +5.65 V)
> Vbat:        +3.25 V  (min =3D  +2.96 V, max =3D  +3.63 V)
> fan1:          0 RPM  (min =3D  712 RPM)  ALARM
> fan2:          0 RPM  (min =3D  712 RPM)  ALARM
> fan3:          0 RPM  (min =3D  712 RPM)  ALARM
> fan4:          0 RPM  (min =3D  712 RPM)  ALARM
> fan5:          0 RPM  (min =3D  712 RPM)  ALARM
> fan6:          0 RPM  (min =3D  712 RPM)  ALARM
> fan7:       5133 RPM  (min =3D  712 RPM)
> fan8:          0 RPM  (min =3D  712 RPM)  ALARM
> fan9:          0 RPM  (min =3D  712 RPM)  ALARM
> fan10:         0 RPM  (min =3D  712 RPM)  ALARM
> temp1:       +39.0=B0C  (high =3D +81.0=B0C, hyst =3D +76.0=B0C)  sensor =
=3D Intel
> PECI
> temp2:      -103.0=B0C  (high =3D +81.0=B0C, hyst =3D +76.0=B0C)  sensor =
=3D Intel
> PECI
> temp3:      -128.0=B0C  (high =3D +81.0=B0C, hyst =3D +76.0=B0C)  sensor =
=3D Intel
> PECI
> temp4:      -128.0=B0C  (high =3D +81.0=B0C, hyst =3D +76.0=B0C)  sensor =
=3D Intel
> PECI
> temp5:       +30.0=B0C  (high =3D +50.0=B0C, hyst =3D +45.0=B0C)  sensor =
> thermistor
> temp6:       +29.0=B0C  (high =3D +50.0=B0C, hyst =3D +45.0=B0C)  sensor =
> thermistor
> beep_enable:disabled
>
>
> Why is it, some of the fan speed are shown as 0 RPM and also some
> temperature values are -ive.
>
> -Susmith
>

Fan speeds can show up as "0" if: (1) no fans are connected to those
headers; (2) 2-wire fans are connected to those headers (no fan speed
sensor wire); (3) those headers do not exist on the motherboard but they
are defined somewhere for that sensor chip. A visual inspection of your
motherboard and a "good read" of the motherboard manual are suggested.

Sometimes temp values return "very high" or "negative" values when they
are not connected to any physical sensor. Again, a visual inspection of
the motherboard and a "good read" of the manual are suggested.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
