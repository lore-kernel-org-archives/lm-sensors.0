From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Sun, 08 Aug 2010 05:03:32 +0000
Subject: Re: [lm-sensors] AOpen MK33 sensors
Message-Id: <1191.75.142.172.231.1281243812.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinMaBfP8MX8CJxE38_Wj4dazE+as-+voGy_cZVa@mail.gmail.com>
In-Reply-To: <AANLkTinMaBfP8MX8CJxE38_Wj4dazE+as-+voGy_cZVa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On very old system with AOpen MK33 motherboard after
> -sensor-detect; yes to all questions
> - rebooting after installing chip via686a
> - running sensors
>
> i obtained:
>
> via686a-isa-6000
> Adapter: ISA adapter
> CPU core:    +1.80 V  (min =3D  +0.06 V, max =3D  +3.10 V)
> +2.5V:       +0.30 V  (min =3D  +0.06 V, max =3D  +3.10 V)
> I/O:         +3.36 V  (min =3D  +3.12 V, max =3D  +3.45 V)
> +5V:         +5.08 V  (min =3D  +4.73 V, max =3D  +5.20 V)
> +12V:       +12.12 V  (min =3D +11.35 V, max =3D +12.48 V)
> CPU Fan:    5357 RPM  (min =3D 2732 RPM, div =3D 2)
> P/S Fan:    3461 RPM  (min =3D 2922 RPM, div =3D 2)
> SYS Temp:   +146.2=B0C  (high =3D +146.2=B0C, hyst =3D -70.9=B0C)
> CPU Temp:   +146.2=B0C  (high =3D +146.2=B0C, hyst =3D -70.9=B0C)
> SBr Temp:    +22.1=B0C  (high =3D +73.8=B0C, hyst =3D +143.4=B0C)
>
> What is supposed to mean? I use to get nervous when i see cpu
> temperature as +146.2=B0C :)
>
> --
> Kind regards,
> Sergey Ivanov
>

Can you tell us what version of LM_Sensors you are using?

A quick look at the manual (found online) for this motherboard shows the
BIOS can display CPU & System temperatures, fan sppeds, and voltages. How
do the BIOS readings compare to the output of LM_Sensors?

Also, I noticed in the manual there is a physical pin header to connect a
sensor that is marked JP6/JP7 per the manual. Is it possible that no
sensor is connected to these pins and thus nothing is being "sensed" by
the hardware monitor chip?




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
