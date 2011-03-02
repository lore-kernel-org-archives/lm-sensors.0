From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Mar 2011 10:12:49 +0000
Subject: Re: [lm-sensors] f75375s detected but no temp output
Message-Id: <20110302111249.3ae811ae@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
In-Reply-To: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 1 Mar 2011 19:46:29 +0100, Pali Roh=E1r wrote:
> 2011/3/1 Jean Delvare <khali@linux-fr.org>:
> > On Tue, 1 Mar 2011 19:19:02 +0100, Pali Roh=E1r wrote:
> >> I commented code ..if ( port =3D 2 ).. there is only
> >>
> >> pI2cAdapter->class =3D I2C_CLASS_HWMON
> >>
> >> so it is called for every port. But sensors still not working :( Any
> >> other hints?
> >
> > Please provide the output of the following command:
> >
> > $ grep . /sys/class/hwmon/hwmon*/{,device/}name
>=20
> grep: /sys/class/hwmon/hwmon*/name: No such file or directory
> /sys/class/hwmon/hwmon0/device/name:k8temp
> /sys/class/hwmon/hwmon1/device/name:it8712
>=20
> >
> > Please also try the following (as root) and see it it helps (assuming
> > i2c-4 always corresponds to the I2C bus where sensors-detect finds the
> > F75375S/SP chip):
> >
> > # echo f75375 0x2e > /sys/bus/i2c/devices/i2c-4/new_device
>=20
> Wow. After running this command sensors start reporting values :)
>=20
> $ sensors
> ...
> f75375-i2c-4-2e
> Adapter: NVIDIA i2c adapter
> in0:         +1.67 V  (min =3D  +0.00 V, max =3D  +2.04 V)
> in1:         +1.01 V  (min =3D  +0.00 V, max =3D  +2.04 V)
> in2:         +1.00 V  (min =3D  +0.00 V, max =3D  +2.04 V)
> in3:         +1.03 V  (min =3D  +0.00 V, max =3D  +2.04 V)
> fan1:       4702 RPM  (min =3D    0 RPM)
> fan2:          0 RPM  (min =3D    0 RPM)
> temp1:       +51.0=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)
> temp2:       +41.0=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)
> ...
>=20
> Thanks a lot! This solved my problem.
>=20
> One question. Is problem in proprietary nvidia driver or in f75375s
> driver (or else)?

Assuming that you did not mess up somewhere on the way and your attempt
to patch the nvidia driver went the way you described, I would suspect
that the nvidia driver now has an alternative way to instantiate I2C
adapters (maybe hardware-driven vs. software bit-banged, I've see it a
lot in video and TV drivers.)

In this case, someone would have to find the new code and patch it in
the same easy was as was done for the original i2c code. This won't be
me though, sorry. I don't want to touch binary driver code for legal
reasons. You could give it a try, it's probably easy.

>  I think that your "hack" is not normal solution...

You are right. But on the other hand, nvidia's binary driver itself is
a hack, not a normal solution, so...

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
