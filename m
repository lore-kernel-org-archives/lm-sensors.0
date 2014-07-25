From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 25 Jul 2014 18:05:36 +0000
Subject: Re: [lm-sensors] Sensors configuration for Intel D201GLY2 motherboard
Message-Id: <20140725200536.34a6273f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
In-Reply-To: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 25 Jul 2014 18:44:13 +0200, =C9ric Le Bras wrote:
> 2014-07-25 17:45 GMT+02:00 Jean Delvare <jdelvare@suse.de>:
> > On Fri, 25 Jul 2014 15:55:06 +0200, =C9ric Le Bras wrote:
> > > Temp3 has a weird behaviour. It lowers when the CPU load increases. I
> > > enclosed a graph generated with sensord. The curve for temp3 has an
> > > "inversed" profile, compared to other temps.
> >
> > That does not mean it's wrong. You should draw the fan speed together
> > with the temperatures. Higher CPU temperature will typically result in
> > a faster spinning fan, which in turn can lower the temperature of
> > other parts of the system. This is even more likely for a system
> > without a CPU fan where the CPU cooling is achieved by the case fan.
> >
> > 20.5=B0C could well be the ambient temperature inside the case, if case
> > cooling is very good and the room temperature is cool too.
>=20
> Not sure. First the fan is not regulated, so it spins at constant speed.
> Next, I live in southern France, and the room has no AC, so the room
> temperature is approx. 25=B0C today.

I'm there (M=E9rignac) and I agree it's hot today ;-) So my theory doesn't
hold. Feel free to just ignore temp3 then.

> (...)
> For the +12V, I had only one value found on the web (12.084), and I
> observed 2 differents values on the BIOS on my own PC (11.935 and 11.990).
>=20
> The 12V was alterning between the 2 values 11.935 and 11.990, and only one
> of the 3 possibles sensors (in1, in4 and in5) was alterning at the same
> time : in1 (1.736 and 1.744).
>=20
> The site says the atomic measure for the W83627DHG is 8mv. So I tried with
> a divisor of 8, and found that the ratio 55/8 was ok. It gave exactly the
> temperatures displayed by the BIOS when applied to in1.

s/temperatures/voltages/ ;-)

The method used was not the best but your results seem to be correct
nevertheless, in1 must be +12V.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
