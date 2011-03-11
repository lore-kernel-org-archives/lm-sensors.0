From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 11 Mar 2011 17:47:29 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <20110311174729.GA1481@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Mar 11, 2011 at 12:09:22PM -0500, Robert Kaiser wrote:
> Ian Dobson schrieb:
> > Any chance you can have a look in the BIOS and email the exact values
> > you see there.
>=20
> Right at initial boot of the day I had this there (thought I'd give you=20
> all values and not just voltages, in case other settings warrant a=20
> comparison as well):
>=20
> CPU Fan               1028 RPM
> Front Fan                0 RPM
> Rear Fan                 0 RPM
>=20
> Processor Temperature   61=B0C
> PCH Temperature         43=B0C
> Memory Temperature      24=B0C
> VR Temperature          31=B0C
>=20
> +12.0V               12.23 V
> +5.0V                 5.03 V
> +3.3V                 3.32 V
> Memory Vcc            1.57 V
> Processor Vcc         1.20 V
> PCH Vcc               1.08 V
> +3.3 Standby          3.42 V
>=20
> Now, a few hours later (sorry, didn't get to it right away), sensors=20
> gives me the following:
>=20

My wild guess:

> nct6775-isa-0290
> Adapter: ISA adapter
> Vcore:         +1.16 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:           +1.11 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
	=3D 12V (*11)

> AVCC:          +3.31 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:         +3.31 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:           +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
	=3D 5V (*5)

> in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
	=3D Memory Vcc (*1.5)

> in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
	=3D PCH Vcc

> 3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:          +3.38 V  (min =3D  +2.70 V, max =3D  +3.30 V)   ALARM

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
