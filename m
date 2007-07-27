From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 27 Jul 2007 03:48:20 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707262048q6ff59abfn9dde887c82e93e21@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Jul 27, 2007, at 4:24 AM, Juerg Haefliger wrote:
>
> > yes please. and also the output of 'sensors'.
>
> Hi Juerg,
>
> thanks to track the problem down, I will help as much as I can, here
> you go:
>
>
> # isadump -y -f 0x6000 0x80
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 6000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08
> 6010: 03 10 0d c8 ec 06 78 87 00 00 00 00 02 ff 00 6b
> 6020: 6d bf c1 78 bd c4 c9 7f 73 70 00 ce ba 7b 74 ce
> 6030: a9 d6 af d4 c0 72 07 14 7b ff 00 ff ff c9 b6 b0
> 6040: 01 00 00 ff ff e0 ff 50 2d c5 03 95 55 00 0f 00
> 6050: 01 00 00 00 00 00 ff ff ff ff ff ff 00 77 11 33
> 6060: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Hmm... That doesn't make sense. What happens if you do 'isaset -y -f
0x6051 0x08'? Does the fan turn off? If yes, can you turn it back on
with 'isaset -y -f 0x651 0x00'?

...juerg


> # sensors
> vt1211-isa-6000
> Adapter: ISA adapter
> +3.3V:     +3.30 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +2.5V:     +2.46 V  (min =3D  +2.37 V, max =3D  +2.63 V)
> VCore:     +1.40 V  (min =3D  +1.35 V, max =3D  +1.44 V)
> +5V:       +5.05 V  (min =3D  +4.51 V, max =3D  +5.51 V)
> +12V:     +12.09 V  (min =3D +10.77 V, max =3D +13.22 V)
> +3.3V:     +3.28 V  (min =3D  +3.13 V, max =3D  +3.46 V)
> Case Fan: 5698 RPM  (min =3D    0 RPM, div =3D 2)
> CPU Fan:     0 RPM  (min =3D    0 RPM, div =3D 2)
> CPU Temp:  +42.3=B0C  (high =3D   +85=B0C, hyst =3D   +79=B0C)
> Int Temp:  +57.0=B0C  (high =3D   +65=B0C, hyst =3D   +60=B0C)
> vid:      +1.250 V  (VRM Version 8.5)
>
> Regards,
>
> c.
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
