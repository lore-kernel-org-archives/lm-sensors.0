From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Tue, 31 May 2011 18:07:15 +0000
Subject: Re: [lm-sensors] bug, I get -2 minus temperature
Message-Id: <729E8939A9B4401197AB825D770D8267@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTikqbDkfbazwjWB4kd24Jn5AG=Aj3w@mail.gmail.com>
In-Reply-To: <BANLkTikqbDkfbazwjWB4kd24Jn5AG=Aj3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi

--------------------------------------------------
From: "Fred ." <eldmannen@gmail.com>
Sent: Tuesday, May 31, 2011 7:31 PM
To: "LM Sensors" <lm-sensors@lm-sensors.org>
Subject: [lm-sensors] bug, I get -2 minus temperature

> $ sensors
> it8718-isa-0290
> Adapter: ISA adapter
> in0:         +1.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in1:         +1.79 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in2:         +3.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +5V:         +2.96 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in4:         +0.19 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in5:         +0.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in6:         +0.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in7:         +3.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> Vbat:        +3.12 V
> fan1:       1901 RPM  (min =3D   10 RPM)
> fan2:          0 RPM  (min =3D    0 RPM)
> fan3:          0 RPM  (min =3D    0 RPM)
> fan4:          0 RPM  (min =3D    0 RPM)
> temp1:       +54.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D=20
> thermistor
> temp2:       +36.0=B0C  (low  =3D +127.0=B0C, high =3D +60.0=B0C)  sensor=
 =3D thermal=20
> diode
> temp3:        -2.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D=20
> thermistor
>
> It says -2.0=B0C, thats crazy! It must be some bug!
> Nothing in my computer is -2.0=B0C, thats ice cold!
>
> Please fix this bug.
>
> Also, the other values are they ok or bad?
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

Firstly I don't think it's a bug, you just don't have a sensor attached to =

temp3, so just set it to ignore in your sensors3.conf file.

Your voltages look wrong, I imagine you'l need to use calculated values to =

get your 5 and 12volt values. But without knowing what motherboard it is we=
=20
can't say much.

Secondly, and more importantly if you want someone to help you, don't deman=
d=20
that someone "fixes this". Ask nicely and people will help. We don't get=20
paid for this, it's more a free time/hobby thing.

Regards
Ian Dobson
=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
