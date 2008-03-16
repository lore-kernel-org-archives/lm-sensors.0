From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 16 Mar 2008 09:53:38 +0000
Subject: Re: [lm-sensors] W83627DHG driver on MSI 975x board
Message-Id: <20080316105338.1ce578c4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1205271362.6571.9.camel@montecristo>
In-Reply-To: <1205271362.6571.9.camel@montecristo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Joakim,

On Thu, 13 Mar 2008 19:44:08 +0100, Joakim Larsson wrote:
> thanks for the hint, Ubuntu Feisty uses lm-sensors 2.10.1 So I compiled
> and installed the latest version (3.0.1) and starts to get some results
> from sensor, see below. I will go through the configuration now and
> figure out why the fan still sounds like my vacuum cleaner.
>=20
> BR
>=20
> Joakim
>=20
>=20
> joakim@montecristo:~$ sensors -v
> sensors version 3.0.1 with libsensors version 3.0.1
> joakim@montecristo:~$ sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
> VCore:       +1.35 V  (min =3D  +0.00 V, max =3D  +1.74 V)  =20
> in1:        +12.46 V  (min =3D  +6.39 V, max =3D  +0.90 V)   ALARM

Probably +12V

> AVCC:        +3.28 V  (min =3D  +0.54 V, max =3D  +2.05 V)   ALARM
> 3VCC:        +3.28 V  (min =3D  +0.66 V, max =3D  +0.00 V)   ALARM
> in4:         +1.86 V  (min =3D  +1.07 V, max =3D  +0.39 V)   ALARM
> in5:         +1.46 V  (min =3D  +1.02 V, max =3D  +0.06 V)   ALARM
> in6:         +5.04 V  (min =3D  +2.59 V, max =3D  +4.12 V)   ALARM

and +5V. If your system uses DDR2 SDRAM, in4 could be Vdimm. in5 could
be Vagp. If I'm right, you can add the following lines to the
w83627dhg-* section in /etc/sensors3.conf:

   label  in1  "+12V"
   label  in4  "Vdimm"
   label  in5  "Vagp"
   label  in6  "+5V"

> VSB:         +3.28 V  (min =3D  +0.02 V, max =3D  +1.60 V)   ALARM
> VBAT:        +3.09 V  (min =3D  +1.58 V, max =3D  +0.32 V)   ALARM

To get rid of the alarms, uncomment the "set in*" statements, adjust
the limits as needed (typically -10% and +10% of the nominal value),
and run "sensors -s".

> Case Fan:      0 RPM  (min =3D  376 RPM, div =3D 64)  ALARM
> CPU Fan:    2481 RPM  (min =3D 2109 RPM, div =3D 16)
> Aux Fan:    1298 RPM  (min =3D  439 RPM, div =3D 16)
> fan4:          0 RPM  (min =3D 8881 RPM, div =3D 4)  ALARM
> fan5:          0 RPM  (min =3D 10227 RPM, div =3D 4)  ALARM

I guess that you have only 2 fans in this system, so you can add:

   ignore fan1
   ignore fan4
   ignore fan5

And change fan3's label:

   label  fan3  "Case Fan"

These are very reasonable fan speeds and I have to admit that I am
surprised the one the fans "sounds like your vacuum cleaner".

> Sys Temp:    +37.0=B0C  (high =3D  +0.0=B0C, hyst =3D +16.0=B0C)  ALARM  =
sensor =3D thermistor
> CPU Temp:    +18.0=B0C  (high =3D +110.0=B0C, hyst =3D +125.0=B0C)  senso=
r =3D diode
> AUX Temp:    +64.0=B0C  (high =3D +120.0=B0C, hyst =3D +115.0=B0C)  senso=
r =3D thermistor

While temp1 and temp3 look reasonable, temp2 is way too low to be
correct. What does the BIOS display? Maybe you need to add some
arbitrary offset.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
