From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 13 Sep 2008 23:30:56 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <200809140130.56140.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Marco,

Le samedi 13 septembre 2008, Marco Chiappero a =E9crit=A0:
> Marco Chiappero ha scritto:
> > Now, in this board the first one has been replaced by the new Winbond
> > W83667HG and it works thank to the trick of loading the w83627ehf driver
> > with the force_id=3D0x8860 option (but a its own driver is on the way,
> > right?). Starting from kernel 2.6.26 the coretemp driver works fine, but
> > my cpu isn't recognized by sensors-detect ("Sorry, no sensors were
> > detected", with lm-sensors 3.0.0) probably because I own a brand new
> > E8600 Intel CPU which is a E0 revision. I haven't tried lm-sensors 3.0.2
> > though.
> > For what concerns the other two sensors chips I can modprobe the
> > w83781, w83791d, w83792d, w83793 and adt7473 modules but running sensors
> > or sensors-detect shows no new sensors at all. Unfortunately adt7475
> > driver is not the upstream kernels yet.
>=20
> Having some spare time I gave a try to the lastest sensors-detect=20
> patched for the w83667hg and both the coretemp and the new winbond chip=20
> are now detected. I also compiled the adt7475 driver, it loads fine but=20
> no sensors are show/discovered. Maybe is a specific address needed?

Loading random drivers isn't going to help. The two interesting
things are:

* What does sensors-detect see? Unidentified chips on the SMBus at
  addresses typically used by monitoring chips (0x2c-0x2f or
  0x48-0x4f)? Or nothing at all? If unidentified chips are seen then
  we need the output of i2cdump for these chips to find out what
  they are.

* What makes you think there are "two other sensor chips" on the
  board? Can you see them physically on the board?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
