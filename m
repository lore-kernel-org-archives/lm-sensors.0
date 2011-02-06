From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Feb 2011 09:56:29 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110206105629.4c76ddb8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 5 Feb 2011 11:15:25 -0800, Guenter Roeck wrote:
> On Sat, Feb 05, 2011 at 02:00:09PM -0500, Andrea Rizzolo wrote:
> > hi,
> > thank you very much, here on intel DH57JG it works. `sensors` output:
> >=20
> > nct6775-isa-0680
> > Adapter: ISA adapter
> > in0:         +0.93 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:         +0.78 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > in2:         +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > in3:         +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > in4:         +1.26 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > in5:         +0.78 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > in6:         +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > in7:         +3.36 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > in8:         +3.30 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > fan1:          0 RPM  (min =3D    0 RPM, div =3D 2)  ALARM
> > fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)  ALARM
> > fan3:          0 RPM  (min =3D    0 RPM, div =3D 2)  ALARM
> > fan4:          0 RPM  (div =3D 2)  ALARM
> > temp1:       +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM=
  sensor =3D diode
> > temp2:       +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  senso=
r =3D diode
> > temp3:       +23.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  senso=
r =3D thermistor
> > cpu0_vid:   +2.050 V
>
> Hi Andrea,
>=20
> excellent - that matches the output I get. Now all we have to do is to ma=
tch the values
> to actual voltages. in2 and in3 match the 3.3V seen in the BIOS, but for =
the others
> I have no idea.

As for the other chips in this family, in2, in3, in7 and in8 are
internal voltages so their mapping and scaling is fixed. The pin names
also strongly suggest connecting Vcore to in0, and I've never seen a
board manufacturer diverge from this. So you can start with the
following config statements:

chip "nct6775-*" "nct66776-*"

    label in0 "Vcore"
    label in2 "AVCC"
    label in3 "+3.3V"
    label in7 "3VSB"
    label in8 "Vbat"

    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10
    set in3_min  3.3 * 0.90
    set in3_max  3.3 * 1.10
    set in7_min  3.3 * 0.90
    set in7_max  3.3 * 1.10
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.10

This leaves only 4 voltage inputs to configure, presumably for +5V,
+12V, and possibly 5VSB and Vdimm. Check the labels and values in the
BIOS (write them all down if they fluctuate) and maybe we can figure it
out.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
