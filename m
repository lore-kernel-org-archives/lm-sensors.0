From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: negative voltages (was Re: [BK PATCH] i2c driver fixes for
Message-Id: <1075719310.401e2c8e3020d@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040202014639.GA21554@earth.solarsys.private>
In-Reply-To: <20040202014639.GA21554@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> There is no bug in the driver, *nor* (I think) in libsensors...

This would explain why I couldn't find any in either place ;)

> Nevermind sensors(1) or libsensors for a moment.  With my w83781d,=20
> I see this:
>=20
> /sys/.../in_max5   =3D> 3.616V
> /sys/.../in_input5 =3D> 3.328V
> /sys/.../in_min5   =3D> 3.264V
>=20
> This scenario shows no alarm, nor should it.  This represents the
> voltage at the pin of the w83781d.  Making no assumptions about what
> in5 is, this is the correct and logical conclusion.

Same observations made on an AS99127F here some times ago.

> Using sensors(1), I see this:
>=20
> -12V:     -11.57 V  (min =3D -11.35 V, max =3D -12.57 V)
>=20
> But it can't be that min > max, so how to fix it?  Since changing the
> driver has been ruled out...

The line above doesn't make me fill sick at all. I personally don't
expect min to be greater than max for a negative voltage.

> If we reverse the sense of min/max in libsensors, that leads to the=20
> undesirable effect of in_max5 modifying /sys/.../in_min5.  But
> worse, what if in5 is a positive voltage on a given board?  Oops, now
> we broke it for them.

Obviously this is the choice that was made in 2.4. I don't know why it
was made however. The incoming trouble was obvious, and I don't see
much benefit, if any.

The problem is, I couldn't find in the 2.4 w83781d driver, nor in
libsensors, nor in sensors, where the min and max are swapped, although
the values are swapped in sensors.conf and it *does* work correctly
with this combination of driver and user-space stuff. Can anyone point
me to the place where the swapping is done?

> If anything, what is needed in sensors.conf is a "negative voltage"
> flag which can signal the situtation to the library so it can be
> handled correctly.

This would mean changing the file format. Much trouble for nothing
IMHO.

> Or, we can just document that min/max are absolute values and be
> done with it.  That would force a review of all 2.4 drivers that
might
> have reversed voltages (are there any?),  but that's my vote...
> comments?

I completely agree with you on this. Chips don't work with negative
voltages internally. Min and max are meant for absolute values. I don't
see why it should trouble the user. It should sound very logical to the
newcomer that -13V is a stronger voltage than -11V, since what matters
are voltage differences, not intrinsic values. Let's stick to that for
the sake of simplicity.

However, I would much like to hear MDS on that topic, because I feel
like we are missing something important. There's an interesting change
in sensors.conf.eg about two years ago with the following log:

----------------------------
revision 1.67
date: 2002/01/31 00:43:14;  author: mds;  state: Exp;  lines: +27 -16
(mds) flip 'set' limits for negative voltages for those chips
      with non-inverting 'compute' lines:
         782d, 783s, 627hf, 697hf, and it87.
      Min should be -12 * 1.05, max is -12 * 0.95, for example.
      Ticket 800 - part 1 of fix.
----------------------------

Link to the above-mentioned ticket:
http://secure.netroedge.com/~lm78/readticket.cgi?ticket=800

Definitely worth reading. This clearly divides the chips in two
categories, which (it says) should be handled differently. I can't
really see why. If we stick to the internal representation used by the
chips, I'd expect no special treatment to be needed.

If the only reason for this mess is so that min is always numerically
less than max in sensors' output, it's not worth the trouble IMHO and
everything should be cleaned up in that respect.

Unless I'm missing something, of course. Any insight appreciated.

--=20
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
