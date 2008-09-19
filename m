From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Sep 2008 13:29:01 +0000
Subject: Re: [lm-sensors] No Alarm when values not within range
Message-Id: <20080919152901.27db65f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
In-Reply-To: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bjoern,

On Fri, 19 Sep 2008 14:51:03 +0200, Gerhart, Bjoern wrote:
> in my company we use lm_sensors a while now. Now we want to
> update to lm_sensors 3.02 due to a new sensors chip (it8718F) in
> our latest hardware. I already converted the sensors.conf files
> into the new syntax. But now I don't get any alarms any more, no
> matter which sensors chip I use. Here is the output that sensors
> gives:
>=20
> [root@devel etc]# sensors
> pc87366-isa-0fb0
> Adapter: ISA adapter
> -12V:       -12.44 V  (min =3D -13.81 V, max =3D -10.27 V)
> +12V:       +12.10 V  (min =3D +10.71 V, max =3D +12.70 V)
> +5V VCC:     +5.24 V  (min =3D  +4.50 V, max =3D  +5.70 V)
> +1.5V:       +1.51 V  (min =3D  +1.10 V, max =3D  +1.90 V)
> +2.5V:       +2.49 V  (min =3D  +1.90 V, max =3D  +2.95 V)
> +1.3V VID:   +1.31 V  (min =3D  +1.10 V, max =3D  +1.50 V)
> +3.3V VSB:   +3.38 V  (min =3D  +0.00 V, max =3D  +1.00 V)
> +3V VBAT:    +2.95 V  (min =3D  +2.40 V, max =3D  +2.95 V)
> CPU Fan:    2909 RPM  (min =3D 10000 RPM, div =3D 1)
> CPU Temp:    +51.0=B0C  (low  =3D  +0.0=B0C, high =3D  +5.0=B0C)
>                       (crit =3D  +5.0=B0C)
> Chip Temp:   +39.0=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)
>                       (crit =3D +127.0=B0C)
>=20
> The sensors "+3.3V VSB", "CPU Fan" and "CPU Temp" should give
> an alarm, but they don't. What's the reason for this behaviour?

The pc87360 driver, which you are using, is the very last one that has
not yet been converted to the (somewhat new) standard to export alarm
information. This standard is what lm-sensors 3.x uses. Jim Cromie
(Cc'd) has been working on it lately and he has patches that should
implement what you need. I didn't have the time to review these patches
and probably won't have the time to do so in a near future. Maybe you
can give them a try and report.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
