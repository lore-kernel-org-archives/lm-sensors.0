From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 23 Sep 2012 17:01:21 +0000
Subject: Re: [lm-sensors] Configuration for Foxconn A7GM-S 2.0
Message-Id: <20120923190121.0226340c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20556.55176.173597.530756@freddi.uddeborg>
In-Reply-To: <20556.55176.173597.530756@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 23 Sep 2012 17:39:22 +0200, G=F6ran Uddeborg wrote:
> Jean Delvare:
> >    compure in3  @ * (1 + 6.8 / 10), @ / (1 + 6.8 / 10)
>=20
> That gives me 4.92V, which seems reasonable for the 5V line, yes.
> (Just check the spelling of "compute" before you cut and paste into
> the wiki. :-)

Got it right it the wiki, thankfully :)

> (...)
> I commented out those lines and restarted (with power off for a short
> while).  After that, the limits seems unset:
>=20
>     it8716-isa-0e80
>     Adapter: ISA adapter
>     CPU core:      +1.31 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>=20
> So I assume the BIOS does NOT set anything limits on its own.

Indeed, so doing it in sensors.conf is the right thing to do.

> B.t.w., I enabled in8/Vbat as you suggested.  I don't get any min or
> max values for that sensor.  Not even if I try to explicitly set them
> in the configuration file.  That is normal and reflects the hardware,
> right?

Yes, this is a hardware limitation. I think the non-mandatory character
of Vbat explains this.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
