From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 11 Oct 2012 03:27:21 +0000
Subject: Re: [lm-sensors] Temperature sensors changed by BIOS update
Message-Id: <20121011032721.GA11825@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <k554s3$g79$1@ger.gmane.org>
In-Reply-To: <k554s3$g79$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Oct 10, 2012 at 07:46:01PM -0500, Ian Pilcher wrote:
> At least I think that the BIOS update is the cause.  (I'm not willing
> to risk downgrading my BIOS to be absolutely sure.)
>=20
> The system in question is an Intel DQ67SW board, using the lm_sensors
> configuration file here:
>=20
>     http://lm-sensors.org/wiki/Configurations/Intel/DQ67SW
>=20
> Today, I noticed that gkrellm was reporting my CPU temperature as
> -128=B0C.  The temperature mappings in that file (which I created about
> 18 months ago) are:
>=20
>     temp1: Memory DIMM Temperature
>     temp2: VR Temperature
>     temp3: Processor Temperature
>     temp4: PCH Temperature
>=20
> It seems that the correct mappings are now:
>=20
>     temp1 (SYSTIN)       : Memory DIMM Temperature (no change)
>     temp2 (CPUTIN)       : VR Temperature (no change)
>     temp3 (AUXTIN)       : (always reports -128=B0C)
>     temp6 (PECI Agent 0) : Processor Temperature
>     temp7 (PCH_CHIP_TEMP): PCH Temperature
>     temp8 (PECI Agent 1) : (always reports 0.0=B0C)
>=20
> temp4 and temp5 don't exist at all!
>=20
Do you use the new nct6775 driver ? Can you provide the complete output of =
the
sensors command ?

> Does it make sense that a BIOS update could have this effect?  If so, I
> guess I'll submit an updated configuration file that's only applicable
> to boards with more recent BIOS revs.
>=20
Could be, if the new BIOS changed the temperature sensor mappings, but I wo=
uld
consider it unlikely. More likely you updated the driver; the new nct6775 d=
river
handles the various sensors on the chip differently.=20

The AUXTIN value suggests that either nothing is connected to the input pin=
, or
that the wrong sensor type (eg diode vs. thermistor) is selected. Most like=
ly nothing
is connected to it. The mappings for temp6/7/8 are pretty common for Intel =
boards.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
