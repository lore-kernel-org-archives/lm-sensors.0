From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 24 Apr 2011 14:57:12 +0000
Subject: Re: [lm-sensors] f71889ed temp alarm polarity reversed.
Message-Id: <4DB43A48.1050802@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3wrikmw1g.fsf@jhcloos.com>
In-Reply-To: <m3wrikmw1g.fsf@jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

On 04/24/2011 12:39 AM, James Cloos wrote:
> As of Linus' v2.6.39-rc4-89-g2f666bc I still get:
>
> fan1:         871 RPM
> fan2:           0 RPM  ALARM
> fan3:           0 RPM  ALARM
> temp1:        +35.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)  ALAR=
M (CRIT)
>                         (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  senso=
r =3D transistor
> temp2:          FAULT  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
>                         (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  senso=
r =3D transistor
> temp3:        +38.0=B0C  (high =3D +255.0=B0C, hyst =3D +253.0=B0C)  ALAR=
M (CRIT)
>                         (crit =3D +255.0=B0C, hyst =3D +253.0=B0C)  senso=
r =3D transistor
>
> The polarity for the fan alarms is correct, but it is reversed for the
> temp alarms.

I just checked the data sheet and it disagrees with your observation. It is
possible that the temp has been outside alarm boundaries before they
were set to their current settings, and the alarm register has never
been read before. Try running the sensors command again (after waiting
a couple of seconds otherwise you will get cached readings).

Or maybe the problem is that 255 gets seen as -1 ? The F71889ED does
have signed values in certain temp registers (but not the alarm thresholds
according to the datasheet). Try writing 100 to the temp#_max and
temp#_crit sysfs attributes, you can find these files under
/sys/class/hwmon#, or /sys/class/hwmon#/device.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
