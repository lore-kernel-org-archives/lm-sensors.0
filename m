From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 May 2011 13:38:53 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110512153853.20f2fda9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jeff, Luca,

On Thu, 12 May 2011 15:02:08 +0200, Luca Tettamanti wrote:
> On Wed, May 11, 2011 at 7:59 PM, Jeff Rickman <jrickman@myamigos.us> wrot=
e:
> > [test results]
> > load new i8k module
> >
> > modprobe -v i8k
> > insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko
> > FATAL: Error inserting i8k
> > (/lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko): No =
such
> > device
> >
> > from /var/log/messages
> > May 11 12:39:11 XX kernel: [ =A0263.320306] i8k: unable to get SMM Dell
> > signature
> >
> > modprobe -v i8k force
> > insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko
> > force
> >
> > from /var/log/messages
> > May 11 12:39:11 XX kernel: [ =A0263.320306] i8k: unable to get SMM Dell
> > signature
> > May 11 12:40:52 XX kernel: [ =A0365.019189] i8k: unable to get SMM Dell
> > signature
> > May 11 12:40:52 XX kernel: [ =A0365.020148] i8k: unable to get SMM BIOS
> > version
> > May 11 12:40:52 XX kernel: [ =A0365.027736] Dell laptop SMM driver v1.14
> > 21/02/2005 Massimo Dal Zotto (dz@debian.org)

This is not a fatal error, you may still see interesting things
in /proc/i8k or the output of "sensors". Although Harry's report makes
it unlikely...

> > I will guess that this detection issue is not due to the changes made by
> > Jean and Luca. This module may be at a dead end for my hardware.
>=20
> Hum, maybe my change is not correct. It should be possible to verify
> to functionality of the patch on Harry's machine

Harry already reported:

"This new i8k crashes on my machine, the old one does not."

This suggests that your patch is indeed not correct, however it looks
good to me so I don't know what else to suggest.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
