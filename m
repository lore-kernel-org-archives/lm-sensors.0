From: "Arturas K." <arturas@cerberis.soften.ktu.lt>
Date: Tue, 07 Oct 2008 19:34:13 +0000
Subject: [lm-sensors] a few questions about: k8temp, it8712f and atk0110
Message-Id: <48EBB9B5.9040502@cerberis.soften.ktu.lt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

hi,

I got a few questions related to lm-sensors:

1) as far as I understand k8temp inaccuracies are related to my cpu=20
hardware flaws and there is no way to work around it?

athlon x2 5400+ g2 stepping
http://products.amd.com/en-us/QuickSearch.aspx?q=ADO5400DOBOX

2) cpu fan (pwm) reading overflows at low speeds, and shows insane=20
values. the sensor chip "it8712f-s 0815-kxs me3c2c l". there are some=20
posts about newer versions using 16bits or something like this - does=20
this apply on my one? and is it possible to correct the result via=20
adjusting sensors3.conf (I prefer not to upgrade/recompile my 2.6.24.x=20
kernel)?

3) that is the status for atk0110 ? I got asus m3a780-em motherboard,=20
and hope ATK0110 readings will be prone to sensors3.conf errors, or am I=20
wrong?

p.s. I am not subscribed to the list, so cc to me please

---
ArturasK.

> ~# sensors -v && sensors -u && sensors
> sensors version 3.0.2 with libsensors version 3.0.2
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>   temp1_input: 25.00
> Core0 Temp:
>   temp2_input: 8.00
> Core1 Temp:
>   temp3_input: 19.00
> Core1 Temp:
>   temp4_input: 19.00
>=20
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:
>   in0_input: 1.14
>   in0_min: 0.00
>   in0_max: 4.08
> VCore 2:
>   in1_input: 4.08
>   in1_min: 0.00
>   in1_max: 4.08
> +3.3V:
>   in2_input: 3.22
>   in2_min: 0.00
>   in2_max: 4.08
> +5V:
>   in3_input: 6.85
>   in3_min: 5.13
>   in3_max: 6.85
> +12V:
>   in4_input: 12.86
>   in4_min: 16.26
>   in4_max: 16.32
> -12V:
>   in5_input: -15.46
>   in5_min: -27.36
>   in5_max: 3.93
> -5V:
>   in6_input: 4.03
>   in6_min: -13.64
>   in6_max: 4.03
> Stdby:
>   in7_input: 6.85
>   in7_min: 0.00
>   in7_max: 6.85
> VBat:
>   in8_input: 3.25
> fan1:
>   fan1_input: 24107.00
>   fan1_min: 0.00
>   fan1_div: 2.00
> fan2:
>   fan2_input: 0.00
>   fan2_min: 0.00
>   fan2_div: 2.00
> fan3:
>   fan3_input: 0.00
>   fan3_min: 0.00
>   fan3_div: 2.00
> M/B Temp:
>   temp1_input: 28.00
>   temp1_max: 127.00
>   temp1_min: 127.00
>   temp1_type: 2.00
> CPU Temp:
>   temp2_input: 34.00
>   temp2_max: 127.00
>   temp2_min: -69.00
>   temp2_type: 2.00
> Temp3:
>   temp3_input: 128.00
>   temp3_max: 127.00
>   temp3_min: -1.00
>   temp3_type: 0.00
> cpu0_vid:
>   cpu0_vid: 1.55
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +25.0=C2=B0C                                   =20
> Core0 Temp:   +8.0=C2=B0C                                   =20
> Core1 Temp:  +19.0=C2=B0C                                   =20
> Core1 Temp:  +19.0=C2=B0C                                   =20
>=20
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:     +1.14 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VCore 2:     +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +3.3V:       +3.22 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +5V:         +6.85 V  (min =3D  +5.13 V, max =3D  +6.85 V)
> +12V:       +12.86 V  (min =3D +16.26 V, max =3D +16.32 V)
> -12V:       -15.46 V  (min =3D -27.36 V, max =3D  +3.93 V)
> -5V:         +4.03 V  (min =3D -13.64 V, max =3D  +4.03 V)
> Stdby:       +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> VBat:        +3.25 V
> fan1:       24107 RPM  (min =3D    0 RPM, div =3D 2)
> fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 2)
> M/B Temp:    +28.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D transistor
> CPU Temp:    +34.0=C2=B0C  (low  =3D -69.0=C2=B0C, high =3D +127.0=C2=B0C=
)  sensor =3D transistor
> Temp3:      +128.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0C=
)  sensor =3D disabled
> cpu0_vid:   +1.550 V

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
