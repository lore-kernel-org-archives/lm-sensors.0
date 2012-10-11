From: Ian Pilcher <arequipeno@gmail.com>
Date: Thu, 11 Oct 2012 00:46:01 +0000
Subject: [lm-sensors] Temperature sensors changed by BIOS update
Message-Id: <k554s3$g79$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

At least I think that the BIOS update is the cause.  (I'm not willing
to risk downgrading my BIOS to be absolutely sure.)

The system in question is an Intel DQ67SW board, using the lm_sensors
configuration file here:

    http://lm-sensors.org/wiki/Configurations/Intel/DQ67SW

Today, I noticed that gkrellm was reporting my CPU temperature as
-128=B0C.  The temperature mappings in that file (which I created about
18 months ago) are:

    temp1: Memory DIMM Temperature
    temp2: VR Temperature
    temp3: Processor Temperature
    temp4: PCH Temperature

It seems that the correct mappings are now:

    temp1 (SYSTIN)       : Memory DIMM Temperature (no change)
    temp2 (CPUTIN)       : VR Temperature (no change)
    temp3 (AUXTIN)       : (always reports -128=B0C)
    temp6 (PECI Agent 0) : Processor Temperature
    temp7 (PCH_CHIP_TEMP): PCH Temperature
    temp8 (PECI Agent 1) : (always reports 0.0=B0C)

temp4 and temp5 don't exist at all!

Does it make sense that a BIOS update could have this effect?  If so, I
guess I'll submit an updated configuration file that's only applicable
to boards with more recent BIOS revs.

Thanks!

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ian Pilcher                                         arequipeno@gmail.com
"Sometimes there's nothing left to do but crash and burn, or die trying"
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
