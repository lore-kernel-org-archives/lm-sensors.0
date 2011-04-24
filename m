From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Apr 2011 15:14:26 +0000
Subject: Re: [lm-sensors] f71889ed temp alarm polarity reversed.
Message-Id: <20110424171426.1e7bff5b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3wrikmw1g.fsf@jhcloos.com>
In-Reply-To: <m3wrikmw1g.fsf@jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 24 Apr 2011 16:57:12 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 04/24/2011 12:39 AM, James Cloos wrote:
> > As of Linus' v2.6.39-rc4-89-g2f666bc I still get:
> >
> > fan1:         871 RPM
> > fan2:           0 RPM  ALARM
> > fan3:           0 RPM  ALARM
> > temp1:        +35.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)  AL=
ARM (CRIT)
> >                         (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sen=
sor =3D transistor
> > temp2:          FAULT  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
> >                         (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sen=
sor =3D transistor
> > temp3:        +38.0=B0C  (high =3D +255.0=B0C, hyst =3D +253.0=B0C)  AL=
ARM (CRIT)
> >                         (crit =3D +255.0=B0C, hyst =3D +253.0=B0C)  sen=
sor =3D transistor
> >
> > The polarity for the fan alarms is correct, but it is reversed for the
> > temp alarms.
>=20
> I just checked the data sheet and it disagrees with your observation. It =
is
> possible that the temp has been outside alarm boundaries before they
> were set to their current settings, and the alarm register has never
> been read before. Try running the sensors command again (after waiting
> a couple of seconds otherwise you will get cached readings).

Note that only the critical limit alarms appear to be set.

> Or maybe the problem is that 255 gets seen as -1 ? The F71889ED does
> have signed values in certain temp registers (but not the alarm thresholds
> according to the datasheet). Try writing 100 to the temp#_max and
> temp#_crit sysfs attributes, you can find these files under
> /sys/class/hwmon#, or /sys/class/hwmon#/device.

Actually value 100000 and directory /sys/class/hwmon/hwmon#,
or /sys/class/hwmon/hwmon#/device. But it may be easier to add:

chip "f71889ed-*"

   set temp1_max   90
   set temp1_crit 100
   set temp3_max   90
   set temp3_crit 100

to /etc/sensors.d/f71889ed.conf and run "sensors -s".

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
