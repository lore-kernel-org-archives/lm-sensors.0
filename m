From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 Jan 2012 14:54:37 +0000
Subject: [lm-sensors] [reply+i-2970830-11e203ec4162e4680a3e2c999f2bba9b513a1927-1030448@reply.github.com:
Message-Id: <20120127145437.GB29746@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Forwarding to lm-sensors to keep the group in the loop.

----- Forwarded message from ccom <reply+i-2970830-11e203ec4162e4680a3e2c99=
9f2bba9b513a1927-1030448@reply.github.com> -----

Date: Fri, 27 Jan 2012 09:29:45 -0500
From: ccom <reply+i-2970830-11e203ec4162e4680a3e2c999f2bba9b513a1927-103044=
8@reply.github.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [w83627ehf] Not all fans are shown (#3)

Note that I adapted /etc/sensors3.conf. The output is:

nct6776-isa-0290
Adapter: ISA adapter
VCore:         +0.76 V  (min =3D  +0.00 V, max =3D  +1.74 V)
+12V:         +12.36 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:          +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
+3.3V:         +3.36 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in4:           +0.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
+5V:           +5.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:          +3.46 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
VBat:          +3.30 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
fan1:            0 RPM  (min =3D    0 RPM)  ALARM
fan2:          570 RPM  (min =3D    0 RPM)  ALARM
fan3:            0 RPM  (min =3D    0 RPM)  ALARM
fan4:         1867 RPM  (min =3D    0 RPM)  ALARM
fan5:            0 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:        +35.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D thermistor
CPUTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
AUXTIN:        +35.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
PECI Agent 0:  +36.0=B0C =20
cpu0_vid:     +2.050 V
intrusion0:   ALARM
intrusion1:   ALARM

There's one more thing missing, though. I cannot find a way to set the fan =
speed in the sys-dir.

---=20

You might also want to set min-max values to get rid of the warnings. Fan s=
peeds are set through pwm[1-3].
Did you try to set those ? Chances are that one controls fan2 and another f=
an4; there does not
have to be a direct mapping.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
