From: James Cloos <cloos@jhcloos.com>
Date: Sat, 23 Apr 2011 22:39:47 +0000
Subject: [lm-sensors] f71889ed temp alarm polarity reversed.
Message-Id: <m3wrikmw1g.fsf@jhcloos.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

As of Linus' v2.6.39-rc4-89-g2f666bc I still get:

fan1:         871 RPM
fan2:           0 RPM  ALARM
fan3:           0 RPM  ALARM
temp1:        +35.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)  ALARM =
(CRIT)
                       (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sensor =
=3D transistor
temp2:          FAULT  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
                       (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sensor =
=3D transistor
temp3:        +38.0=B0C  (high =3D +255.0=B0C, hyst =3D +253.0=B0C)  ALARM =
(CRIT)
                       (crit =3D +255.0=B0C, hyst =3D +253.0=B0C)  sensor =
=3D transistor

The polarity for the fan alarms is correct, but it is reversed for the
temp alarms.

-JimC
--=20
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
