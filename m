From: Maarten Maathuis <madman2003@gmail.com>
Date: Mon, 31 May 2010 16:26:04 +0000
Subject: Re: [lm-sensors] Fintek F71889ED is unsupported (hack patch
Message-Id: <AANLkTina230-Eu-eGY_06Kb82ga_MD2SKshYdMDZI3ih@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikzgi3flngEea2GeiEtAwdfRDdPaMtDq_zb6jD7@mail.gmail.com>
In-Reply-To: <AANLkTikzgi3flngEea2GeiEtAwdfRDdPaMtDq_zb6jD7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, May 28, 2010 at 11:25 PM, Maarten Maathuis <madman2003@gmail.com> w=
rote:
> This appears to be a pretty new Super I/O IC, which i found on my new
> motherboard (MSI 870A-G54).
>
> I couldn't find a datasheet, but this link
> (http://code.google.com/p/open-hardware-monitor/source/detail?r=130#)
> suggests that it can be trivially added to the f71882fg driver.
>
> So i tried that, pretending it was a f71889fg.
>
> This is the output i got, i appended what i think about the values:
>
> f71889ed-isa-0600
> Adapter: ISA adapter
> in0: =A0 =A0 =A0 =A0 +1.66 V
> in1: =A0 =A0 =A0 =A0 +0.90 V =A0(max =3D =A0+2.04 V) =A0<-- Vcore, 1.11 V=
 when in high
> power mode, this seems accurate (compared to bios)
> in2: =A0 =A0 =A0 =A0 +1.07 V
> in3: =A0 =A0 =A0 =A0 +0.88 V
> in4: =A0 =A0 =A0 =A0 +0.62 V
> in5: =A0 =A0 =A0 =A0 +1.27 V
> in6: =A0 =A0 =A0 =A0 +1.55 V
> in7: =A0 =A0 =A0 =A0 +1.66 V
> in8: =A0 =A0 =A0 =A0 +1.64 V
> fan1: =A0 =A0 =A0 =A0785 RPM <-- cpu fan, accurate (compared to bios)
> fan2: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM
> fan3: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM
> temp1: =A0 =A0 =A0 +24.0 C =A0(high =3D +255.0 C, hyst =3D +251.0 C) =A0A=
LARM =A0<--
> cpu temp, probably accurate (compared to bios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D +255.0 C, hyst =3D +=
251.0 C) =A0ALARM
> sensor =3D Intel PECI
> temp2: =A0 =A0 =A0 =A0 FAULT =A0(high =3D +255.0 C, hyst =3D +251.0 C)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D +255.0 C, hyst =3D +=
251.0 C) =A0sensor =3D transistor
> temp3: =A0 =A0 =A0 +33.0 C =A0(high =3D +255.0 C, hyst =3D +253.0 C) =A0A=
LARM =A0 <--
> system temp, probably accurate (compared to bios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D +255.0 C, hyst =3D +=
253.0 C) =A0ALARM
> sensor =3D transistor
>
> So please tell me what you think, any ideas how this can be improved.
> Especially the system voltages are horribly mis-calibrated it seems.
>
> Please CC me upon reply, i am not subscribed to the mailing-list.
>
> Maarten.
>
>
> --
> Life spent, a precious moment, in the wink of an eye we live and we die.
>

Anyone?

--=20
Life spent, a precious moment, in the wink of an eye we live and we die.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
