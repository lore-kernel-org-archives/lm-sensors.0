From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Feb 2013 14:08:47 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130206150847.17338a50@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 6 Feb 2013 15:00:58 +0100 (CET), Dag Wieers wrote:
> On Wed, 6 Feb 2013, Jean Delvare wrote:
>=20
> > Not good. This can mean one of two things: either the chip has no
> > register 0x3f and it nacks non-existent register read attempts, or it
> > doesn't support SMBus read byte transactions at all. In the latter
> > case, I strongly suggest that you leave the chip alone. As for the
> > former case, there are a few thermal sensor chips which behave like,
> > don't have a register at 0x3f and can use slave address 0x48: DS1621
> > and similar, DS75, LM73.
>=20
> It now consistently returns 0x3d, could this be a thermal value, like 61=
=B0C ?

Could be, but for now all I see is that 0x3d =3D=3D 0x3f - 0x02, i.e. only
one bit changed. You will need to take more samples before you can draw
a conclusion. Also compare when CU is idle and when it's busy.

> The GPU reports 46=B0C (coming from nvidia-smi).

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
