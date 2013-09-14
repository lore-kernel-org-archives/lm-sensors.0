From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 03:55:28 +0000
Subject: Re: [lm-sensors] ASRock IMB-170 configuration help
Message-Id: <20130914035528.GA17783@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <jaf739to4p5c3erfh5rc33qk1mg2iopfoo@4ax.com>
In-Reply-To: <jaf739to4p5c3erfh5rc33qk1mg2iopfoo@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Sep 13, 2013 at 06:42:26PM -0700, singumal wrote:
> Now that I can read sensors for this ASRock IMB-170 board (see list threa=
d "Re: Cannot
> compile w83627ehf standalone driver"), I need to configure it.  I don't s=
ee any info
> poking around the lm-sensors.org site or in a web search.  Here is the "s=
ensors" output

ASRock has a tuning utility which includes xml files for their various boar=
ds.
The file for your board includes

    <Voltage Enable=3D"1">
            <Item Index=3D"0" Name=3D"CPU_VCORE_V" Enable=3D"1">Vcore Volta=
ge</Item>
            <Item Index=3D"1" Name=3D"P3P3_V" Enable=3D"1">+3.3V Voltage</I=
tem>
            <Item Index=3D"2" Name=3D"P5P0_V" Enable=3D"1">+5.0V Voltage</I=
tem>
            <Item Index=3D"3" Name=3D"P12_V" Enable=3D"1">+12V Voltage</Ite=
m>
            <Item Index=3D"4" Name=3D"DRAM_V" Enable=3D"1" VoltageControl=
=3D"DRAM_V">DRAM Voltage</Item>
            <Item Index=3D"5" Name=3D"CPU_NB_V" Enable=3D"0" VoltageControl=
=3D"CPU_NB_V">CPU NB Voltage</Item>
            <Item Index=3D"6" Name=3D"NB_V" Enable=3D"0" VoltageControl=3D"=
NB_V">NB Voltage</Item>
            <Item Index=3D"7" Name=3D"HT_V" Enable=3D"0" VoltageControl=3D"=
HT_V">HT Voltage</Item>           =20
        </Voltage>

Based on that, you can assign voltages from in0..in7. You'll have to figure=
 out
the scale used for in1 (3.3V) and in3(12V); best might be to record voltages
in the BIOS and compare with the actual readings. The other voltages look o=
k as
far as I can see.

> (less the coretemp info) with the 3.3.4 sensors.conf.default as /etc/sens=
ors3.conf:
>=20
> w83627uhg-isa-0290
> Adapter: ISA adapter
> in0:           +0.86 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:           +1.83 V  (min =3D  +0.61 V, max =3D  +1.02 V)  ALARM
> AVCC:          +5.12 V  (min =3D  +4.49 V, max =3D  +5.49 V)
> +5V:           +5.14 V  (min =3D  +4.49 V, max =3D  +5.51 V)
> in4:           +1.71 V  (min =3D  +0.80 V, max =3D  +0.62 V)  ALARM
> in5:           +1.70 V  (min =3D  +1.80 V, max =3D  +1.64 V)  ALARM
> 5VSB:          +5.12 V  (min =3D  +4.49 V, max =3D  +5.49 V)
> Vbat:          +3.37 V  (min =3D  +2.69 V, max =3D  +3.64 V)
> fan1:            0 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
> fan2:         6026 RPM  (min =3D 21093 RPM, div =3D 16)  ALARM

That is really on the high side. Wonder if the fan is configured correctly.

Guenter

> SYSTIN:        +42.0=B0C  (high =3D  +1.0=B0C, hyst =3D -76.0=B0C)  ALARM=
  sensor =3D thermistor
> PECI Agent 1:  +26.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  senso=
r =3D Intel PECI
> intrusion0:   ALARM
>=20
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
